//
//  AppMiddleware.swift
//  SwiftRext
//
//  Created by JaelWizeline on 30/01/25.
//

import Foundation
import SwiftRex

final class PokedexMiddleware: MiddlewareProtocol {
    
    /**
     Este método se usa para inyectar el contexto del middleware.
     Se llama al configurar el middleware en el store, dándote acceso al estado y al despachador de acciones (output).
     
     Puedes usar `getState` para obtener el estado actual de la aplicación y `output` para despachar nuevas acciones.
     */
    private var output: AnyActionHandler<PokedexAction>?
    
    func receiveContext(getState: @escaping GetState<Void>, output: AnyActionHandler<PokedexAction>) {
        self.output = output
    }
    /**
     Primer método (handle(action:from:afterReducer:))
     Recibe la acción (PokedexAction), la fuente del despachador (ActionSource) y un AfterReducer que permite ejecutar acciones después de que el estado haya cambiado.
     Usa output?.dispatch(...) para enviar nuevas acciones.
     
     handle(action:from:afterReducer:) → Se usa para despachar acciones de manera inmediata dentro del Middleware.
     
     */
    
    func handle(action: PokedexAction, from dispatcher: SwiftRex.ActionSource, state: @escaping SwiftRex.GetState<PokedexAppState>) -> SwiftRex.IO<PokedexAction> {
        return IO { output in
            Task {
                switch action {
                case .fetchPokemons:
                    let currentState = state()
                    if currentState.pokemons.isEmpty {
                        do {
                            // Obtener los pokemons
                            let pokemons = try await NetworkManager.shared.fetchPokedexAPI()

                            // Usar un TaskGroup de forma explícita para manejar las solicitudes de manera controlada
                            try await withThrowingTaskGroup(of: PokemonDetail.self) { group in
                                for pokemon in pokemons {
                                    group.addTask {
                                        // Manejar las solicitudes de detalles de cada pokemon
                                        do {
                                            return try await NetworkManager.shared.fetchPokemonDetailsAPI(pokemonName: pokemon.name ?? "")
                                        } catch {
                                            print("Error fetching details for \(pokemon.name ?? ""): \(error.localizedDescription)")
                                            throw error  // Re-lanzar el error para que no se detenga el grupo
                                        }
                                    }
                                }

                                var results: [PokemonDetail] = []
                                for try await result in group {
                                    results.append(result)
                                }

                                // Despachar los resultados una vez que todas las tareas se completen
                                output.dispatch(.postsLoaded(.successDetailsFetch(pokemonDetails: results)))
                            }
                        } catch {
                            // Manejo de errores si ocurre una cancelación o un fallo
                            print("Error fetching pokemons or details: \(error.localizedDescription)")
                            output.dispatch(.postsLoaded(.failFetch(error: error as! PokemonError)))
                        }

                    }

                default:
                    break
                }
            }
        }
    }

}

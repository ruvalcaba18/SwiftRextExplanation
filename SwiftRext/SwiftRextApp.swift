//
//  SwiftRextApp.swift
//  SwiftRext
//
//  Created by JaelWizeline on 30/01/25.
//

import Combine
import CombineRex
import SwiftRex
import RxSwiftRex
import RxSwift
import SwiftUI

@main
struct SwiftRextApp: App {
    
    @StateObject var storeWithCombine = PokedexStore.createStoreWithCombine().asObservableViewModel(initialState: .initial, emitsValue: .always)
    var storeWithRxSwift = PokedexStore.createStoreWithRxSwift()
    

    var body: some Scene {
        WindowGroup {
//            PokedexView(viewModelWithEnum: PokedexViewModel.viewModel(from: storeWithCombine))
            PokedexView(normalViewModel: NormalPokedexViewModel(store: storeWithCombine))
        }
        
    }
}

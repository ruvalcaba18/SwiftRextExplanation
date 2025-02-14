//
//  Cache.swift
//  SwiftRext
//
//  Created by JaelWizeline on 10/02/25.
//

import Foundation

final class ImageCacheRetriever {
    
    typealias CacheType = NSCache<NSString,NSData>
    static let shared = ImageCacheRetriever()
    
    private init() { }
    
    private lazy var cache: CacheType = {
        let cache = CacheType()
        cache.countLimit = 100
        cache.totalCostLimit = 50 * 1024 * 1024
        return cache
    }()
    
    public func getObject(forKey key: NSString) -> Data? {
        return cache.object(forKey: key) as? Data
    }
    
    public func setObject(object :NSData, forkey key:NSString) {
        cache.setObject(object, forKey: key)
    }
}

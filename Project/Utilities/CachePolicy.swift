//
//  CachePolicy.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import UIKit
import Kingfisher

final class CachePolicy {
    static let shared = CachePolicy()

    let imageCache: ImageCache
    let responseCache: URLCache

    // MARK: - for cache policy (Image)
    private let customComponent = "Images"
    private let imageCacheLimitSize: UInt = 90 * 1024 * 1024 // 90MB

    // MARK: - for cache policy (Response)
    private let responseCacheLimitSize = 10 * 1024 * 1024 // 10MB
    private let folderName = "HTTPCache"

    private init() {
        do {
            let cachePath = try FileManager.default.url(
                for: .cachesDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            ).appendingPathComponent(customComponent)
            imageCache = try ImageCache(name: customComponent, cacheDirectoryURL: cachePath)
            imageCache.diskStorage.config.sizeLimit = imageCacheLimitSize
            imageCache.diskStorage.config.expiration = .never
        } catch let error {
            print("ImageCache error: \(error)")
            imageCache = .default
        }

        if #available(iOS 13.0, *) {
            let cachePath = try? FileManager.default.url(
                for: .cachesDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            ).appendingPathComponent(folderName)
            responseCache = URLCache(memoryCapacity: 0, diskCapacity: responseCacheLimitSize, directory: cachePath)
        } else {
            responseCache = URLCache(memoryCapacity: 0, diskCapacity: responseCacheLimitSize, diskPath: folderName)
        }
    }

}

extension CachePolicy {
    func clearCacheDirectory() {
        do {
            let cachePath = try FileManager.default.url(
                for: .cachesDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
            try FileManager.default.removeItem(at: cachePath)
        } catch let error {
            print("Clear cache error: \(error)")
        }
    }
}

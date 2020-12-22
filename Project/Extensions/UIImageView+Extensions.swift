//
//  UIImageView+Extensions.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(
        with resource: Kingfisher.Resource?,
        placeholder: Kingfisher.Placeholder? = nil,
        options: Kingfisher.KingfisherOptionsInfo? = nil,
        progressBlock: Kingfisher.DownloadProgressBlock? = nil
    ) {
        var targetOptions: Kingfisher.KingfisherOptionsInfo = options ?? []

        // MARK: - normally add targetCache
        targetOptions.append(.targetCache(CachePolicy.shared.imageCache))

        self.kf.setImage(with: resource, placeholder: placeholder, options: targetOptions, progressBlock: progressBlock)
    }
}

//
//  UIImageView.swift
//  kiddoing
//
//  Created by Donelkys Santana on 1/16/23.
//

import UIKit
import Photos

extension UIImageView {
	func fetchImageAsset(_ asset: PHAsset?, targetSize size: CGSize, contentMode: PHImageContentMode = .aspectFill, options: PHImageRequestOptions? = nil, completionHandler: ((Bool) -> Void)?) {
		completionHandler?(false)
	}
}

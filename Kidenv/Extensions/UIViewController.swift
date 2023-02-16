//
//  UIViewController.swift
//  kiddoing
//
//  Created by Donelkys Santana on 11/13/22.
//

import UIKit

extension UIViewController {
	func removeContainer() {
		self.willMove(toParent: nil)
		self.removeFromParent()
		self.view.removeFromSuperview()
	}
	
	func addImageBackground(imageName: String? = nil) {
		if let imageBackground = UIImage(named: imageName ?? GlobalStrings.WallpapersImages.backgroundImage) {
			UIGraphicsBeginImageContext(self.view.frame.size)
			imageBackground.draw(in: self.view.bounds)
			let image = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
			if let image = image {
				self.view.backgroundColor = UIColor(patternImage: image)
			}
		}
	}
}

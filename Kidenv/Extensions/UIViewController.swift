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
}

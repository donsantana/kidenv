//
//  UILabel.swift
//  Kidenv
//
//  Created by Donelkys Santana on 2/17/23.
//

import UIKit

extension UILabel {
	func addTutorialStyle() {
		self.textAlignment = .center
		self.clipsToBounds = true
		self.numberOfLines = 3
		self.layer.cornerRadius = 10
		self.font = UIFont(name: "Helvetica Neue", size: 21)
		self.textColor = AppColors.secondaryColor
		self.backgroundColor = .white
	}
}

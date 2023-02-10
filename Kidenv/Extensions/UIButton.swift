//
//  UIButton.swift
//  kiddoing
//
//  Created by Donelkys Santana on 2/5/23.
//

import UIKit

extension UIButton{
	func addBorder() {
		self.layer.borderWidth = 1
		self.layer.cornerRadius = 5
		self.layer.borderColor = UIColor.red.cgColor
	}
	
	func addUnderline() {
		guard let text = self.titleLabel?.text else { return }
		
		let attributedString = NSMutableAttributedString(string: text)
		attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
		
		self.setAttributedTitle(attributedString, for: .normal)
	}
}

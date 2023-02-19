//
//  Alert.swift
//  Kidenv
//
//  Created by Donelkys Santana on 2/19/23.
//

import UIKit


struct Alert {
	
	private static func show(title: String, message: String, vc: UIViewController, withActions actions: [UIAlertAction]?, preferredStyle: UIAlertController.Style? = .alert) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle ?? .alert)
		if let actions = actions {
			for action in actions {
				alert.addAction(action)
			}
		} else {
			let action = UIAlertAction(title: GlobalStrings.BtnStrings.okTitle, style: .default) { _ in
			
			}
			alert.addAction(action)
		}
		
		DispatchQueue.main.async {
			vc.present(alert, animated: true, completion: nil)
		}
	}
	
	static func showBasic(title: String, message: String, vc: UIViewController, withActions actions: [UIAlertAction]?) {
		show(title: title, message: message, vc: vc, withActions: actions)
	}
	
	static func showActionSheet(title: String, message: String, vc: UIViewController, withActions actions: [UIAlertAction]?) {
		let cancelButton = UIAlertAction(title: GlobalStrings.BtnStrings.cancelTitle, style: .cancel, handler: {alerAction in

		})
		var actionsSheets = actions
		actionsSheets?.append(cancelButton)
		
		show(title: title, message: message, vc: vc, withActions: actionsSheets, preferredStyle: .actionSheet)
	}
	
}


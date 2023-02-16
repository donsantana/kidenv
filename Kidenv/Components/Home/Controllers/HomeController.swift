//
//  ViewController.swift
//  kiddoing
//
//  Created by Donelkys Santana on 10/15/22.
//

import UIKit
import PhotosUI

struct MenuElement {
	var imageName,name: String
}

@available(iOS 14.0, *)
class HomeController:  UIViewController, PHPickerViewControllerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
	
	let menuElements:[MenuElement] = [MenuElement(imageName: "showBtn", name: "show"), MenuElement(imageName: "shotBtn", name: "shot"), MenuElement(imageName: "videoBtn", name: "video"), MenuElement(imageName: "settingsBtn", name: "settings")]

	@IBOutlet weak var homeStackView: UIStackView!
	@IBOutlet weak var showTutorialBtn: UIButton!
	@IBOutlet weak var menuCollectionView: UICollectionView!
	@IBOutlet weak var backgroundImage: UIImageView!

	lazy var btnsStackView: UIStackView = {
		let btnsStackView = UIStackView()
		btnsStackView.distribution = .fillEqually
		return btnsStackView
	}()
	
	override func viewDidLoad() {
		menuCollectionView.delegate = self
		initUI()
		if UIAccessibility.isGuidedAccessEnabled {
			print("Request guided access success \(UIAccessibility.isGuidedAccessEnabled)")
		} else {
			UIAccessibility.requestGuidedAccessSession(enabled: true) {
					success in
				print("Request guided access success \(success)")
				HomeController.configureForGuidedAccess(features: UIGuidedAccessAccessibilityFeature.assistiveTouch, enabled: true, completionHandler: { _,_  in
					
				})
			}
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.setNavigationBarHidden(true, animated: false)
	}
	
//	override func viewDidDisappear(_ animated: Bool) {
//		navigationController?.setNavigationBarHidden(false, animated: false)
//	}
	
	static func configureForGuidedAccess(
			features: UIGuidedAccessAccessibilityFeature,
			enabled: Bool,
			completionHandler completion: @escaping (Bool, Error?) -> Void
	){}

	@IBAction func showTutorialView(_ sender: Any) {
		showTutorialScreen()
	}
	
}


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
	
	let appStoreService = AppStoreService.shared
	
	let menuElements:[MenuElement] = [MenuElement(imageName: "showBtn", name: "show"),
                                      MenuElement(imageName: "shotBtn", name: "shot"),
                                      MenuElement(imageName: "videoBtn", name: "video"),
                                      MenuElement(imageName: "drawingBtn", name: "drawing"),
                                      MenuElement(imageName: "settingsBtn", name: "settings")]

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
		appStoreService.delegate = self
		checkForNewVersions()
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
	
	static func configureForGuidedAccess(
			features: UIGuidedAccessAccessibilityFeature,
			enabled: Bool,
			completionHandler completion: @escaping (Bool, Error?) -> Void
	){}

	@IBAction func showTutorialView(_ sender: Any) {
		showTutorialScreen()
	}
	
}

extension HomeController: AppStoreServiceDelegate {
	func appStoreResponse(_ controller: AppStoreService, checkNewVersion isAvailable: Bool) {
		DispatchQueue.main.async {
			let okBtn = UIAlertAction(title: GlobalStrings.BtnStrings.yesTitle, style: .default, handler: {alerAction in
				UIApplication.shared.open(URL(string: GlobalStrings.Urls.itunesURL)!)
			})
			let noBtn = UIAlertAction(title: GlobalStrings.BtnStrings.noTitle, style: .default, handler: {alerAction in
				
			})
			Alert.showBasic(title: GlobalStrings.appVersionTitle, message: GlobalStrings.appVersionMessage, vc: self, withActions: [okBtn, noBtn])
		}
	}
}


//
//  HomeFunctionsExt.swift
//  kiddoing
//
//  Created by Donelkys Santana on 10/15/22.
//

import UIKit
import PhotosUI

@available(iOS 14.0, *)
extension HomeController {
	
	internal func initUI() {
		overrideUserInterfaceStyle = .light
		showTutorialBtn.setTitle(GlobalStrings.showTutorialTitle, for: .normal)
		addImageBackground()
		setBackgroundImage()
	}
	
	internal func setBackgroundImage() {
		if let preferredCartoon = AppConfig().preferredCartoon {
			backgroundImage.image = UIImage(named: preferredCartoon.rawValue)
		} else {
			backgroundImage.image = UIImage(named: GlobalStrings.WallpapersImages.defaultImage)
		}
	}
	
	@objc internal func openCamera() {
		let storyboard = UIStoryboard(name: "PhotoShot", bundle: nil)
		let cameraVC = storyboard.instantiateViewController(withIdentifier:
		"PhotoShot")

		navigationController?.pushViewController(cameraVC, animated: true)
	}
	
	internal func openPhotoGallery() {
		pickLibraryMedia(.images)
	}
	
	internal func openVideoGallery() {
		pickLibraryMedia(.videos)
	}
	
	func verifyCameraAccess() -> Bool {
		return UIImagePickerController.isSourceTypeAvailable(.camera)
	}
	
	func verifyPhotoLibraryAccess() -> Bool {
		return UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
	}
	
	func showWallpaperScreen() {
		let storyboard = UIStoryboard(name: "Wallpaper", bundle: nil)
		let wallpaperViewController = storyboard.instantiateViewController(withIdentifier: "wallpaperViewController") as! WallpaperViewController
		self.addChild(wallpaperViewController)
		self.view.addSubview(wallpaperViewController.view)
	}
	
	func showTutorialScreen() {
		let tutorialViewController = storyboard?.instantiateViewController(withIdentifier: "tutorialViewController") as! TutorialViewController
		self.addChild(tutorialViewController)
		self.view.addSubview(tutorialViewController.view)
	}
	
	func checkForNewVersions() {
		appStoreService.checkNewVersionAvailable()
	}
	
	// MARK: - PHPickerViewController
	
	internal func pickLibraryMedia(_ type: PHPickerFilter) {
		var config = PHPickerConfiguration()
		//	config.selectionLimit = nil
		config.filter = type
		if #available(iOS 15, *) {
			//var pickerSelected = PHPickerConfigurationSelection(rawValue: 5)
		} else {
			// Fallback on earlier versions
		}
		
		let pickerViewController = PHPickerViewController(configuration: config)
		pickerViewController.navigationItem.hidesBackButton = true

		let backBtn = UIBarButtonItem(image: UIImage(named: "barCloseBtn"), style: .plain, target: self, action: #selector(backBtnAction))
		pickerViewController.navigationItem.setRightBarButton(backBtn, animated: false)
		pickerViewController.delegate = self
		navigationController?.setNavigationBarHidden(false, animated: false)
		navigationController?.show(pickerViewController, sender: nil)
	}
	
	@objc internal func backBtnAction() {
		guard let vc = storyboard?.instantiateViewController(withIdentifier: "HomeView") as? HomeController else {return}
		navigationController?.pushViewController(vc, animated: true)
	}
	
	// MARK: PHPickerViewControllerDelegate
	func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
		//picker.dismiss(animated: true, completion: nil)
		if results.count > 0 {
			for result in results {
				if picker.configuration.filter == .videos {
					let prov = result.itemProvider
					prov.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { url, err in
						let storyboard = UIStoryboard(name: "PhotoShow", bundle: nil)
						DispatchQueue.main.sync {
							if let url = url, let vc = storyboard.instantiateViewController(withIdentifier: "PhotoPreview") as? PhotoPreviewController  {
								vc.videoUrl = url
								self.present(vc, animated: true)
							}
						}
					}
				} else {
					result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
						DispatchQueue.main.async { [self] in
							let storyboard = UIStoryboard(name: "PhotoShow", bundle: nil)
							if let image = object as? UIImage, let vc = storyboard.instantiateViewController(withIdentifier: "PhotoPreview") as? PhotoPreviewController {
								vc.image = image
								self.present(vc, animated: true)
							}
						}
					})
				}
			}
		} else {
			guard let vc = storyboard?.instantiateViewController(withIdentifier: "HomeView") as? HomeController else {return}
			navigationController?.pushViewController(vc, animated: true)
		}
	}

	func activateGuideAccess() {
		UIAccessibility.requestGuidedAccessSession(enabled: false, completionHandler: { succeeded in
			guard succeeded else {return}
			print("activate")
		})
	}
}

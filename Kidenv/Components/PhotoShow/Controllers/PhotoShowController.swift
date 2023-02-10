//
//  PhotoShowController.swift
//  kiddoing
//
//  Created by Donelkys Santana on 10/23/22.
//

import UIKit
import Photos
import PhotosUI

@available(iOS 14.0, *)
class PhotoShowController: UIViewController, PHPickerViewControllerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		pickPhotos()
	}
	
	// MARK: - PHPickerViewController
	
	@objc func pickPhotos() {
		var config = PHPickerConfiguration()
		//	config.selectionLimit = nil
		config.filter = .images
		
		let pickerViewController = PHPickerViewController(configuration: config)
		pickerViewController.delegate = self
		navigationController?.show(pickerViewController, sender: nil)
	}
	
	// MARK: PHPickerViewControllerDelegate
	func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
		picker.dismiss(animated: true, completion: nil)
		
		for result in results {
			result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
				DispatchQueue.main.async { [self] in
					if let image = object as? UIImage, let vc = self.storyboard?.instantiateViewController(withIdentifier: "PhotoPreview") as? PhotoPreviewController {
						vc.image = image
						
						self.present(vc, animated: true)
					}
				}
			})
		}
	}
	
}

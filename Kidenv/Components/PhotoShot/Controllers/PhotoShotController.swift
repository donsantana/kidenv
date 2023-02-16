//
//  PhotoShotController.swift
//  kiddoing
//
//  Created by Donelkys Santana on 10/15/22.
//

import UIKit

class PhotoShotController: UIViewController {
	
	var camaraController: UIImagePickerController!
	
	@IBOutlet weak var imagePreview: UIImageView!
	
	override func viewDidLoad() {
		self.camaraController = UIImagePickerController()
		self.camaraController.delegate = self
		openCamera()
		initUI()
	}
	
	func initUI() {
		addImageBackground()
	}
	
	func openCamera() {
		self.camaraController.sourceType = .camera
		self.camaraController.cameraCaptureMode = .photo
		self.camaraController.cameraDevice = .front
		self.present(self.camaraController, animated: true, completion: nil)
	}
	
	func goToHomeScreen() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		guard let vc = storyboard.instantiateViewController(withIdentifier: "HomeView") as? HomeController else {return}
		navigationController?.pushViewController(vc, animated: true)
	}
	
	@available(iOS 14.0, *)
	@IBAction func closeBtn(_ sender: Any) {
		goToHomeScreen()
	}
	
}

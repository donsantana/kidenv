//
//  PhotoShotDelegateExt.swift
//  kiddoing
//
//  Created by Donelkys Santana on 10/23/22.
//

import UIKit



extension PhotoShotController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		// Local variable inserted by Swift 4.2 migrator.
		let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
		
		self.camaraController.dismiss(animated: true, completion: nil)
		let photoPreview = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
		imagePreview.image = photoPreview
		imagePreview.contentMode = .scaleAspectFit
	}
	
	
	//RENDER IMAGEN
	func saveImageToFile(_ image: UIImage) -> URL
	{
		let filemgr = FileManager.default
		
		let dirPaths = filemgr.urls(for: .documentDirectory,
																in: .userDomainMask)
		
		let fileURL = dirPaths[0].appendingPathComponent(image.description)
		
		if let renderedJPEGData =
			image.jpegData(compressionQuality: 0.5) {
			try! renderedJPEGData.write(to: fileURL)
		}
		
		return fileURL
	}
}
// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}

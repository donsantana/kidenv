//
//  CallSimulatorViewController.swift
//  Kidenv
//
//  Created by Donelkys Santana on 4/13/23.
//

import UIKit
import Contacts
import ContactsUI

class CallSimulatorController: UIViewController {
	var contactService = ContactService.shared
	var contactList: [Contact] = [] {
		didSet {
			DispatchQueue.main.async {
				self.contactCollectionView.reloadData()
			}
		}
	}

	@IBOutlet weak var contactCollectionView: UICollectionView!
	@IBOutlet weak var contactPreview: UIView!
	@IBOutlet weak var contactImage: UIImageView!
	@IBOutlet weak var sadFaceImage: UIImageView!
	
	override func viewDidLoad() {
		contactService = ContactService()
		contactService.delegate = self
		contactCollectionView.delegate = self
		addImageBackground()
		fetchContacts()
		self.navigationController?.setNavigationBarHidden(true, animated: false)
	
	}
	
	func fetchContacts() {
		DispatchQueue.global().async {
			self.contactService.fetchContacts()
		}
	}
	
	@IBAction func closeCallView(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		guard let vc = storyboard.instantiateViewController(withIdentifier: "HomeView") as? HomeController else {return}
		navigationController?.pushViewController(vc, animated: true)
	}
	
	@IBAction func closeContactView(_ sender: Any) {
		contactPreview.isHidden = true
	}
	
	@IBAction func endedCallView(_ sender: Any) {
		contactPreview.isHidden = true
	}
	
}

extension CallSimulatorController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return contactList.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactCell",for: indexPath) as! ContactCell
		cell.layer.cornerRadius = 20
		if let image = UIImage(data: contactList[indexPath.row].thumbnailImage) {
			cell.image.image = image.scalePreservingAspectRatio(targetSize: cell.layer.preferredFrameSize())
		}
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let cellWidthSize = UIScreen.main.bounds.width / 1.3
		return CGSize(width: cellWidthSize, height: cellWidthSize)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		contactImage.image = UIImage(data: contactList[indexPath.row].imageData)
		contactPreview.addImageBackground()
		contactPreview.isHidden = false
	}
	
}

//MARK: - CNContactPickerDelegate

extension CallSimulatorController: ContactServiceDelegate {
	func contactRequest(_ controller: ContactService, contactRequest response: [Contact]) {
		DispatchQueue.main.async {
			self.sadFaceImage.isHidden = response.count > 0
		}
		self.contactList = response
	}
}

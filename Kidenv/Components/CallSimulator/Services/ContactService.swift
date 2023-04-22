//
//  ContactService.swift
//  Kidenv
//
//  Created by Donelkys Santana on 4/14/23.
//


import Foundation
import Contacts


protocol ContactServiceDelegate: AnyObject {
	func contactRequest(_ controller: ContactService, contactRequest response: [Contact])
}

final class ContactService {
	static let shared = ContactService()
	var contacts: [Contact] = []
	weak var delegate: ContactServiceDelegate?

	func fetchContacts() {
			// 1.
			let store = CNContactStore()
		store.requestAccess(for: .contacts) { [self] (granted, error) in
					if let error = error {
							print("failed to request access", error)
							return
					}
					if granted {
							// 2.
							let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactImageDataKey, CNContactImageDataAvailableKey,CNContactThumbnailImageDataKey]
							let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
							do {
									// 3.
									try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
										if let image = contact.imageData, let thumbnailImage = contact.thumbnailImageData {
											self.contacts.append(Contact(firstName: contact.givenName, lastName: contact.familyName, imageData: image,thumbnailImage: thumbnailImage))
										}
									})
								self.delegate?.contactRequest(self, contactRequest: self.contacts)
							} catch let error {
									print("Failed to enumerate contact", error)
							}
					} else {
							print("access denied")
					}
			}
	}
	
}


//
//  Contact.swift
//  Kidenv
//
//  Created by Donelkys Santana on 4/13/23.
//

import UIKit

struct Contact {
	var firstName: String
	var lastName: String
	var imageData,thumbnailImage: Data
	
	
	init(firstName: String, lastName: String, imageData: Data, thumbnailImage: Data) {
		self.firstName = firstName
		self.lastName = lastName
		self.imageData = imageData
		self.thumbnailImage = thumbnailImage
	}
	
}

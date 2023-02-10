//
//  HomeCollectionExt.swift
//  kiddoing
//
//  Created by Donelkys Santana on 11/22/22.
//

import UIKit


@available(iOS 14.0, *)
extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
	//COLLECTION VIEW FUNCTION
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return menuElements.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuElementCell",for: indexPath) as! MenuElementCell
		cell.image.image = UIImage(named: menuElements[indexPath.row].imageName)
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		collectionViewLayout.invalidateLayout()
		let cellWidthSize = UIScreen.main.bounds.width / 4
		return CGSize(width: cellWidthSize, height: cellWidthSize)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		switch indexPath.row {
		case 0:
			openPhotoGallery()
		case 1:
			openCamera()
		case 2:
			openVideoGallery()
		case 3:
			//showWallpaperScreen()
			showTutorialScreen()
		default:
			break
		}
	}
	
}

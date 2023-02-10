//
//  WallpaperViewController.swift
//  kiddoing
//
//  Created by Donelkys Santana on 2/5/23.
//

import UIKit

class WallpaperViewController: UIViewController {
	var wallpaperImagesNames: [String] = [GlobalStrings.WallpapersImages.defaultImage,GlobalStrings.WallpapersImages.mickeyImage,GlobalStrings.WallpapersImages.minieImage,GlobalStrings.WallpapersImages.minionsImage]
	var frame = CGRect.zero

	lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		return scrollView
	}()
	
	@IBOutlet weak var wallpaperContentView: UIView!
	@IBOutlet weak var wallpaperPageControll: UIPageControl!
	
	@IBOutlet weak var checkBtn: UIButton!
	
	override func viewDidLoad() {
		scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.height - 150))
		scrollView.delegate = self
		scrollView.isPagingEnabled = true
		scrollView.showsHorizontalScrollIndicator = false
		wallpaperPageControll.numberOfPages = wallpaperImagesNames.count
		setUpScreen()
	}
	
	func setUpScreen() {
		for index in 0..<wallpaperImagesNames.count {
			// 1.
			frame.origin.x = scrollView.bounds.size.width * CGFloat(index)
			frame.size = scrollView.bounds.size
			scrollView.contentMode = .center
			
			// 2.
			let imgView = UIImageView(frame: frame)
			imgView.contentMode = .scaleAspectFit
			imgView.image = UIImage(named: wallpaperImagesNames[index])

			self.scrollView.addSubview(imgView)
			
			checkBtn.addShadow()
		}
		
		// 3.
		scrollView.contentSize = CGSize(width: (scrollView.bounds.size.width * CGFloat(wallpaperImagesNames.count)), height: scrollView.bounds.size.height)
		wallpaperContentView.addSubview(scrollView)
	}
	
	@IBAction func closeView(_ sender: Any) {
		removeContainer()
	}
	
	
}


extension WallpaperViewController: UIScrollViewDelegate {
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
			let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
			wallpaperPageControll.currentPage = Int(pageNumber)
	}
}

//
//  TutorialViewController.swift
//  kiddoing
//
//  Created by Donelkys Santana on 11/12/22.
//

import UIKit

class TutorialViewController: UIViewController {
	
	var tutorialImagesNames: [String] = [GlobalStrings.settingsBtnTitle,GlobalStrings.accessibilityBtnTitle,GlobalStrings.guideAccessBtnTitle,GlobalStrings.passcodeBtnTitle,GlobalStrings.passcodeScreenBtnTitle,GlobalStrings.deviceSwitchBtnTitle]
	var frame = CGRect.zero

	lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		return scrollView
	}()
	
	@IBOutlet weak var tutorialContentView: UIView!
	@IBOutlet weak var tutorialPageControll: UIPageControl!
	
	override func viewDidLoad() {
		//
		scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.height - 150))
		scrollView.delegate = self
		scrollView.isPagingEnabled = true
		scrollView.showsHorizontalScrollIndicator = false
		tutorialPageControll.numberOfPages = tutorialImagesNames.count
		setUpScreen()
	}
	
	func setUpScreen() {
		for index in 0..<tutorialImagesNames.count {
			// 1.
			frame.origin.x = scrollView.bounds.size.width * CGFloat(index)
			frame.size = scrollView.bounds.size
			scrollView.contentMode = .center
			
			// 2.
			let imgView = UIImageView(frame: frame)
			imgView.contentMode = .scaleAspectFit
			imgView.image = UIImage(named: tutorialImagesNames[index])
			
			

			self.scrollView.addSubview(imgView)
		}
		
		// 3.
		scrollView.contentSize = CGSize(width: (scrollView.bounds.size.width * CGFloat(tutorialImagesNames.count)), height: scrollView.bounds.size.height)
		tutorialContentView.addSubview(scrollView)
	}
	
	@IBAction func closeView(_ sender: Any) {
		removeContainer()
	}
	
}

extension TutorialViewController: UIScrollViewDelegate {
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
			let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
			tutorialPageControll.currentPage = Int(pageNumber)
	}
}

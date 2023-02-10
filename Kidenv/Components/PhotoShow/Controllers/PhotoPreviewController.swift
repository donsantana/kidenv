//
//  PhotoPreviewController.swift
//  kiddoing
//
//  Created by Donelkys Santana on 1/16/23.
//

import UIKit
import AVFoundation
import Photos
import PhotosUI

@available(iOS 14.0, *)
class PhotoPreviewController: UIViewController {
	private var playerItem: AVPlayerItem!
	var player: AVPlayer!
	var image: UIImage?
	var videoUrl: URL?
	
	var playerView: UIView!
	lazy var playBtn: UIButton = {
		let btn = UIButton()
		btn.setImage(UIImage(named:"videoBtn"), for: .normal)
		btn.isHidden = true
		return btn
	}()
	
	let videoNotificationCenter = NotificationCenter.default
	// Observer should always be set
	var playerObserver: NSKeyValueObservation?
	
	@IBOutlet weak var imageView: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		showImage()
		initUI()
		if let _ = videoUrl {
			initPlayerView()
		}
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		videoNotificationCenter.removeObserver(NSNotification.Name.AVPlayerItemDidPlayToEndTime)
		playerObserver?.invalidate()
	}
	
	func showImage() {
		guard let image = image else {return}
		imageView.contentMode = .scaleAspectFit
		imageView.image = image
	}
	
	internal func initUI() {
		let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
		swipeLeftGesture.direction = .left
		self.view.addGestureRecognizer(swipeLeftGesture)
		
		let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
		swipeRightGesture.direction = .right
		self.view.addGestureRecognizer(swipeRightGesture)
	}
	
	internal func initPlayerView() {

		do {
			try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
			try AVAudioSession.sharedInstance().setActive(true)
		}
		catch {
			
		}
		
		playerView = UIView()
		//playerView.backgroundColor = .white
			imageView.addSubview(playerView)
		playerView.translatesAutoresizingMaskIntoConstraints = false
		playerView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
		playerView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
		playerView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1).isActive = true
		playerView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
		playVideo()
		
		playBtn.addTarget(self, action: #selector(startPlayingVideo), for: .touchUpInside)
		view.addSubview(playBtn)
		playBtn.translatesAutoresizingMaskIntoConstraints = false
		playBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		playBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		playBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
		playBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
		// handle video end
		videoNotificationCenter.addObserver(self, selector: #selector(videoEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
		observePlayer(playerItem)
	}
	
	func playVideo() {
		guard let url = videoUrl else {return}
		playerItem = AVPlayerItem(url: url)
		player = AVPlayer(playerItem: playerItem)
		let playerLayer = AVPlayerLayer(player: player)
		
		playerLayer.frame = CGRect(x: imageView.frame.origin.x, y: imageView.frame.origin.y, width: view.frame.width, height: imageView.frame.height)
		playerLayer.videoGravity = .resizeAspectFill
		playerView.layer.addSublayer(playerLayer)
		player.volume = 1
		player.play()
	}
	
	@objc internal func startPlayingVideo() {
		self.playBtn.isHidden = true
		player.play()
	}
	
	// MARK: - PHPickerViewController
	internal func pickPhotos() {
		dismiss(animated: true)
	}
	
	@objc func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
		pickPhotos()
	}
	
	// Observes when the player item is ready to play and handles automatic play back
	private func observePlayer(_ playerItem: AVPlayerItem) {
		playerObserver = playerItem.observe(\AVPlayerItem.status) { [weak self] (playerItem, _) in
			if playerItem.status == .readyToPlay {
				self?.player.play()
			}
		}
	}
	
	@objc private func videoEnded() {
		playerItem.seek(to: CMTime.zero) { (finished) in
			if finished {
				OperationQueue.main.addOperation { [weak self] in
					self?.playBtn.isHidden = false
				}
			}
		}
	}
	
	@IBAction func closeBtn(_ sender: Any) {	
		pickPhotos()
	}
	
}

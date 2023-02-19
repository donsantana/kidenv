//
//  AppStoreService.swift
//  Kidenv
//
//  Created by Donelkys Santana on 2/19/23.
//

import Foundation

protocol AppStoreServiceDelegate: AnyObject {
	func appStoreResponse(_ controller: AppStoreService, checkNewVersion isAvailable: Bool)
}

class AppStoreService {
	static let shared = AppStoreService()
	weak var delegate: AppStoreServiceDelegate?
	
	func checkNewVersionAvailable() {
		var request = URLRequest(url: URL(string: GlobalStrings.Urls.storeBundleURL)!)
		request.httpMethod = "GET"
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		let session = URLSession.shared
		let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
			
			guard let data = data else {
				print(String(describing: error))
				return
			}
			
			let appInfo = ItunesAppInfo(data: data)
			let appStoreVersion = appInfo?.results?.first?.version ?? "0.0"
			if let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
				if appStoreVersion > currentVersion {
					GlobalVariables.newVersionAvailable = true
					self.delegate?.appStoreResponse(self, checkNewVersion: true)
				}
			}
		})
		
		task.resume()
	}
}

extension AppStoreService {
	func appStoreResponse(_ controller: AppStoreService, checkNewVersion isAvailable: Bool) {}
}

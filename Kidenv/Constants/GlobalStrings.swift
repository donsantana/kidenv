//
//  GlobalStrings.swift
//  kiddoing
//
//  Created by Donelkys Santana on 11/13/22.
//

import Foundation

struct GlobalStrings {
	static let showTutorialTitle: String = NSLocalizedString("How to prevent go out from Kidenv?",comment:"")
	static let showTutorialHeader: String = NSLocalizedString("Please follow this tutorial\n to activate Guided Access.\n Swipe to right.->",comment:"")
	///Buttons images
	static let settingsBtnTitle: String = NSLocalizedString("settings",comment:"")
	static let accessibilityBtnTitle: String = NSLocalizedString("accessibility",comment:"")
	static let guideAccessBtnTitle: String = NSLocalizedString("guideAccess",comment:"")
	static let passcodeBtnTitle: String = NSLocalizedString("passcode",comment:"")
	static let passcodeScreenBtnTitle: String = NSLocalizedString("passcodeScreen",comment:"")
	static let deviceSwitchBtnTitle: String = NSLocalizedString("deviceSwitch",comment:"")
	
	static let appVersionTitle: String = NSLocalizedString("Application version",comment:"")
	static let appVersionMessage: String = NSLocalizedString("Dear customer, it is necessary to update to the latest version of the application available in the AppStore. Do you want to do it at this time?",comment:"")
	
	struct BtnStrings {
		static let okTitle: String = NSLocalizedString("Ok",comment:"")
		static let yesTitle: String = NSLocalizedString("Yes",comment:"")
		static let noTitle: String = NSLocalizedString("No",comment:"")
		static let cancelTitle: String = NSLocalizedString("Cancel",comment:"")
	}
	
	///Wallpaper images
	struct WallpapersImages {
		static let backgroundImage: String = NSLocalizedString("background",comment:"")
		static let mickeyImage: String = NSLocalizedString("mickey",comment:"")
		static let minieImage: String = NSLocalizedString("minie",comment:"")
		static let defaultImage: String = NSLocalizedString("default",comment:"")
		static let minionsImage: String = NSLocalizedString("minions",comment:"")
	}
	
	struct Urls {
		static var storeBundleURL = "http://itunes.apple.com/lookup?bundleId=com.bocanasa.kidenv"
		static var itunesURL = "itms://itunes.apple.com/us/app/apple-store/id1671059805?mt=8"
	}
}

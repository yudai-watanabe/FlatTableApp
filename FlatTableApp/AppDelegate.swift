//
//  AppDelegate.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/12.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		let tabBar: TabBarController = TabBarController.instantiate()
		let nc: UINavigationController = UINavigationController(rootViewController: tabBar)
		
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = nc
		self.window?.makeKeyAndVisible()
		
		return true
	}
}


//
//  TabBarController.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/23.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
	

	static func instantiate() -> TabBarController {
		var vcs: [UIViewController] = []
		
		if let vc: LeagueTableViewController = LeagueTableViewController.instantiateFromStoryboard() as? LeagueTableViewController {
			vc.title = "ranking"
			let nc: UINavigationController = UINavigationController(rootViewController: vc)
			let barItem: UITabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.history, tag: vcs.count)
			nc.tabBarItem = barItem
			
			vcs.append(nc)
		}
		
		if let vc: NewsViewController = NewsViewController.instantiateFromStoryboard() as? NewsViewController {
			vc.title = "news"
			let nc: UINavigationController = UINavigationController(rootViewController: vc)
			let barItem: UITabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.favorites, tag: vcs.count)
			nc.tabBarItem = barItem

			vcs.append(nc)
		}
		
		let result: TabBarController = TabBarController()
		result.viewControllers = vcs
		return result
	}
}


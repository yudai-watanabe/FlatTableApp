//
//  UIViewController + .swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/19.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import UIKit

extension UIViewController {
	
	public class func instantiateFromStoryboardName<T: UIViewController>() -> T? {
		guard let clsName: String = self.className else {
			return nil
		}
		
		let storyboard = UIStoryboard(name: clsName, bundle: Bundle.main)
		return storyboard.instantiateInitialViewController() as? T
	}
	
	public class func instantiateFromNib<T: UIViewController>() -> T? {
		guard let nibName: String = self.className else {
			return nil
		}
		
		return T(nibName: nibName, bundle: nil)
	}
	
}

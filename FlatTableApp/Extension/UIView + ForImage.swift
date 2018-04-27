//
//  UIView + ForImage.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/27.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	
	func forImage() -> UIImage? {
		UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
		guard let currentContext = UIGraphicsGetCurrentContext() else {
			UIGraphicsEndImageContext()
			return nil
		}
		layer.render(in: currentContext)
		let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image
	}
	
}

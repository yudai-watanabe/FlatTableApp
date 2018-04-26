//
//  UIView + Base.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/26.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import UIKit

extension UIView {
	
	@IBInspectable
	var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
			layer.masksToBounds = newValue > 0
		}
	}
	
	@IBInspectable
	var borderWidth: CGFloat {
		get {
			return self.layer.borderWidth
		}
		set {
			self.layer.borderWidth = newValue
		}
	}
	
	@IBInspectable
	var borderColor: UIColor? {
		get {
			return UIColor(cgColor: self.layer.borderColor!)
		}
		set {
			self.layer.borderColor = newValue?.cgColor
		}
	}
	
}

//
//  Date + Base.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/27.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import Foundation
import SwiftDate
import UIKit

extension String {
	
	func forDate() -> Date? {
		let formatter: DateFormatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
		return formatter.date(from: self)
	}
	
}

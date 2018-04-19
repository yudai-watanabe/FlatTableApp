//
//  TeamRankTableViewCell.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/12.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import UIKit
import Chameleon
import SwiftSVG

class TeamRankTableViewCell: UITableViewCell {
	
	open let identifier: String = "TeamRankTableViewCell"
	
	@IBOutlet private weak var rankLabel: UILabel!
	@IBOutlet private weak var teamNameLabel: UILabel!
	@IBOutlet private weak var pointLabel: UILabel!
	
	open var standing: Standing? {
		didSet {
			rankLabel.text = standing?.position.description
			teamNameLabel.text = standing?.teamName
			pointLabel.text = standing?.points.description
			backgroundColor = UIColor(randomFlatColorOf: .light, withAlpha: 0.5)
		}
	}
    
}

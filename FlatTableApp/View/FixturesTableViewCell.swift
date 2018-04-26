//
//  FixturesTableViewCell.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/26.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import UIKit
import SwiftDate

class FixturesTableViewCell: UITableViewCell {

	open let identifier: String = "FixturesTableViewCell"
    
	@IBOutlet weak var date: UILabel!
	@IBOutlet weak var homeTeam: UILabel!
	@IBOutlet weak var awayTeam: UILabel!
	@IBOutlet weak var homeTeamResult: UILabel!
	@IBOutlet weak var awayTeamResult: UILabel!
	
	public var entity: Fixture? {
		didSet {
			self.date.text = entity?.date
			self.homeTeam.text = entity?.homeTeamName
			self.awayTeam.text = entity?.awayTeamName
			self.result = entity?.result
		}
	}
	
	private var result: FixtureResult? {
		didSet {
			self.homeTeamResult.text = result?.goalsHomeTeam?.description
			self.awayTeamResult.text = result?.goalsAwayTeam?.description
		}
	}
	
}

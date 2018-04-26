//
//  FixturesRepository.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/24.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import Foundation
import Alamofire

struct FixturesRepository: BaseRepositoryProtocol {
	
	var url: String = "http://api.football-data.org/v1/teams/65/fixtures"
	
}

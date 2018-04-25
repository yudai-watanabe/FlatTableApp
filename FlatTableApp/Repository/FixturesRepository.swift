//
//  FixturesRepository.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/24.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import Foundation
import Alamofire

struct FixturesRepository {
	
	private let url: String = "http://api.football-data.org/v1/teams/65/fixtures"
	
	func getFixtures(complation: ((FixturesEntity?)->Void)?) {
		Alamofire.request(url).responseJSON(completionHandler: {response in
			switch response.result {
			case .success(let json):
				print(json)
				do {
					let data = try JSONSerialization.data(withJSONObject: json, options: [])
					let entity = try JSONDecoder().decode(FixturesEntity.self, from: data)
					complation?(entity)
				}
				catch {
					complation?(nil)
					print(error)
				}
			case .failure(let e):
				print(e)
				complation?(nil)
			}
		})
	}
}

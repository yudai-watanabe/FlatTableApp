//
//  LeagueTableRepository.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/24.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import Foundation
import Alamofire

struct LeagueTableRepository {
	
	private let url = "http://api.football-data.org/v1/competitions/445/leagueTable"
	
	func getLeagueTable(complation: ((LeagueTableEntity?)->Void)?) {
		Alamofire.request(url).responseJSON(completionHandler: {response in
			switch response.result {
			case .success(let json):
				do {
					let data = try JSONSerialization.data(withJSONObject: json, options: [])
					let entity = try JSONDecoder().decode(LeagueTableEntity.self, from: data)
					complation?(entity)
				}
				catch {
					print("失敗")
					complation?(nil)
				}
			case .failure(let error):
				print(error)
				complation?(nil)
			}
		})
	}
}

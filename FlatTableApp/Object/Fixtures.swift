//
//  Fixtures.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/18.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import Foundation

struct Fixtures: Codable  {
	let _links: Links
	let season: String
	let count: Int
	let fixtures: Array<Fixture>
}

struct Fixture: Codable {
	
	enum FixtureStatus: String, Codable {
		case FINISHED
		case TIMED
		case SCHEDULED
	}
	
	let _links: Links
	let date: String
	let status: FixtureStatus
	let matchDay: Int
	let homeTeamName: String
	let awayTeamName: String
	let odds: String?
}

struct FixtureResult: Codable {
	let goalsHomeTeam: Int?
	let goalsAwayTeam: Int?
	let halfTime: HalfTimeResult
}

struct HalfTimeResult: Codable {
	let goalsHomeTeam: Int?
	let goalsAwayTeam: Int?
}

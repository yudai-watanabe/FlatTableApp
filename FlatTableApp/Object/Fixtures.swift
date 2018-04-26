//
//  Fixtures.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/18.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import Foundation

struct FixturesEntity: Entity {
	let _links: Links
	let season: String
	let count: Int
	let fixtures: Array<Fixture>
}

struct Fixture: Entity {
	
	enum FixtureStatus: String, Codable {
		case SCHEDULED
		case TIMED
		case FINISHED
		case POSTPONED
	}
	
	let _links: Links?
	let date: String?
	let status: FixtureStatus?
	let matchday: Int?
	let homeTeamName: String?
	let awayTeamName: String?
	var odds: [String: Double?]?
	let result: FixtureResult?
}

struct FixtureResult: Entity {
	let goalsHomeTeam: Int?
	let goalsAwayTeam: Int?
	let halfTime: HalfTimeResult?
}

struct HalfTimeResult: Entity {
	let goalsHomeTeam: Int?
	let goalsAwayTeam: Int?
}

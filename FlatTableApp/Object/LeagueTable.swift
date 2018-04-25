//
//  LeagueTable.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/16.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import Foundation

protocol Entity: Codable {}

struct LeagueTableEntity: Entity {
	let _links: Links
	let leagueCaption: String
	let matchday: Int
	let standing: Array<Standing>
}

struct Standing: Entity {
	let _links: Links
	let position: Int
	let teamName: String
	let crestURI: String
	let playedGames: Int
	let points: Int
	let goals: Int
	let goalsAgainst: Int
	let goalDifference: Int
	let wins: Int
	let draws: Int
	let losses: Int
	let home: HomeAndAway
	let away: HomeAndAway
}

struct HomeAndAway: Entity {
	let goals: Int
	let goalsAgainst: Int
	let wins: Int
	let draws: Int
	let losses: Int
}

//
//  Competitions.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/16.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import Foundation

struct Competitions: Codable {
	let _links: Links
	let id: Int
	let caption: String
	let league: String
	let year: String
	let currentMatchday: Int
	let numberOfMatchdays: Int
	let numberOfTeams: Int
	let numberOfGames: Int
	let lastUpdated: String
}

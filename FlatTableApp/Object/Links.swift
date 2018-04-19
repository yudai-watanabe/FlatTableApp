//
//  Links.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/16.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import Foundation

struct Links: Codable {
	let `self`: Href?
	let teams: Href?
	let fixtures: Href?
	let leagueTable: Href?
	let competition: Href?
	let players: Href?
	let homeTeam: Href?
	let awayTeam: Href?
}

struct Href: Codable {
	let href: String
}

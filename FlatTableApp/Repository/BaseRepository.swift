//
//  BaseRepository.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/26.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseRepositoryProtocol {
	
	var url: String { get }
	
	func get<T: Codable>(complation: ((T?)->Void)?)
	
}

extension BaseRepositoryProtocol {
	
	func get<T: Codable>(complation: ((T?)->Void)?) {
		Alamofire.request(self.url).responseJSON(completionHandler: {response in
			switch response.result {
			case .success(let json):
				do {
					let data = try JSONSerialization.data(withJSONObject: json, options: [])
					let entity = try JSONDecoder().decode(T.self, from: data)
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

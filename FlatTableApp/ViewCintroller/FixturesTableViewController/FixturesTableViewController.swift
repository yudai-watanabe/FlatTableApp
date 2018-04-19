//
//  FixturesTableViewController.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/18.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import Alamofire
import UIKit
import Nuke
import Chameleon

class FixturesTableViewController: UIViewController {
	
	@IBOutlet private weak var crestView: UIView!
	@IBOutlet private weak var crestImage: UIImageView!
	
	open var standing: Standing? {
		didSet {
			let url = URL(string: (standing?.crestURI)!)
			Nuke.Manager.shared.loadImage(with: url!, completion: {[weak self] image in
				self?.crestImage.image = image.value
				self?.crestView.backgroundColor = UIColor(averageColorFrom: image.value)
				print("完了")
			})
		}
	}
	
	private let fixturesTableView: UITableView = UITableView()
	let url: String = "http://api.football-data.org/v1/teams/65/fixtures"
    override func viewDidLoad() {
        super.viewDidLoad()
		getCompetitions()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	private func getCompetitions(complation: (()->Void)? = nil) {
		Alamofire.request(url).responseJSON(completionHandler: {response in
			complation?()
			switch response.result {
			case .success(let data):
				print(data)
				//				if let fixtures = try? JSONDecoder().decode(Fixtures.self, from: data) {
				//					print(fixtures)
			//				}
			case .failure(let error):
				print(error)
			}
		})
	}

}

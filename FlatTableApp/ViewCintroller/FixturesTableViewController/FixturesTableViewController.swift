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
import SwiftSVG

class FixturesTableViewController: UIViewController {
	
	@IBOutlet private weak var crestView: UIView!
	@IBOutlet private weak var crestImage: UIImageView!
	@IBOutlet weak var tableView: UITableView!
	
	open var standing: Standing? {
		didSet {
			let url: URL? = URL(string: (standing?.crestURI)!)
			let teamUrl: URL = URL(string: (standing?._links.team?.href)!)!
			let teamId: Int = Int(teamUrl.pathComponents.last!)!
			let closure: ((FixturesEntity?) -> Void)? = {entity in
				self.fixturesEntity = entity
			}
			FixturesRepository(teamId: teamId).get(complation: closure)
			
			Nuke.Manager.shared.loadImage(with: url!, completion: {[weak self] result in
				switch result {
				case .success(let image):
					self?.crestImage.image = image
					self?.crestView.backgroundColor = UIColor(averageColorFrom: image)
				case .failure(let e):
					print(e)
//					let view = UIView(SVGURL: url!, parser: nil, completion: nil)
//					self?.crestImage.image = view.forImage()
//					self?.crestView.backgroundColor = UIColor(averageColorFrom: view.forImage())
				}
			})
		}
	}
	
	private var fixturesEntity: FixturesEntity? {
		didSet{
			setTableView()
		}
	}
	private let fixturesTableView: UITableView = UITableView()
	private let fixturesTableViewCell = FixturesTableViewCell()
	
	private func setTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UINib(nibName: fixturesTableViewCell.identifier, bundle: nil),
						   forCellReuseIdentifier: fixturesTableViewCell.identifier)
		tableView.reloadData()
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FixturesTableViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	
	}
	
}

extension FixturesTableViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return fixturesEntity!.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: fixturesTableViewCell.identifier,
												 for: indexPath) as! FixturesTableViewCell
		cell.entity = fixturesEntity?.fixtures[indexPath.row]
		return  cell
	}
	
}

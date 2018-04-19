//
//  ViewController.swift
//  FlatTableApp
//
//  Created by watanabe-yudai on 2018/04/12.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import ToastSwiftFramework

class LeagueTableViewController: UIViewController  {

	@IBOutlet private weak var navigationBar: UINavigationBar!
	
	private let refreshControl = UIRefreshControl()
	private let url = "http://api.football-data.org/v1/competitions/445/leagueTable"
	private var leagueTable: LeagueTable? {
		didSet {
			leagueTableView = UITableView(frame: CGRect(x: 0, y: navigationBar.frame.height,
														width: view.frame.width,
														height: view.frame.height - navigationBar.frame.height))
			self.setTableView()
		}
	}
	
	private var leagueTableView: UITableView?
	private let teamRankTableViewCell = TeamRankTableViewCell()
	private lazy var reloadBarButttonItem: UIBarButtonItem = {
		let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh,
								   target: self,
								   action: #selector(self.refresh(_:)))
		return item
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.makeToastActivity(.center)
		navigationBar.delegate = self
		getCompetitions(complation: {
			self.view.hideToastActivity()
		})
		refreshControl.addTarget(self, action: #selector(self.refresh(_:)) , for: .valueChanged)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	private func setTableView() {
		guard let tableView = leagueTableView else{
			return
		}
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UINib(nibName: teamRankTableViewCell.identifier, bundle: nil),
						   forCellReuseIdentifier: teamRankTableViewCell.identifier)
		tableView.tableFooterView = UIView(frame: .zero)
		tableView.refreshControl = refreshControl
		view.addSubview(tableView)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.navigationItem.setLeftBarButton(reloadBarButttonItem, animated: animated)
	}
	
	@objc func refresh(_ sender: UIRefreshControl) {
		getCompetitions(complation: {
			self.refreshControl.endRefreshing()
		})
	}
	
	private func getCompetitions(complation: (()->Void)? = nil) {
		Alamofire.request(url).responseData(completionHandler: {response in
			complation?()
			switch response.result {
			case .success(let data):
				if let table = try? JSONDecoder().decode(LeagueTable.self, from: data) {
					self.leagueTable = table
				}
			case .failure(let error):
				print(error)
			}
		})
	}
}

// MARK:- UITableViewDelegate

extension LeagueTableViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let fixturesTableVC = FixturesTableViewController.instantiateFromStoryboard() as! FixturesTableViewController
		fixturesTableVC.standing = self.leagueTable?.standing[indexPath.row]
		self.present(fixturesTableVC, animated: true, completion: {
			print("presented")
		})
	}
	
}

// MARK:- UITableViewDataSource

extension LeagueTableViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.leagueTable!.standing.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: teamRankTableViewCell.identifier,
												 for: indexPath) as! TeamRankTableViewCell
		let standing = self.leagueTable?.standing[indexPath.row]
		cell.standing = standing
		return cell
	}
	
}

//MARK:- UINavigationBarDelegate

extension LeagueTableViewController: UINavigationBarDelegate {
	
	func position(for bar: UIBarPositioning) -> UIBarPosition {
		return .topAttached
	}
	
}


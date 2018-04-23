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
	
	private let url = "http://api.football-data.org/v1/competitions/445/leagueTable"
	private var leagueTable: LeagueTable? {
		didSet {
			leagueTableView = UITableView(frame: self.view.frame)
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
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		
		self.view?.removeFromSuperview()
	}
	
	private func setTableView() {
		guard let tableView = leagueTableView else{
			return
		}
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UINib(nibName: teamRankTableViewCell.identifier, bundle: nil),
						   forCellReuseIdentifier: teamRankTableViewCell.identifier)
		tableView.contentInset = UIEdgeInsets.zero
		tableView.tableHeaderView = UIView(frame: .zero)
		tableView.tableFooterView = UIView(frame: .zero)
		
		self.view.addSubview(tableView)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		getCompetitions(complation: {
			self.view.hideToastActivity()
		})
		self.navigationItem.setLeftBarButton(reloadBarButttonItem, animated: animated)
	}
	
	@objc func refresh(_ sender: UIRefreshControl) {
		getCompetitions(complation: nil)
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
		self.navigationController?.pushViewController(fixturesTableVC, animated: true)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 44
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


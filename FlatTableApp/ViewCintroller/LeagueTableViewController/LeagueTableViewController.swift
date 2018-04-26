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
	
	private var leagueTable: LeagueTableEntity? {
		didSet {
			leagueTableView = UITableView(frame: view.frame)
			self.setTableView()
		}
	}
	
	private let repository: LeagueTableRepository = LeagueTableRepository()
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
		 repository.getLeagueTable(complation: { entity in
			self.view.hideToastActivity()
			self.leagueTable = entity
		})
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
		self.navigationItem.setLeftBarButton(self.reloadBarButttonItem, animated: animated)
	}
	
	@objc func refresh(_ sender: UIRefreshControl) {
		repository.getLeagueTable(complation:{ entity in
			self.leagueTable = entity
		})
	}
	
	
}

// MARK:- UITableViewDelegate

extension LeagueTableViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		if let fixturesTableVC: FixturesTableViewController = FixturesTableViewController.instantiateFromStoryboardName() {
			fixturesTableVC.standing = self.leagueTable?.standing[indexPath.row]
			self.navigationController?.pushViewController(fixturesTableVC, animated: true)
		}
		
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


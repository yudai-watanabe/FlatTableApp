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
	
	private var fixturesEntity: FixturesEntity?
	private let fixturesTableView: UITableView = UITableView()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		let closure: ((FixturesEntity?) -> Void)? = {entity in
			self.fixturesEntity = entity
			print(entity ?? "nil")
		}
		
		FixturesRepository().get(complation: closure)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

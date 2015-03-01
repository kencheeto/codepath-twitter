//
//  MenuViewController.swift
//  codepath-twitter
//
//  Created by Kenshiro Nakagawa on 3/1/15.
//  Copyright (c) 2015 Kenshiro Nakagawa. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  private let links = [
    "Profile",
    "Timeline",
    "Mentions"
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.frame = view.bounds
  }
  
}

extension MenuViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return links.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("MenuLinkCell") as MenuLinkCell
    cell.linkLabel.text = links[indexPath.row]
    return cell
  }
}
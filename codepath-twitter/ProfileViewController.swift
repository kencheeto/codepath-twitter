//
//  ProfileViewController.swift
//  codepath-twitter
//
//  Created by Kenshiro Nakagawa on 3/1/15.
//  Copyright (c) 2015 Kenshiro Nakagawa. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var user: User?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 80
    // Do any additional setup after loading the view.
  }

}

extension ProfileViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      var headerCell = tableView.dequeueReusableCellWithIdentifier("ProfileHeaderCell") as ProfileHeaderCell
      headerCell.headerImage.setImageWithURL(user!.profileBackgroundImageUrl)

      return headerCell
    } else if indexPath.row == 1 {
      var infoCell = tableView.dequeueReusableCellWithIdentifier("ProfileInfoCell") as ProfileInfoCell
      infoCell.user = user
      return infoCell
    }
    return UITableViewCell()
  }
}
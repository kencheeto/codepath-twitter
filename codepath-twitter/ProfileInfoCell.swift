//
//  ProfileInfoCell.swift
//  codepath-twitter
//
//  Created by Kenshiro Nakagawa on 3/1/15.
//  Copyright (c) 2015 Kenshiro Nakagawa. All rights reserved.
//

import UIKit

class ProfileInfoCell: UITableViewCell {
  
  @IBOutlet weak var followersLabel: UILabel!
  @IBOutlet weak var followingLabel: UILabel!
  @IBOutlet weak var tweetsLabel: UILabel!

  var user: User? {
    didSet {
      followersLabel.text = "\(user!.followersCount) followers"
      followingLabel.text = "following \(user!.followingCount)"
      tweetsLabel.text = "\(user!.statusesCount) tweets"
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    separatorInset = UIEdgeInsetsZero
    preservesSuperviewLayoutMargins = false
    layoutMargins = UIEdgeInsetsZero
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}

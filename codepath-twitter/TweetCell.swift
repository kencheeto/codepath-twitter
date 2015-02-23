//
//  TweetCell.swift
//  codepath-twitter
//
//  Created by Kenshiro Nakagawa on 2/23/15.
//  Copyright (c) 2015 Kenshiro Nakagawa. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var profileImageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}

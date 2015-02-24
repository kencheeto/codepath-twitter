//
//  TweetCell.swift
//  codepath-twitter
//
//  Created by Kenshiro Nakagawa on 2/23/15.
//  Copyright (c) 2015 Kenshiro Nakagawa. All rights reserved.
//

import UIKit

final class TweetCell: UITableViewCell {

  @IBOutlet weak var realNameLabel: UILabel!
  @IBOutlet weak var tweetUserLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var timestampLabel: UILabel!
  @IBOutlet weak var favoritedLabel: UILabel!
  @IBOutlet weak var retweetedLabel: UILabel!

  var tweet: Tweet?
  override func awakeFromNib() {
    super.awakeFromNib()
    separatorInset = UIEdgeInsetsZero
    preservesSuperviewLayoutMargins = false
    layoutMargins = UIEdgeInsetsZero
  }

//  override func setSelected(selected: Bool, animated: Bool) {
//    super.setSelected(selected, animated: animated)
//  }

}

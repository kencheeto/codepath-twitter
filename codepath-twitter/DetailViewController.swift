//
//  ComposeViewController.swift
//  codepath-twitter
//
//  Created by Kenshiro Nakagawa on 2/24/15.
//  Copyright (c) 2015 Kenshiro Nakagawa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var tweetButton: UIBarButtonItem!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var screenNameLabel: UILabel!
  @IBOutlet weak var realNameLabel: UILabel!
  @IBOutlet weak var tweetTextView: UITextView!
  var tweet: Tweet?

  @IBOutlet weak var retweetButton: UIButton!
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var replyButton: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.navigationBar.barTintColor = UIColor(red: 0.33203125, green: 0.671875, blue: 0.9296875, alpha: 1)
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

    realNameLabel.text = User.currentUser?.name
    screenNameLabel.text = User.currentUser?.screenName
    profileImageView.setImageWithURL(User.currentUser?.imageUrl)

    tweetTextView.becomeFirstResponder()

    if tweet == nil {
      retweetButton.hidden = true
      favoriteButton.hidden = true
      replyButton.hidden = true
    }

    if tweet != nil {
      tweetTextView.text = "@\(tweet!.user!.screenName!) "
      tweetButton.title = "Reply"
    }
  }

  @IBAction func didSubmitTweet(sender: UIBarButtonItem) {
    if tweet != nil {
      TwitterClient.sharedInstance.reply(tweetTextView.text, id: tweet!.statusId!)
    } else {
      TwitterClient.sharedInstance.tweet(tweetTextView.text)
    }
  }

  @IBAction func didRetweet(sender: AnyObject) {
    println("retweet")
    TwitterClient.sharedInstance.retweet(tweet!.statusId!)
  }

  @IBAction func didFavorite(sender: AnyObject) {
    println("favorite")
    TwitterClient.sharedInstance.favorite(tweet!.statusId!)
  }
}

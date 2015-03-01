//
//  TweetsViewController.swift
//  codepath-twitter
//
//  Created by Kenshiro Nakagawa on 2/22/15.
//  Copyright (c) 2015 Kenshiro Nakagawa. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!

  private var refreshControl: UIRefreshControl!

  @IBOutlet var menuGesture: UISwipeGestureRecognizer!
  
  @IBOutlet weak var menuView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.navigationBar.barTintColor = UIColor(red: 0.33203125, green: 0.671875, blue: 0.9296875, alpha: 1)
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

    tableView.delegate = self
    tableView.dataSource = self

    menuGesture.delegate = self
    menuView.hidden = true

    NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshedTimelineTweets", name: "refreshedTimelineTweets", object: nil)
    TwitterClient.sharedInstance.fetchTimelineTweets()

    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
    tableView.insertSubview(refreshControl, atIndex: 0)

    tableView.rowHeight = UITableViewAutomaticDimension

    
    tableView.estimatedRowHeight = 100
  }

  @IBAction func didOpenMenu(sender: AnyObject) {
    println("did swipe")
    menuView.hidden = false
  }
  
  @IBAction func didCloseMenu(sender: AnyObject) {
    println("closing menu")
    menuView.hidden = true
  }
  
  func refreshedTimelineTweets() {
    println("timeline tweets refreshed")
    tableView.reloadData()
  }

  func onRefresh() {
    refreshedTimelineTweets()
    refreshControl.endRefreshing()
  }
  
  @IBAction func onLogout(sender: AnyObject) {
    User.currentUser?.logout()
  }
}

// MARK: - UITableViewDataSource
extension TweetsViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
    let tweets = Tweet.timelineTweets!
    var tweet = tweets[indexPath.row]
    cell.tweetTextLabel.text = tweet.text
    cell.timestampLabel.text = timeAgoSinceDate(tweet.createdAt!)
    if tweet.user != nil {
      cell.tweetUserLabel.text = "@\(tweet.user!.screenName!)"
      cell.profileImageView.setImageWithURL(tweet.imageUrl)
      cell.realNameLabel.text = tweet.user!.name
    }
    if tweet.favorited == true {
      cell.favoritedLabel.text = "favorited"
    } else {
      cell.favoritedLabel.hidden = true
    }
    if tweet.retweeted == true {
      cell.retweetedLabel.text = "retweeted"
    } else {
      cell.retweetedLabel.hidden = true
    }
    cell.tweet = tweet
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = Tweet.timelineTweets?.count {
      return count
    }
    return 0
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    var navVC = segue.destinationViewController as UINavigationController
    var vc = navVC.topViewController as DetailViewController
    if segue.identifier == "NewSegue" {
      println("no existing tweet")
    } else {
      var cell = sender as TweetCell!
      println("setting tweet on segue")
      vc.tweet = cell.tweet
    }
  }
}

// MARK: - UIGestureRecognizerDelegate
extension TweetsViewController: UIGestureRecognizerDelegate {
  
}

// MARK: - UITableViewDelegate
extension TweetsViewController: UITableViewDelegate {
  
}

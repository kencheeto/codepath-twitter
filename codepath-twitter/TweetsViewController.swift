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

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
    tableView.insertSubview(refreshControl, atIndex: 0)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshedTimelineTweets", name: "refreshedTimelineTweets", object: nil)
    TwitterClient.sharedInstance.fetchTimelineTweets()
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
  
  @IBAction func tappedProfileImage(sender: UITapGestureRecognizer) {
    println("heeey")
  }
}

extension TweetsViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
    cell.tweet = Tweet.timelineTweets![indexPath.row]
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

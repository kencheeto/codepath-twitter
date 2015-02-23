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

    navigationController?.navigationBar.barTintColor = UIColor(red: 0.33203125, green: 0.671875, blue: 0.9296875, alpha: 1)
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

    tableView.delegate = self
    tableView.dataSource = self

    NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshedTimelineTweets", name: "refreshedTimelineTweets", object: nil)
    TwitterClient.sharedInstance.fetchTimelineTweets()

    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
    tableView.insertSubview(refreshControl, atIndex: 0)

    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func refreshedTimelineTweets() {
    println("notified that timeline tweets refreshed")
    tableView.reloadData()
  }

  func onRefresh() {
    refreshedTimelineTweets()
    refreshControl.endRefreshing()
  }
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
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
    }
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = Tweet.timelineTweets?.count {
      return count
    }
    return 0
  }
}

// MARK: - UITableViewDelegate
extension TweetsViewController: UITableViewDelegate {
  
}

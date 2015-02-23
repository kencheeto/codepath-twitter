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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshedTimelineTweets", name: "refreshedTimelineTweets", object: nil)
    
    println("fetching timeline tweets")
    
    TwitterClient.sharedInstance.fetchTimelineTweets()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func refreshedTimelineTweets() {
    println("notified that timeline tweets refreshed!")
    tableView.reloadData()
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

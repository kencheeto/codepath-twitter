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
  @IBOutlet var menuGesture: UISwipeGestureRecognizer!
  @IBOutlet weak var menuView: UIView!
  
  var menuViewController: MenuViewController!
  private var refreshControl: UIRefreshControl!

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.navigationBar.barTintColor = TwitterColor
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
    tableView.insertSubview(refreshControl, atIndex: 0)

    menuGesture.delegate = self
    menuView.hidden = true
    menuViewController = storyboard?.instantiateViewControllerWithIdentifier("MenuViewController") as MenuViewController
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshedTimelineTweets", name: "refreshedTimelineTweets", object: nil)
    TwitterClient.sharedInstance.fetchTimelineTweets()
  }

  @IBAction func didOpenMenu(sender: AnyObject) {
    println("did swipe")
    addChildViewController(menuViewController)
    menuView.addSubview(menuViewController.view)
    menuViewController.view.frame = menuView.bounds
    menuViewController.didMoveToParentViewController(self)
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

// MARK: - UIGestureRecognizerDelegate
extension TweetsViewController: UIGestureRecognizerDelegate {
  
}

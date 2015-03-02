//
//  ContainerViewController.swift
//  codepath-twitter
//
//  Created by Kenshiro Nakagawa on 3/1/15.
//  Copyright (c) 2015 Kenshiro Nakagawa. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
  
  @IBOutlet weak var menuTableView: UITableView!
  @IBOutlet weak var containerView: UIView!
  
  var mainNavController = UIStoryboard(
    name: "Main",
    bundle: NSBundle.mainBundle()
  ).instantiateViewControllerWithIdentifier("MainNavController") as UINavigationController
  
  private let links = [
    "Profile",
    "Timeline",
    "Mentions"
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    menuTableView.dataSource = self
    menuTableView.delegate = self
    
    mainNavController.view.frame = containerView.bounds

    println("view did load")
    containerView.addSubview(mainNavController.view)
  }

  override func viewDidAppear(animated: Bool) {
    println("view did appear")
    menuTableView.hidden = true
  }
  
  @IBAction func swipedRight(sender: UISwipeGestureRecognizer) {
    println("swipe right")
    menuTableView.hidden = false
  }
  
  @IBAction func swipedLeft(sender: UISwipeGestureRecognizer) {
    println("swipe left")
    menuTableView.hidden = true
  }
}

extension ContainerViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return links.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = menuTableView.dequeueReusableCellWithIdentifier("MenuLinkCell") as MenuLinkCell
    cell.linkLabel.text = links[indexPath.row]
    return cell
  }
}

extension ContainerViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let link = links[indexPath.row]
    if link == "Profile" {
      let profileViewController = storyboard!.instantiateViewControllerWithIdentifier("ProfileViewController") as ProfileViewController
      profileViewController.user = User.currentUser
      mainNavController.showViewController(profileViewController, sender: self)
    } else if link == "Timeline" {
      let tweetsViewController = storyboard!.instantiateViewControllerWithIdentifier("TweetsViewController") as TweetsViewController
      mainNavController.showViewController(tweetsViewController, sender: self)
    }
    menuTableView.hidden = true
    menuTableView.deselectRowAtIndexPath(indexPath, animated: false)
  }
}

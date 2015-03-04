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
  
  var hiddenMenuX: CGFloat!
  var menuY: CGFloat!
  var shownMenuX: CGFloat!
  var normalContainerX: CGFloat!
  var shiftedContainerX: CGFloat!
  var containerY: CGFloat!
  var menuWidth: CGFloat!
  
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

    menuWidth = menuTableView.frame.size.width
    hiddenMenuX = menuTableView.center.x - menuWidth
    shiftedContainerX = containerView.center.x + menuWidth

    
    println("view did load")
    containerView.addSubview(mainNavController.view)
  }

  override func viewDidAppear(animated: Bool) {
    println("view did appear")
    menuY = menuTableView.center.y
    containerY = containerView.center.y
    shownMenuX = menuTableView.center.x
    normalContainerX = containerView.center.x
    shiftedContainerX = normalContainerX + menuWidth
    menuTableView.center = CGPoint(x: hiddenMenuX, y: menuY)
  }

  @IBAction func didPan(sender: UIPanGestureRecognizer) {
    var velocity = sender.velocityInView(view).x
    var location = sender.locationInView(view)
    
    if sender.state == UIGestureRecognizerState.Began {
//      startMenuX = menuTableView.center.x
//      startContainerX = containerView.center.x
    } else if sender.state == UIGestureRecognizerState.Changed {
      menuTableView.center = CGPoint(x: hiddenMenuX + location.x, y: menuY)
      containerView.center = CGPoint(x: normalContainerX + location.x, y: containerY)
    } else if sender.state == UIGestureRecognizerState.Ended {
      if velocity > 0 {
        menuTableView.center = CGPoint(x: shownMenuX, y: menuY)
        containerView.center = CGPoint(x: shiftedContainerX, y: containerY)
      } else {
        menuTableView.center = CGPoint(x: hiddenMenuX, y: menuY)
        containerView.center = CGPoint(x: normalContainerX, y: containerY)
      }
    }
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

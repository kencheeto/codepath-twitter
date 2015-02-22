//
//  ViewController.swift
//  codepath-twitter
//
//  Created by Kenshiro Nakagawa on 2/22/15.
//  Copyright (c) 2015 Kenshiro Nakagawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func onLogin(sender: UIButton) {
    TwitterClient.sharedInstance.loginWithCompletion() {
      (user: User?, error: NSError?) in
      if user != nil {
        self.performSegueWithIdentifier("loginSegue", sender: self)
      } else {
        // handle login error
      }
    }

  }
}

//
//  User.swift
//  codepath-twitter
//
//  Created by Kenshiro Nakagawa on 2/22/15.
//  Copyright (c) 2015 Kenshiro Nakagawa. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "currentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
  var name: String?
  var screenName: String?
  var profileImageUrl: String?
  var tagline: String?
  var dictionary: NSDictionary
  
  init(dictionary: NSDictionary) {
    self.dictionary = dictionary
    name = dictionary["name"] as String?
    screenName = dictionary["screen_name"] as String?
    profileImageUrl = dictionary["profile_image_url"] as String?
    tagline = dictionary["description"] as String?
  }

  var imageUrl: NSURL? {
    if let imageUrlString = profileImageUrl as String? {
      let highResImageUrlString = imageUrlString.stringByReplacingOccurrencesOfString("_normal", withString: "_bigger", options: nil, range: nil)
      return NSURL(string: highResImageUrlString as String!)
    }
    return nil
  }

  var profileBackgroundImageUrl: NSURL {
    let url = dictionary["profile_background_image_url"] as String
    return NSURL(string: url)!
  }
  
  var statusesCount: Int {
    return dictionary["statuses_count"] as Int
  }
  
  var followersCount: Int {
    return dictionary["followers_count"] as Int
  }
  
  var followingCount: Int {
    return dictionary["friends_count"] as Int
  }
  
  func logout() {
    User.currentUser = nil
    TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
    
    NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
  }
  
  class var currentUser: User? {
    get {
      if _currentUser == nil {
        var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
        if data != nil {
          var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
          _currentUser = User(dictionary: dictionary)
        }
      }
      return _currentUser
    }
    
    set(user) {
      _currentUser = user
      
      if _currentUser != nil {
        var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
      } else {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
      }
      NSUserDefaults.standardUserDefaults().synchronize()
    }
  }
}

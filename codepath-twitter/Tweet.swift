//
//  Tweet.swift
//  codepath-twitter
//
//  Created by Kenshiro Nakagawa on 2/22/15.
//  Copyright (c) 2015 Kenshiro Nakagawa. All rights reserved.
//

import UIKit

var _timelineTweets: [Tweet]?

class Tweet: NSObject {
  var user: User?
  var text: String?
  var createdAtString: String?
  var createdAt: NSDate?
  var imageUrl: NSURL?
  
  init(dictionary: NSDictionary) {
    user = User(dictionary: dictionary["user"] as NSDictionary)
    text = dictionary["text"] as String?
    createdAtString = dictionary["created_at"] as String?
    
    var formatter = NSDateFormatter()
    formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
    createdAt = formatter.dateFromString(createdAtString!)

    if let imageUrlString = user?.profileImageUrl as String? {
      println("setting image url")
      imageUrl = NSURL(string: imageUrlString as String!)
    }
  }
  
  class func tweetsFromArray(array: [NSDictionary]) -> [Tweet] {
    var tweets = [Tweet]()
    
    for dictionary in array {
      tweets.append(Tweet(dictionary: dictionary))
    }
    
    return tweets
  }
  
  class var timelineTweets: [Tweet]? {
    get {
      return _timelineTweets
    }
    
    set(tweets) {
      _timelineTweets = tweets
    }
  }
}

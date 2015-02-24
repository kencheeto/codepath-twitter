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
  var statusId: Int?
  var dictionary: NSDictionary?

  init(dictionary: NSDictionary) {
    user = User(dictionary: dictionary["user"] as NSDictionary)
    text = dictionary["text"] as String?
    createdAtString = dictionary["created_at"] as String?
    statusId = dictionary["id"] as Int?
    self.dictionary = dictionary
  }

  var favorited: Bool? {
    if let favorite = dictionary?["favorited"] as Bool? {
      return favorite
    }
    return false
  }

  var retweeted: Bool? {
    if let retweet = dictionary?["retweeted"] as Bool? {
      return retweet
    }
    return false
  }

  var createdAt: NSDate? {
    var formatter = NSDateFormatter()
    formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
    return formatter.dateFromString(createdAtString!)
  }

  var imageUrl: NSURL? {
    return user?.imageUrl
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

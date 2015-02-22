//
//  TwitterClient.swift
//  codepath-twitter
//
//  Created by Kenshiro Nakagawa on 2/22/15.
//  Copyright (c) 2015 Kenshiro Nakagawa. All rights reserved.
//

import UIKit

private let consumerKey = "ULxEd9osOTzFk6FAVjkfR3rSk"
private let consumerSecret = "8Uh6Uq2JjEDxn7G0ivFljYEq43jqSSz1LungXfa91zGNB1Ia98"
private let twitterBaseUrl = NSURL(string: "https://api.twitter.com")
class TwitterClient: BDBOAuth1RequestOperationManager {
  class var sharedInstance: TwitterClient {
    struct Static {
      static let instance = TwitterClient(
        baseURL: twitterBaseUrl,
        consumerKey: consumerKey,
        consumerSecret: consumerSecret
      )
    }
    
    return Static.instance
  }
}

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
  
  var loginCompletion: ((user: User?, error: NSError?) -> ())?
  
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
  
  func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
    loginCompletion = completion
    
    // fetch request token and redirect to authentication page
    TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
    TwitterClient.sharedInstance.fetchRequestTokenWithPath(
      "oauth/request_token",
      method: "GET",
      callbackURL: NSURL(string: "cptwttrken://oauth"),
      scope: nil,
      success: { (requestToken: BDBOAuth1Credential!) -> Void in
        println("Got the request token")
        var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
        UIApplication.sharedApplication().openURL(authURL!)
      },
      failure: { (error: NSError!) -> Void in
        println("Failed to get the request token")
      }
    )
  }
  
  func openUrl(url: NSURL) {
    fetchAccessTokenWithPath(
      "oauth/access_token",
      method: "POST",
      requestToken: BDBOAuth1Credential(queryString: url.query),
      success: { (accessToken: BDBOAuth1Credential!) -> Void in
        println("Got the access token")
        TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
        
        TwitterClient.sharedInstance.GET(
          "1.1/account/verify_credentials.json",
          parameters: nil,
          success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //            println("user: \(response)")
            var user = User(dictionary: response as NSDictionary)
            User.currentUser = user
            println("user: \(user.name)")
            self.loginCompletion?(user: user, error: nil)
          },
          failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println("failed to get current user")
            self.loginCompletion?(user: nil, error: error)
          }
        )
        
        TwitterClient.sharedInstance.GET(
          "1.1/statuses/home_timeline.json",
          parameters: nil,
          success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("home timeline: \(response)")
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            
            for tweet in tweets {
              println("text: \(tweet.text), created at: \(tweet.createdAt)")
            }
          },
          failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println("failed to get current user")
          }
        )
      },
      failure: { (error: NSError!) -> Void in
        println("Failed to get the access token")
      }
    )
  }
  
}

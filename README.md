This is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: `10`

### Features

#### Required

- [x] User can sign in using OAuth login flow
- [x] User can view last 20 tweets from their home timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [x] User can pull to refresh
- [x] User can compose a new tweet by tapping on a compose button.
- [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [ ] User can retweet, favorite, and reply to the tweet directly from the timeline feed.

#### Optional

- [ ] When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] Retweeting and favoriting should increment the retweet and favorite count.
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [ ] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

### Walkthrough

![demo](https://cloud.githubusercontent.com/assets/279406/6343475/601832c4-bbe9-11e4-8c6c-21437a892b82.gif)


## Twiter Redux

Time spent: `10`

Project Requirements
 
 Hamburger menu
 * [x] Dragging anywhere in the view should reveal the menu.
 * [x] The menu should include links to your profile, the home timeline, and the mentions view.
 
 Profile page
 * [x] Contains the user header view
 * [x] Contains a section with the users basic stats: # tweets, # following, # followers
 * [ ] Optional: Implement the paging view for the user description.
 * [ ] Optional: As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
 * [ ] Optional: Pulling down the profile page should blur and resize the header image.
 
 Home Timeline
 * [ ] Tapping on a user image should bring up that user's profile page
 * [ ] Optional: Account switching
 * [ ] Long press on tab bar to bring up Account view with animation
 * [ ] Tap account to switch to
 * [ ] Include a plus button to Add an Account
 * [ ] Swipe to delete an account

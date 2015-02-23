//
//  TimeAgo.swift
//  codepath-twitter
//
//  Created by minorbug, modified by Kenshiro Nakagawa
//  Taken from https://gist.github.com/minorbug/468790060810e0d29545
//  Copyright (c) 2015 Kenshiro Nakagawa. All rights reserved.
//

func timeAgoSinceDate(date:NSDate) -> String {
  let calendar = NSCalendar.currentCalendar()
  let unitFlags = NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitSecond
  let now = NSDate()
  let earliest = now.earlierDate(date)
  let latest = (earliest == now) ? date : now
  let components:NSDateComponents = calendar.components(unitFlags, fromDate: earliest, toDate: latest, options: nil)
  let formatter = NSDateFormatter()
  formatter.dateFormat = "d/m/y"
  let dateString = formatter.stringFromDate(date)


  if (components.day >= 7) {
    return dateString
  } else if (components.day >= 2) {
    return "\(components.day)d"
  } else if (components.hour >= 1) {
    return "\(components.hour)h"
  } else if (components.minute >= 1) {
    return "\(components.minute)m"
  } else if (components.second >= 1) {
    return "\(components.second)s"
  } else {
    return "now"
  }
}
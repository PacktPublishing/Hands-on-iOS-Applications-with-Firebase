//
//  FirebaseMagicExtensions.swift
//  CoffeeBreakExample
//
//  Created by Alex Nagy on 24/06/2018.
//  Copyright © 2018 Alex Nagy. All rights reserved.
//

import UIKit

extension Dictionary {
  mutating func update(with other:Dictionary) {
    for (key,value) in other {
      self.updateValue(value, forKey:key)
    }
  }
}

public extension CGFloat {
  
  public static func random() -> CGFloat {
    return CGFloat(CGFloat(arc4random()) / 0xFFFFFFFF)
  }
  
  public static func random(_ min: CGFloat, max: CGFloat) -> CGFloat {
    return CGFloat.random() * (max - min) + min
  }
  
}

extension Date {
  func timeAgoDisplay() -> String {
    let secondsAgo = Int(Date().timeIntervalSince(self))
    
    let minute = 60
    let hour = 60 * minute
    let day = 24 * hour
    let week = 7 * day
    let month = 4 * week
    let year = 12 * month
    
    let value: Int
    let unit: String
    if secondsAgo < minute {
      value = secondsAgo
      unit = "sec"
    } else if secondsAgo < hour {
      value = secondsAgo / minute
      unit = "min"
    } else if secondsAgo < day {
      value = secondsAgo / hour
      unit = "hour"
    } else if secondsAgo < week {
      value = secondsAgo / day
      unit = "day"
    } else if secondsAgo < month {
      value = secondsAgo / week
      unit = "week"
    } else if secondsAgo < year {
      value = secondsAgo / month
      unit = "month"
    } else {
      value = secondsAgo / year
      unit = "year"
    }
    
    return "\(value) \(unit)\(value == 1 ? "" : "s") ago"
    
  }
}

extension String {
  func firebaseKeyCompatible() -> String {
    return self.lowercased().replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "#", with: "_").replacingOccurrences(of: "$", with: "_").replacingOccurrences(of: "[", with: "_").replacingOccurrences(of: "]", with: "_").replacingOccurrences(of: "/", with: "_")
  }
}

extension UIApplication {
  class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let nav = base as? UINavigationController {
      return getTopMostViewController(base: nav.visibleViewController)
    }
    if let tab = base as? UITabBarController {
      if let selected = tab.selectedViewController {
        return getTopMostViewController(base: selected)
      }
    }
    if let presented = base?.presentedViewController {
      return getTopMostViewController(base: presented)
    }
    return base
  }
}

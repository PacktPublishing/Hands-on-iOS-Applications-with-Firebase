//
//  FirebaseMagicService.swift
//  CoffeeBreakExample
//
//  Created by Alex Nagy on 24/06/2018.
//  Copyright © 2018 Alex Nagy. All rights reserved.
//

import UIKit
import JGProgressHUD

class FirebaseMagicService {
  
  // MARK: -
  // MARK: Notification names
  
  static let notificationNameShouldDismissViewController = Notification.Name(rawValue: "shouldDismissViewController")
  static let notificationNameUserSharedAPost = Notification.Name(rawValue: "userSharedAPost")
  static let notificationNameUpdateSearchDatasourceController = Notification.Name(rawValue: "updateSearchDatasourceController")
  static let notificationNameFollowedUser = Notification.Name(rawValue: "followedUser")
  static let notificationNameUnfollowedUser = Notification.Name(rawValue: "unfollowedUser")
  static let notificationNameShowFollowers = Notification.Name(rawValue: "showFollowers")
  static let notificationNameShowFollowing = Notification.Name(rawValue: "showFollowing")
  
  // MARK: -
  // MARK: Show alert
  
  static func showAlert(style: UIAlertControllerStyle, title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "Ok", style: .cancel, handler: nil)], completion: (() -> Swift.Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    for action in actions {
      alert.addAction(action)
    }
    if let topVC = UIApplication.getTopMostViewController() {
      topVC.present(alert, animated: true, completion: completion)
    }
  }
  
  static func showAlert(style: UIAlertControllerStyle, title: String?, message: String?, textFields: [UITextField], completion: @escaping ([String]?) -> ()) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    
    for textField in textFields {
      alert.addTextField(configurationHandler: { (theTextField) in
        theTextField.placeholder = textField.placeholder
      })
    }
    
    let textFieldAction = UIAlertAction(title: "Submit", style: .cancel) { (action) in
      var textFieldsTexts: [String] = []
      if let alertTextFields = alert.textFields {
        for textField in alertTextFields {
          if let textFieldText = textField.text {
            textFieldsTexts.append(textFieldText)
          }
        }
        completion(textFieldsTexts)
      }
    }
    alert.addAction(textFieldAction)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
      completion(nil)
    }
    alert.addAction(cancelAction)
    
    if let topVC = UIApplication.getTopMostViewController() {
      topVC.present(alert, animated: true, completion: nil)
    }
    
  }
  
  // MARK: -
  // MARK: Hud
  static func showHud(_ hud: JGProgressHUD, text: String) {
    hud.textLabel.text = text
    hud.interactionType = .blockAllTouches
    if let topVC = UIApplication.getTopMostViewController() {
      topVC.navigationItem.leftBarButtonItem?.isEnabled = false
      topVC.navigationItem.rightBarButtonItem?.isEnabled = false
      hud.show(in: topVC.view, animated: true)
    }
  }
  
  static func dismiss(_ hud: JGProgressHUD, afterDelay: TimeInterval?, text: String?) {
    if let text = text {
      hud.textLabel.text = text
    }
    if let afterDelay = afterDelay {
      hud.dismiss(afterDelay: afterDelay, animated: true)
    } else {
      hud.dismiss(animated: true)
    }
    if let topVC = UIApplication.getTopMostViewController() {
      topVC.navigationItem.leftBarButtonItem?.isEnabled = true
      topVC.navigationItem.rightBarButtonItem?.isEnabled = true
    }
  }
  
}

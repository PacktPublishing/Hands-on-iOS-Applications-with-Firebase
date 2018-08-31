//
//  FirebaseMagicModels.swift
//  CoffeeBreakExample
//
//  Created by Alex Nagy on 22/05/2018.
//  Copyright © 2018 Alex Nagy. All rights reserved.
//

import Foundation

struct FirebaseMagicKeys {
  
  struct User {
    static let name = "name"
    static let username = "username"
    static let email = "email"
    static let password = "password"
    static let profileImage = "profileImage"
    static let profileImageUrl = "profileImageUrl"
    static let followersCount = "followersCount"
    static let followingCount = "followingCount"
    static let postsCount = "postsCount"
  }
  
  struct Post {
    static let id = "id"
    static let ownerId = "ownerId"
    static let imageUrl = "imageUrl"
    static let caption = "caption"
    static let creationDate = "creationDate"
  }
  
}

struct CurrentUser {
  
  let uid: String
  let name: String
  let username: String
  let profileImageUrl: String
  let email: String
  
  let followersCount: UInt
  let followingCount: UInt
  let postsCount: UInt
  
  init(uid: String, dictionary: [String : Any]) {
    self.uid = uid
    self.name = dictionary[FirebaseMagicKeys.User.name] as? String ?? ""
    self.username = dictionary[FirebaseMagicKeys.User.username] as? String ?? ""
    self.profileImageUrl = dictionary[FirebaseMagicKeys.User.profileImageUrl] as? String ?? ""
    self.email = dictionary[FirebaseMagicKeys.User.email] as? String ?? ""
    
    self.followersCount = dictionary[FirebaseMagicKeys.User.followersCount] as? UInt ?? 0
    self.followingCount = dictionary[FirebaseMagicKeys.User.followingCount] as? UInt ?? 0
    self.postsCount = dictionary[FirebaseMagicKeys.User.postsCount] as? UInt ?? 0
  }
}

struct Post {
  
  var id: String?
  
  let user: CurrentUser
  let imageUrl: String
  let caption: String
  let creationDate: Date
  
  init(user: CurrentUser, dictionary: [String : Any]) {
    self.user = user as CurrentUser
    self.imageUrl = dictionary[FirebaseMagicKeys.Post.imageUrl] as? String ?? ""
    self.caption = dictionary[FirebaseMagicKeys.Post.caption] as? String ?? ""
    
    let secondsSince1970 = dictionary[FirebaseMagicKeys.Post.creationDate] as? Double ?? 0
    self.creationDate = Date(timeIntervalSince1970: secondsSince1970)
  }
  
}

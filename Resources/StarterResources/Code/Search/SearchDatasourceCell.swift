//
//  SearchDatasourceCell.swift
//  CoffeeBreakExample
//
//  Created by Alex Nagy on 27/05/2018.
//  Copyright © 2018 Alex Nagy. All rights reserved.
//

import LBTAComponents

class SearchDatasourceCell: DatasourceCell {
  
  var profileImageViewHeight: CGFloat = 60
  lazy var profileImageView: CachedImageView = {
    var iv = CachedImageView()
    iv.backgroundColor = Setup.lightGreyColor
    iv.contentMode = .scaleAspectFill
    iv.layer.cornerRadius = profileImageViewHeight / 2
    iv.clipsToBounds = true
    return iv
  }()
  
  let usernameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = UIColor.black
    return label
  }()
  
  let postsCountLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = UIColor.gray
    return label
  }()
  
  lazy var followUnfollowButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = Setup.lightGreyColor
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.setTitleColor(Setup.blueColor, for: .normal)
    button.layer.masksToBounds = true
    button.layer.cornerRadius = 13
    button.addTarget(self, action: #selector(handleFollowUnfollowButtonTapped), for: .touchUpInside)
    return button
  }()
  
  @objc func handleFollowUnfollowButtonTapped() {
    guard let user = datasourceItem as? CurrentUser else { return }
    if followUnfollowButton.titleLabel?.text == "FOLLOW" {
      followUnfollowButton.isEnabled = false
      
      // MARK: FirebaseMagic - Follow user
      
    } else if followUnfollowButton.titleLabel?.text == "UNFOLLOW" {
      followUnfollowButton.isEnabled = false
      
      // MARK: FirebaseMagic - Unfollow user
      
    }
  }
  
  func setupUnfollowStyle() {
    NotificationCenter.default.post(name: FirebaseMagicService.notificationNameFollowedUser, object: nil, userInfo: nil)
    DispatchQueue.main.async {
      
      self.followUnfollowButton.isEnabled = true
      self.followUnfollowButton.setTitle("UNFOLLOW", for: .normal)
      self.followUnfollowButton.setTitleColor(Setup.redColor, for: .normal)
    }
  }
  
  func setupFollowStyle() {
    NotificationCenter.default.post(name: FirebaseMagicService.notificationNameUnfollowedUser, object: nil, userInfo: nil)
    DispatchQueue.main.async {
      
      self.followUnfollowButton.isEnabled = true
      self.followUnfollowButton.setTitle("FOLLOW", for: .normal)
      self.followUnfollowButton.setTitleColor(Setup.blueColor, for: .normal)
    }
  }
  
  let dividerView: UIView = {
    let view = UIView()
    view.backgroundColor = Setup.lightGreyColor
    return view
  }()
  
  override var datasourceItem: Any? {
    didSet {
      guard let user = datasourceItem as? CurrentUser else { return }
      profileImageView.loadImage(urlString: user.profileImageUrl)
      usernameLabel.text = user.username
      postsCountLabel.text = "\(user.postsCount) posts"
      
      setupFollowUnfollowButton(with: user.uid)
    }
  }
  
  func setupFollowUnfollowButton(with userId: String) {
    
    // MARK: FirebaseMagic - Setup follow / unfollow style
    
  }
  
  override func setupViews() {
    super.setupViews()
    
    addSubview(profileImageView)
    addSubview(usernameLabel)
    addSubview(postsCountLabel)
    addSubview(followUnfollowButton)
    addSubview(dividerView)
    
    profileImageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 6, leftConstant: 6, bottomConstant: 0, rightConstant: 0, widthConstant: profileImageViewHeight, heightConstant: profileImageViewHeight)
    usernameLabel.anchor(topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
    postsCountLabel.anchor(usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
    followUnfollowButton.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 23, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 120, heightConstant: 26)
    dividerView.anchor(nil, left: usernameLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
    
  }
  
}

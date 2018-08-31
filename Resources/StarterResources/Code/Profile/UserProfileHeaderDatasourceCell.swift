//
//  UserProfileHeaderDatasourceCell.swift
//  CoffeeBreakExample
//
//  Created by Alex Nagy on 22/05/2018.
//  Copyright © 2018 Alex Nagy. All rights reserved.
//

import LBTAComponents

class UserProfileHeaderDatasourceCell: DatasourceCell {
  
  let profileImageViewHeight: CGFloat = 75
  lazy var profileImageView: CachedImageView = {
    var iv = CachedImageView()
    iv.backgroundColor = Setup.lightGreyColor
    iv.contentMode = .scaleAspectFill
    iv.layer.cornerRadius = profileImageViewHeight / 2
    iv.clipsToBounds = true
    iv.layer.borderColor = Setup.greyColor.cgColor
    iv.layer.borderWidth = 0.5
    return iv
  }()
  
  let postsButton: UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: "\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.black])
    attributedTitle.append(NSMutableAttributedString(string: "posts", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: Setup.lightGreyColor]))
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.titleLabel?.numberOfLines = 0
    button.titleLabel?.textAlignment = .center
    button.backgroundColor = .white
    button.addTarget(self, action: #selector(handlePostsButtonTapped), for: .touchUpInside)
    return button
  }()
  
  @objc func handlePostsButtonTapped() {
    
  }
  
  lazy var followersButton: UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: "\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.black])
    attributedTitle.append(NSMutableAttributedString(string: "followers", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: Setup.lightGreyColor]))
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.titleLabel?.numberOfLines = 0
    button.titleLabel?.textAlignment = .center
    button.backgroundColor = .white
    button.addTarget(self, action: #selector(handleFollowersButtonTapped), for: .touchUpInside)
    return button
  }()
  
  @objc func handleFollowersButtonTapped() {
    NotificationCenter.default.post(name: FirebaseMagicService.notificationNameShowFollowers, object: nil, userInfo: nil)
  }
  
  lazy var followingButton: UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: "\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.black])
    attributedTitle.append(NSMutableAttributedString(string: "following", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: Setup.lightGreyColor]))
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.titleLabel?.numberOfLines = 0
    button.titleLabel?.textAlignment = .center
    button.backgroundColor = .white
    button.addTarget(self, action: #selector(handleFollowingButtonTapped), for: .touchUpInside)
    return button
  }()
  
  @objc func handleFollowingButtonTapped() {
    NotificationCenter.default.post(name: FirebaseMagicService.notificationNameShowFollowing, object: nil, userInfo: nil)
  }
  
  lazy var userStatsStackView: UIStackView = {
    var arrangedSubviews = [postsButton, followersButton, followingButton]
    let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 1
    return stackView
  }()
  
  let settingsButton: UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: "Edit Profile", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.black])
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.layer.masksToBounds = true
    button.layer.cornerRadius = 5
    button.layer.borderColor = Setup.greyColor.cgColor
    button.layer.borderWidth = 0.5
    button.addTarget(self, action: #selector(handleSettingsButtonTapped), for: .touchUpInside)
    return button
  }()
  
  @objc func handleSettingsButtonTapped() {
    
  }
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 13)
    label.text = " "
    label.backgroundColor = Setup.lightGreyColor
    return label
  }()
  
  let bioLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13)
    label.text = " "
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.backgroundColor = Setup.lightGreyColor
    return label
  }()
  
  let dividerView: UIView = {
    let view = UIView()
    view.backgroundColor = Setup.lightGreyColor
    return view
  }()
  
  override var datasourceItem: Any? {
    didSet {
      guard let user = datasourceItem as? CurrentUser else { return }
      profileImageView.loadImage(urlString: user.profileImageUrl)
      
      nameLabel.backgroundColor = .clear
      nameLabel.text = user.name
      
      let numberOfPosts = user.postsCount
      let attributedTitle3 = NSMutableAttributedString(string: "\(numberOfPosts)\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.black])
      attributedTitle3.append(NSMutableAttributedString(string: "posts", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.black]))
      postsButton.setAttributedTitle(attributedTitle3, for: .normal)
      
      let numberOfFollowers = user.followersCount
      let attributedTitle = NSMutableAttributedString(string: "\(numberOfFollowers)\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.black])
      attributedTitle.append(NSMutableAttributedString(string: "followers", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.black]))
      followersButton.setAttributedTitle(attributedTitle, for: .normal)
      
      let numberOfFollowing = user.followingCount
      let attributedTitle2 = NSMutableAttributedString(string: "\(numberOfFollowing)\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.black])
      attributedTitle2.append(NSMutableAttributedString(string: "following", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.black]))
      followingButton.setAttributedTitle(attributedTitle2, for: .normal)
      
      bioLabel.backgroundColor = .clear
      bioLabel.text = "Learn to code & build an app business with me. Teacher. Coder. Coffee drinker. Learn to Code the Easy Way 👇"
      
    }
  }
  
  override func setupViews() {
    super.setupViews()
    
    addSubview(profileImageView)
    addSubview(nameLabel)
    addSubview(userStatsStackView)
    addSubview(settingsButton)
    addSubview(bioLabel)
    addSubview(dividerView)
    
    profileImageView.anchor(safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: profileImageViewHeight, heightConstant: profileImageViewHeight)
    nameLabel.anchor(profileImageView.bottomAnchor, left: profileImageView.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 18)
    userStatsStackView.anchor(safeAreaLayoutGuide.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
    settingsButton.anchor(userStatsStackView.bottomAnchor, left: userStatsStackView.leftAnchor, bottom: nil, right: userStatsStackView.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 24)
    bioLabel.anchor(nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: bottomAnchor, right: nameLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    dividerView.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
  }
  
}

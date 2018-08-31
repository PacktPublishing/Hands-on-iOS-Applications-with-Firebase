//
//  HomePostDatasourceCell.swift
//  CoffeeBreakExample
//
//  Created by Alex Nagy on 27/05/2018.
//  Copyright © 2018 Alex Nagy. All rights reserved.
//

import LBTAComponents

class HomePostDatasourceCell: DatasourceCell {
  
  let profileImageViewHeight: CGFloat = 32
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
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 13)
    label.text = " "
    label.backgroundColor = Setup.lightGreyColor
    return label
  }()
  
  let imageViewHeight: CGFloat = ScreenSize.width
  lazy var imageView: CachedImageView = {
    let imageView = CachedImageView()
    imageView.backgroundColor = Setup.lightGreyColor
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleMediaImageViewTapped))
    imageView.addGestureRecognizer(tap)
    imageView.isUserInteractionEnabled = true
    return imageView
  }()
  
  @objc fileprivate func handleMediaImageViewTapped() {
    
  }
  
  let captionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13)
    label.text = " "
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.backgroundColor = Setup.lightGreyColor
    return label
  }()
  
  let timeStampLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.backgroundColor = Setup.lightGreyColor
    label.textColor = Setup.greyColor
    return label
  }()
  
  override var datasourceItem: Any? {
    didSet {
      guard let post = datasourceItem as? Post else { return }
      profileImageView.loadImage(urlString: post.user.profileImageUrl)
      
      nameLabel.backgroundColor = .clear
      nameLabel.text = post.user.username
      
      imageView.loadImage(urlString: post.imageUrl)
      
      captionLabel.backgroundColor = .clear
      captionLabel.text = post.caption
      
      timeStampLabel.backgroundColor = .clear
      let timeAgoDisplay = post.creationDate.timeAgoDisplay().uppercased()
      timeStampLabel.text = timeAgoDisplay
    }
  }
  
  override func setupViews() {
    super.setupViews()
    
    addSubview(profileImageView)
    addSubview(nameLabel)
    addSubview(imageView)
    addSubview(captionLabel)
    addSubview(timeStampLabel)
    
    profileImageView.anchor(safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: profileImageViewHeight, heightConstant: profileImageViewHeight)
    nameLabel.anchor(safeAreaLayoutGuide.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, topConstant: 14, leftConstant: 8, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 18)
    imageView.anchor(profileImageView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: imageViewHeight, heightConstant: imageViewHeight)
    captionLabel.anchor(imageView.bottomAnchor, left: leftAnchor, bottom: timeStampLabel.topAnchor, right: rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 0)
    timeStampLabel.anchor(captionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 18)
  }
}

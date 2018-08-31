//
//  SharePostViewController.swift
//  CoffeeBreakExample
//
//  Created by Alex Nagy on 23/05/2018.
//  Copyright © 2018 Alex Nagy. All rights reserved.
//

import LBTAComponents
import JGProgressHUD

class SharePostViewController: UIViewController {
  
  var image: UIImage?
  
  let imageViewHeight: CGFloat = 100
  lazy var imageView: CachedImageView = {
    var iv = CachedImageView()
    iv.backgroundColor = Setup.lightGreyColor
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.layer.borderColor = Setup.greyColor.cgColor
    iv.layer.borderWidth = 0.5
    iv.image = image
    return iv
  }()
  
  lazy var captionTextView: UITextView = {
    var tv = UITextView()
    tv.font = UIFont.systemFont(ofSize: 14)
    tv.layer.masksToBounds = true
    tv.layer.cornerRadius = 5
    tv.layer.borderColor = Setup.greyColor.cgColor
    tv.layer.borderWidth = 0.5
    return tv
  }()
  
  lazy var shareBarButtonItem: UIBarButtonItem = {
    var item = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(handleShareBarButtonItemTapped))
    return item
  }()
  
  @objc func handleShareBarButtonItemTapped() {
    sharePost(image: imageView.image, caption: captionTextView.text)
  }
  
  fileprivate func sharePost(image: UIImage?, caption: String?) {
    guard let image = image, let caption = caption else {
      FirebaseMagicService.showAlert(style: .alert, title: "Share error", message: "Invalid image or caption")
      return
    }
    
    if caption.isEmpty {
      FirebaseMagicService.showAlert(style: .alert, title: "Error", message: "Please add a caption and try again")
    } else {
      // Mark: FirebaseMagic - Share post
    }
  }
  
  lazy var cancelBarButtonItem: UIBarButtonItem = {
    var item = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelBarButtonItemTapped))
    return item
  }()
  
  @objc func handleCancelBarButtonItemTapped() {
    self.dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    view.backgroundColor = .white
    navigationItem.title = "Add a Caption"
    navigationItem.setRightBarButton(shareBarButtonItem, animated: false)
    navigationItem.setLeftBarButton(cancelBarButtonItem, animated: false)
    
    setupViews()
  }
  
  fileprivate func setupViews() {
    view.addSubview(imageView)
    view.addSubview(captionTextView)
    
    imageView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: imageViewHeight, heightConstant: imageViewHeight)
    captionTextView.anchor(imageView.topAnchor, left: imageView.rightAnchor, bottom: imageView.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
  }
}

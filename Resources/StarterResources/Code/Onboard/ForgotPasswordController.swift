//
//  ForgotPasswordController.swift
//  CoffeeBreakExample
//
//  Created by Alex Nagy on 21/05/2018.
//  Copyright © 2018 Alex Nagy. All rights reserved.
//

import LBTAComponents
import JGProgressHUD

class ForgotPasswordController: UIViewController {
  
  let textFieldFontSize: CGFloat = 17
  let textFieldHeight: CGFloat = 30
  lazy var usernameOrEmailTextField: UITextField = {
    var tf = UITextField()
    tf.borderStyle = .roundedRect
    tf.placeholder = "Username or Email"
    tf.autocapitalizationType = .none
    tf.font = .systemFont(ofSize: textFieldFontSize)
    tf.addTarget(self, action: #selector(checkAllTextFields), for: .editingChanged)
    return tf
  }()
  
  @objc func checkAllTextFields() {
    guard let email = usernameOrEmailTextField.text else { return }
    
    let isFormValid = email.count > 0
    
    if isFormValid {
      resetPasswordBarButtonItem.isEnabled = true
    } else {
      resetPasswordBarButtonItem.isEnabled = false
    }
  }
  
  let detailsTextLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.text = "Enter your email or username above, and we’ll send\n you instructions to reset your password."
    label.textAlignment = .center
    label.textColor = Setup.lightGreyColor
    label.font = UIFont.systemFont(ofSize: 13)
    return label
  }()
  
  var resetPasswordBarButtonItem: UIBarButtonItem = {
    var item = UIBarButtonItem(title: "Send", style: .done, target: self, action: #selector(handleResetPasswordBarButtonItemTapped))
    item.isEnabled = false
    return item
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    navigationItem.title = "Reset Password"
    let cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelBarButtonItemTapped))
    navigationItem.setLeftBarButton(cancelBarButtonItem, animated: false)
    navigationItem.setRightBarButton(resetPasswordBarButtonItem, animated: false)
    setupViews()
  }
  
  @objc func handleCancelBarButtonItemTapped() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func handleResetPasswordBarButtonItemTapped() {
    // MARK: FirebaseMagic - Reset password
  }
  
  func dismissForgotPasswordController() {
    DispatchQueue.main.async {
      self.handleCancelBarButtonItemTapped()
    }
  }
  
  func setupViews() {
    view.addSubview(usernameOrEmailTextField)
    view.addSubview(detailsTextLabel)
    
    usernameOrEmailTextField.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 24, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
    detailsTextLabel.anchor(usernameOrEmailTextField.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 48, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
  }
}

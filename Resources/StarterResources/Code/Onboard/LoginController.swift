//
//  LoginController.swift
//  CoffeeBreakExample
//
//  Created by Alex Nagy on 21/05/2018.
//  Copyright © 2018 Alex Nagy. All rights reserved.
//

import LBTAComponents
import JGProgressHUD

class LoginController: UIViewController {
  
  let textFieldFontSize: CGFloat = 17
  let textFieldHeight: CGFloat = 30
  lazy var usernameOrEmailTextField: UITextField = {
    var tf = UITextField()
    tf.borderStyle = .roundedRect
    tf.autocapitalizationType = .none
    tf.placeholder = "Username or Email"
    tf.font = .systemFont(ofSize: textFieldFontSize)
    tf.addTarget(self, action: #selector(checkAllTextFields), for: .editingChanged)
    return tf
  }()
  
  lazy var passwordTextField: UITextField = {
    var tf = UITextField()
    tf.borderStyle = .roundedRect
    tf.isSecureTextEntry = true
    tf.placeholder = "Password"
    tf.font = .systemFont(ofSize: textFieldFontSize)
    tf.addTarget(self, action: #selector(checkAllTextFields), for: .editingChanged)
    return tf
  }()
  
  @objc func checkAllTextFields() {
    guard let email = usernameOrEmailTextField.text else { return }
    guard let password = passwordTextField.text else { return }
    
    let isFormValid = email.count > 0 && password.count > 0
    
    if isFormValid {
      loginBarButtonItem.isEnabled = true
    } else {
      loginBarButtonItem.isEnabled = false
    }
  }
  
  let forgotPasswordButton: UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: "Forgot your password?", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: Setup.blueColor])
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(handleForgotPasswordButtonTapped), for: .touchUpInside)
    return button
  }()
  
  @objc func handleForgotPasswordButtonTapped() {
    let forgotPasswordController = ForgotPasswordController()
    navigationController?.pushViewController(forgotPasswordController, animated: true)
  }
  
  let signUpButton: UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: Setup.lightGreyColor])
    attributedTitle.append(NSMutableAttributedString(string: "Sign Up", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: Setup.blueColor]))
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(handleSignUpButtonTapped), for: .touchUpInside)
    return button
  }()
  
  @objc func handleSignUpButtonTapped() {
    let signUpController = SignUpController()
    navigationController?.pushViewController(signUpController, animated: true)
  }
  
  var loginBarButtonItem: UIBarButtonItem = {
    var item = UIBarButtonItem(title: "Login", style: .done, target: self, action: #selector(handleLoginBarButtonItemTapped))
    item.isEnabled = false
    return item
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    navigationItem.title = "Login"
    let cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelBarButtonItemTapped))
    navigationItem.setLeftBarButton(cancelBarButtonItem, animated: false)
    navigationItem.setRightBarButton(loginBarButtonItem, animated: false)
    setupViews()
  }
  
  @objc func handleCancelBarButtonItemTapped() {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func handleLoginBarButtonItemTapped() {
    
    // Mark: FirebaseMagic - Log in user with email
    
  }
  
  func dismissLoginController() {
    guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
    DispatchQueue.main.async {
      mainTabBarController.setupViewControllers()
      self.dismiss(animated: true, completion: nil)
      self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
  }
  
  func setupViews() {
    view.addSubview(usernameOrEmailTextField)
    view.addSubview(passwordTextField)
    view.addSubview(forgotPasswordButton)
    
    usernameOrEmailTextField.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 18, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: textFieldHeight)
    passwordTextField.anchor(usernameOrEmailTextField.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: textFieldHeight)
    forgotPasswordButton.anchor(passwordTextField.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 30, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 50)
  }
}

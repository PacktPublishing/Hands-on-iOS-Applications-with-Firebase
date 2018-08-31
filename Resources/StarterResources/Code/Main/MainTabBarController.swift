//
//  MainTabBarController.swift
//  CoffeeBreakExample
//
//  Created by Alex Nagy on 21/05/2018.
//  Copyright © 2018 Alex Nagy. All rights reserved.
//

import UIKit
import JGProgressHUD

class MainTabBarController: UITabBarController, UITabBarControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    view.backgroundColor = .white
    self.delegate = self
    
    // MARK: FirebaseMagic - Check if user is signed in
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setupViewControllers() {
    tabBar.unselectedItemTintColor = Setup.mainTabBarItemUnselectedTintColor
    tabBar.tintColor = Setup.mainTabBarItemTintColor
    
    let homeController = HomeDatasourceController()
    let searchController = SearchDatasourceController()
    let dummyAddPostController = DummyAddPostViewController()
    let activityController = ActivityDatasourceController()
    let userProfileController = UserProfileDatasourceController()
    
    let homeNavController = UINavigationController(rootViewController: homeController)
    let searchNavController = UINavigationController(rootViewController: searchController)
    let dummyNavAddPostController = UINavigationController(rootViewController: dummyAddPostController)// is overriden above in tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController)
    let activityNavController = UINavigationController(rootViewController: activityController)
    let userProfileNavController = UINavigationController(rootViewController: userProfileController)
    
    homeNavController.tabBarItem.image = #imageLiteral(resourceName: "MainTabBarItemHomeUnselected").withRenderingMode(.alwaysTemplate)
    homeNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "MainTabBarItemHomeSelected").withRenderingMode(.alwaysTemplate)
    searchNavController.tabBarItem.image = #imageLiteral(resourceName: "MainTabBarItemSearchUnselected").withRenderingMode(.alwaysTemplate)
    searchNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "MainTabBarItemSearchSelected").withRenderingMode(.alwaysTemplate)
    dummyNavAddPostController.tabBarItem.image = #imageLiteral(resourceName: "MainTabBarItemAddPost").withRenderingMode(.alwaysTemplate)
    dummyNavAddPostController.tabBarItem.selectedImage = #imageLiteral(resourceName: "MainTabBarItemAddPost").withRenderingMode(.alwaysTemplate)
    activityNavController.tabBarItem.image = #imageLiteral(resourceName: "MainTabBarItemActivityUnselected").withRenderingMode(.alwaysTemplate)
    activityNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "MainTabBarItemActivitySelected").withRenderingMode(.alwaysTemplate)
    userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "MainTabBarItemProfileUnselected").withRenderingMode(.alwaysTemplate)
    userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "MainTabBarItemProfileSelected").withRenderingMode(.alwaysTemplate)
    
    viewControllers = [homeNavController, searchNavController, dummyNavAddPostController, activityNavController, userProfileNavController]
    
    guard let items = tabBar.items else { return }
    for item in items {
      item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
      
    }
    
  }
  
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    let index = viewControllers?.index(of: viewController)
    if index == 2 {
      showChooseSourceTypeAlertController()
      return false
    }
    return true
  }
  
  func showChooseSourceTypeAlertController() {
    let photoLibraryAction = UIAlertAction(title: "Choose a Photo", style: .default) { (action) in
      self.showImagePickerController(sourceType: .photoLibrary)
    }
    let cameraAction = UIAlertAction(title: "Take a New Photo", style: .default) { (action) in
      self.showImagePickerController(sourceType: .camera)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    FirebaseMagicService.showAlert(style: .actionSheet, title: nil, message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
  }
  
  func showImagePickerController(sourceType: UIImagePickerControllerSourceType) {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.allowsEditing = true
    imagePickerController.sourceType = sourceType
    present(imagePickerController, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    dismiss(animated: true) {
      DispatchQueue.main.async {
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
          self.presentPublishPostViewController(with: editedImage)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
          self.presentPublishPostViewController(with: originalImage)
        }
      }
    }
  }
  
  func presentPublishPostViewController(with image: UIImage) {
    let controller = SharePostViewController()
    controller.image = image
    let navController = UINavigationController(rootViewController: controller)
    present(navController, animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }

}


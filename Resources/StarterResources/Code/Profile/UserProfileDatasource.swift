//
//  UserProfileDatasource.swift
//  CoffeeBreakExample
//
//  Created by Alex Nagy on 22/05/2018.
//  Copyright © 2018 Alex Nagy. All rights reserved.
//

import LBTAComponents
import JGProgressHUD

class UserProfileDatasource: Datasource {
  
  var user: CurrentUser?
  
  override func headerClasses() -> [DatasourceCell.Type]? {
    return [UserProfileHeaderDatasourceCell.self]
  }
  
  override func cellClasses() -> [DatasourceCell.Type] {
    return [UserProfilePostDatasourceCell.self]
  }
  
  override func headerItem(_ section: Int) -> Any? {
    return user
  }
  
  override func item(_ indexPath: IndexPath) -> Any? {
    // MARK: FirebaseMagic - Insert item on user profile
    return 0
  }
  
  override func numberOfItems(_ section: Int) -> Int {
    // MARK: FirebaseMagic - Number of items on user profile
    return 0
  }
  
}

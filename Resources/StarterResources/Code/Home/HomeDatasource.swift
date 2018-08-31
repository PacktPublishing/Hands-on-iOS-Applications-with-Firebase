//
//  HomeDatasource.swift
//  CoffeeBreakExample
//
//  Created by Alex Nagy on 27/05/2018.
//  Copyright © 2018 Alex Nagy. All rights reserved.
//

import LBTAComponents
import JGProgressHUD

class HomeDatasource: Datasource {
  
  var user: CurrentUser?
  
  override func cellClasses() -> [DatasourceCell.Type] {
    return [HomePostDatasourceCell.self]
  }
  
  override func headerItem(_ section: Int) -> Any? {
    return user
  }
  
  override func item(_ indexPath: IndexPath) -> Any? {
    // MARK: FirebaseMagic - Insert item on home feed
    return 0
  }
  
  override func numberOfItems(_ section: Int) -> Int {
    // MARK: FirebaseMagic - Number of items on home feed
    return 0
  }
  
}

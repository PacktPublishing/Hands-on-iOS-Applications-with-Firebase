//
//  UserStatsDatasource.swift
//  CoffeeBreakExample
//
//  Created by Alex Nagy on 27/05/2018.
//  Copyright © 2018 Alex Nagy. All rights reserved.
//

import LBTAComponents

class UserStatsDatasource: Datasource {
  
  var statsType: FirebaseMagic.StatFetchType = .followers
  
  override func cellClasses() -> [DatasourceCell.Type] {
    return [UserStatsDatasourceCell.self]
  }
  
  override func item(_ indexPath: IndexPath) -> Any? {
    // MARK: FirebaseMagic - Insert item on user stats
    return 0
  }
  
  override func numberOfItems(_ section: Int) -> Int {
    // MARK: FirebaseMagic - Number of items on user stats
    return 0
  }
  
}

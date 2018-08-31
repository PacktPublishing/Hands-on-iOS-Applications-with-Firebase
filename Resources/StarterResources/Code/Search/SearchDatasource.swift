//
//  SearchDatasource.swift
//  CoffeeBreakExample
//
//  Created by Alex Nagy on 27/05/2018.
//  Copyright © 2018 Alex Nagy. All rights reserved.
//


import LBTAComponents

class SearchDatasource: Datasource {
  
  var filteredUsers = [CurrentUser]()
  var users = [CurrentUser]()
  
  override func cellClasses() -> [DatasourceCell.Type] {
    return [SearchDatasourceCell.self]
  }
  
  override func item(_ indexPath: IndexPath) -> Any? {
    return filteredUsers[indexPath.item]
  }
  
  override func numberOfItems(_ section: Int) -> Int {
    return filteredUsers.count
  }
  
  func filterUsersWith(_ searchText: String, in collectionViewController: UICollectionViewController) {
    if searchText.isEmpty {
      filteredUsers = users
      collectionViewController.collectionView?.reloadData()
    } else {
      // MARK: FirebaseMagic - Fetch filtered users with count limit
    }
  }
  
}

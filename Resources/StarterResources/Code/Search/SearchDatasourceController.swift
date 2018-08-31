//
//  SearchDatasourceController.swift
//  CoffeeBreakExample
//
//  Created by Alex Nagy on 21/05/2018.
//  Copyright © 2018 Alex Nagy. All rights reserved.
//

import LBTAComponents

class SearchDatasourceController: DatasourceController, UISearchBarDelegate {
  
  lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "Search"
    searchBar.autocapitalizationType = .none
    var textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
    textFieldInsideSearchBar?.backgroundColor = Setup.lightGreyColor
    searchBar.delegate = self
    return searchBar
  }()
  
  let searchDatasource = SearchDatasource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateSearchDatasourceController), name: FirebaseMagicService.notificationNameUpdateSearchDatasourceController, object: nil)
    
    collectionView?.backgroundColor = .white
    collectionView?.alwaysBounceVertical = true
    collectionView?.keyboardDismissMode = .onDrag
    collectionView?.showsVerticalScrollIndicator = false
    guard let navBar = navigationController?.navigationBar else { return }
    navBar.barTintColor = .white
    navigationItem.titleView = searchBar
    
    datasource = searchDatasource

  }
  
  @objc func handleUpdateSearchDatasourceController() {
    collectionView?.reloadData()
  }
  
  override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: ScreenSize.width, height: 72)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    searchDatasource.filterUsersWith(searchText, in: self)
  }
  
}


















//
//  SearchController.swift
//  Instagram
//
//  Created by Jenny Woorim Lee on 2021/03/09.
//

import UIKit

private let identifier = "UserCell"


class SearchController: UITableViewController {
    
    //MARK: - Properties
    private var users = [User]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filterUsers = [User]()
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureTableView()
        fetchUsers()
    }
    
    func fetchUsers() {
        UserService.fetchUsers { (users) in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Helpers
    func configureTableView() {
        tableView.register(UserCell.self, forCellReuseIdentifier: identifier)
        tableView.rowHeight = 64
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filterUsers.count : users.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! UserCell
        
        let user = inSearchMode ? filterUsers[indexPath.row] : users[indexPath.row]
        cell.viewModel = UserCellViewModel(user: user)
        
        return cell
    }
    
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? filterUsers[indexPath.row] : users[indexPath.row]
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UISearchResultUpdating
extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        
        filterUsers = users.filter({
            $0.username.contains(searchText) || $0.fullname.lowercased().contains(searchText)
            
        })
        
        self.tableView.reloadData()
        
    }
    
    
}

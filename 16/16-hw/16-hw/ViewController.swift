//
//  ViewController.swift
//  16-hw
//
//  Created by user on 11/19/25.
//

import UIKit

class ViewController: UIViewController {
  
  private var users: [User] = []
  private var isLoading = false
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 80
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    loadInitialUsers()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    refreshUsers()
  }
  
  private func refreshUsers() {
    users = UserRepository.shared.getUsers()
    tableView.reloadData()
  }

  private func setup() {
    view.backgroundColor = .systemBackground
    navigationItem.title = "Users"
    navigationController?.navigationBar.prefersLargeTitles = true
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
  
  private func loadInitialUsers() {
    fetchUsers()
  }
  
  private func fetchUsers() {
    guard !isLoading && users.isEmpty else { return }
    isLoading = true
    
    DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) { [weak self] in
      guard let self = self else { return }
      
      let newUsers = UserRepository.shared.getUsers()
      self.users = newUsers
      
      DispatchQueue.main.async {
        self.isLoading = false
        self.tableView.reloadData()
      }
    }
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: UserTableViewCell.identifier,
      for: indexPath
    ) as! UserTableViewCell
    cell.configure(with: users[indexPath.row])
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let selectedUser = users[indexPath.row]
    let vc = UserDetailViewController()
    vc.user = selectedUser
    vc.delegate = self
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension ViewController: UserDetailViewControllerDelegate {
  func userDetailViewController(_ controller: UserDetailViewController, didUpdateUser user: User) {
    refreshUsers()
  }
}


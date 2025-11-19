//
//  ViewController.swift
//  16
//
//  Created by user on 11/15/25.
//

import UIKit

class ViewController: UIViewController {
  
  private var viewModel: [[String]] = []

  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    fetchData()
  }

  private func setup() {
    view.backgroundColor = .systemBackground
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
  ])
  }
  
  private func fetchData() {
    DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [self] in
      viewModel = [
        Array(repeating: "0", count: 10),
        Array(repeating: "1", count: 20),
        Array(repeating: "2", count: 30),
        Array(repeating: "3", count: 30),
      ]
      DispatchQueue.main.async { [self] in
        self.tableView.reloadData()
      }
    }
  }
}

extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    viewModel.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "cell",
      for: indexPath
    )
    cell.textLabel?.text = viewModel[indexPath.section][indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Section: \(section)"
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return 44
    }
    if indexPath.section == 1 {
      return 88
    }
    return 120
  }
}

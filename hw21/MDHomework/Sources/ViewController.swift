//
//  ViewController.swift
//  MDHomework
//
//  Created by Илья Капёрский on 17.09.2023.
//

import UIKit
import Foundation
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    
    var model = [Character]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        vcSettings()
        setupHierarchy()
        setupLayout()
        getData()
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    private func vcSettings() {
        view.backgroundColor = .systemCyan
        title = "MARVEL"
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemRed
               ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        detailVC.character = cell.character
        
        navigationController?.pushViewController(detailVC, animated: true)

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let character = model[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as? TableViewCell
        cell?.character = character
        return cell ?? UITableViewCell()
    }
    
    func getData() {
        let request = AF.request("https://gateway.marvel.com/v1/public/characters?ts=1&apikey=f85865d962e7db44477b478f45ac83ed&hash=4e4a85782dc48dd3f18232688703eed2")
        request.responseDecodable(of: CharacterDataWrapper.self) { (data) in
            if let error = data.error {print(String(describing: error))}
            guard let char = data.value else { return }
            let characters = char.data?.results
            DispatchQueue.main.async {
                self.model = characters!
                self.tableView.reloadData()
            }
        }
    }
}





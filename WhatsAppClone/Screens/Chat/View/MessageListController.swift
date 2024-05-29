//
//  MessageListController.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import Foundation
import UIKit
import SwiftUI

final class MessageListController:UIViewController{
    //MARK: -  View's lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    //MARK: - Properties
    private let cellIdentifier = "MessageListControllerCells"
    private lazy var tableView :UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
//        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
        // create tableView here
    }()
    
    //MARK: - Methods
    private func setUpViews(){
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        // register tableView here
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension MessageListController:UITableViewDelegate,UITableViewDataSource{
    /// use a UIKit tableView, use a SwifUI view as the cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        // 使在UIKit内部可以使用SwiftUI来填充单元格
        cell.contentConfiguration = UIHostingConfiguration{
            BubbleTextView(item: .sentPlaceHolder)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

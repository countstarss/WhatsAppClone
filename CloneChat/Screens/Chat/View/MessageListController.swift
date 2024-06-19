//
//  MessageListController.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import Foundation
import UIKit
import SwiftUI
import Combine

final class MessageListController:UIViewController{
    //MARK: -  View's lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpMessageListners()
    }
    
    // 注入viewModel
    init(_ viewModel: ChatRoomViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        // subScriptions是存储的messages，在生命周期结束之后
        subScriptions.forEach{ $0.cancel() }
        subScriptions.removeAll()
    }
    
    // UIKit固定格式
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties
    private let viewModel : ChatRoomViewModel
    private let cellIdentifier = "MessageListControllerCells"
    // 创建初始化订阅
    private var subScriptions = Set<AnyCancellable>()
    private lazy var tableView :UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
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
    
    
    // 监听器
    // sink取出messages里面的message，并且更新data，
    // 把返回的Set<AnyCancellable>()存到subScriptions
    private func setUpMessageListners() {
        let delay = 200
        viewModel.$messages
            .debounce(for: .milliseconds(delay), scheduler: DispatchQueue.main)
            .sink { [weak self]  _ in
                self?.tableView.reloadData()
            } // 存储订阅
            .store(in: &subScriptions)
    }
    
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension MessageListController:UITableViewDelegate,UITableViewDataSource{
    /// use a UIKit tableView, use a SwifUI view as the cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
//        let message = MessageItem.stubMessage[indexPath.row]
        let message = viewModel.messages[indexPath.row]
        
        // 使在UIKit内部可以使用SwiftUI来填充单元格
        cell.contentConfiguration = UIHostingConfiguration{
            switch message.type{
            case .text:
                BubbleTextView(item: message)
//                    .frame(maxWidth: .infinity)
            case .video ,.photo:
                BubbleImageView(item: message)
//                    .background(.red)
            case .audio:
                BubbleAudioView(item: message)
//                    .background(.indigo)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


#Preview {
    MessageListView(viewModel: ChatRoomViewModel(channel: .placeholder))
}

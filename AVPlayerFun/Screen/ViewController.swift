//
//  ViewController.swift
//  AVPlayerFun
//
//  Created by Fabio Acri on 01/02/2020.
//  Copyright © 2020 Fabio Acri. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

protocol ViewControllerInterface: class {
    func configureAVManager(with manager: AVManagerInterface)
    func configureTableView()
    func onFailed()
}

final class ViewController: UIViewController {
    
    // MARK: - properties
    
    private enum Constants {
        static let heightLineForHeader: CGFloat = 40.0
        static let heightForHeader: CGFloat = 32.0
        static let estimatedRowHeight: CGFloat = 30.0
        static let cellTextHeight: CGFloat = 24.0
    }

    var presenter: ViewPresenterInterface?
    private var avManager: AVManagerInterface?
    private var tableView: UITableView?
    
    // MARK: - functions
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        presenter = ViewPresenter(view: self)
        presenter?.onViewDidLoad()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        var viewFrame = view.frame
        viewFrame.size = size
        tableView?.frame = viewFrame
    }
}

extension ViewController: ViewControllerInterface {
    func configureAVManager(with manager: AVManagerInterface) {
        avManager = manager
    }
    
    func configureTableView() {
        setTableView()
    }

    func onFailed() {
        tableView?.isHidden = true
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: Constants.heightLineForHeader))
        label.font = UIFont(name: "System", size: Constants.heightForHeader)
        label.text = "Videos couldn't be loaded"
        label.textColor = .white
        label.textAlignment = .center
        view.addSubview(label)
        label.center = view.center
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.contentSize.width, height: Constants.heightLineForHeader))
        label.font = UIFont(name: "System", size: Constants.heightForHeader)
        label.text = "Videos"
        label.textColor = .white
        view.addSubview(label)
        view.backgroundColor = .darkGray
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.heightLineForHeader
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont(name: "System", size: Constants.cellTextHeight)
        cell.textLabel?.text = presenter?.cellText(at: indexPath.row)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black

        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let avManager = avManager, avManager.hasItems() {
            let expandedController = AVPlayerViewController()
            avManager.preSetVideo(into: expandedController, at: indexPath.row)
            present(expandedController, animated: true, completion: {
                avManager.playVideo()
            })
        }
    }
}

private extension ViewController {
    func setTableView() {
        if tableView == nil {
            tableView = UITableView(frame: view.bounds)
        }
        
        if let tableView = tableView {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = .black
            tableView.tableFooterView = UIView()
            tableView.separatorColor = .lightGray
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = Constants.estimatedRowHeight
            
            view.addSubview(tableView)
            self.tableView = tableView
        }
    }
}

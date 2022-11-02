//
//  TableViewController.swift
//  CryptoApp
//
//  Created by Яна Дударева on 07.10.2022.
//

import Foundation
import UIKit
import SnapKit

class TableViewController: UIViewController {
    
    private let cell = "Cell"
    private var viewModel: TableViewModelProtocol?
    
    //MARK: Outlets
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(Cell.self, forCellReuseIdentifier: cell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        return tableView
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        var activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    //MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        viewModel = TableViewModel()
        
        viewModel?.getData() {
            DispatchQueue.main.async {
                self.viewModel?.checkSort(tableView: self.tableView)
                self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
            }
        }
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    //MARK: Actions
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    //MARK: SetupViews
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        tableView.addSubview(refreshControl)
    }
    
    func setupNavigationBar() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Messari Assets"
        
        
        let leftBarButtonMenu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Log Out", comment: ""), image: UIImage(systemName: "arrow.backward"), handler: { _ in
                self.viewModel?.setupLeftNavigationBar()
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.goToLoginViewController(selfVC: self)
            })
        ])
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Settings", image: nil, primaryAction: nil, menu: leftBarButtonMenu)
        
        let rightBarButtonMenu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Price ascending", comment: ""), image: UIImage(systemName: "arrow.down"), handler: { _ in
                self.viewModel?.setupRightNavigationBar(set: UserDefaultsKeys.sortAscending, remove: UserDefaultsKeys.sortDescending)
                self.viewModel?.sortCrypto(tableView: self.tableView, sortType: .priceAscending)
                
            }),
            UIAction(title: NSLocalizedString("Price descending", comment: ""), image: UIImage(systemName: "arrow.up"), handler: { _ in
                self.viewModel?.setupRightNavigationBar(set: UserDefaultsKeys.sortDescending, remove: UserDefaultsKeys.sortAscending)
                self.viewModel?.sortCrypto(tableView: self.tableView, sortType: .priceDescending)
            })
        ])
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", image: nil, primaryAction: nil, menu: rightBarButtonMenu)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}

//MARK: TableView Extensions

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell) as? Cell
        cell?.viewModel = viewModel?.crypto(at: indexPath.row)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.viewModel = viewModel?.crypto(at: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension TableViewController: UITableViewDelegate {}

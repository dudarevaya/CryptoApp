//
//  TableViewModel.swift
//  CryptoApp
//
//  Created by Яна Дударева on 07.10.2022.
//

import Foundation
import UIKit

class TableViewModel: TableViewModelProtocol {
    
    private let networkManager = NetworkManager.shared
    private var cryptoData: [CryptoData] = []
    
    func getData(completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        for str in StrCrypto.cryptoSymbols {
            dispatchGroup.enter()
            networkManager.fetchData(strData: str) { [weak self] in
                self?.cryptoData = self?.networkManager.cryptoArray ?? [CryptoData]()
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion()
            print("success")
        }
    }
    
    func count() -> Int {
        return cryptoData.count
    }
    
    func crypto(at index: Int) -> CryptoData {
        return cryptoData[index]
    }
    
    func sortCrypto(tableView: UITableView, sortType: Sorting) {
        switch sortType {
        case .priceDescending:
            self.cryptoData.sort { $0.data.marketData.priceUsd > $1.data.marketData.priceUsd }
            tableView.reloadData()
        case .priceAscending:
            self.cryptoData.sort { $0.data.marketData.priceUsd < $1.data.marketData.priceUsd }
            tableView.reloadData()
        }
    }
    
    func checkSort(tableView: UITableView) {
        if UserDefaults.standard.string(forKey: UserDefaultsKeys.sortAscending) != nil {
            sortCrypto(tableView: tableView, sortType: .priceAscending)
        } else {
            sortCrypto(tableView: tableView, sortType: .priceDescending)
        }
    }
    
    func setupRightNavigationBar(set: String, remove: String) {
        UserDefaults.standard.set(set, forKey: set)
        UserDefaults.standard.removeObject(forKey: remove)
    }
    
    func setupLeftNavigationBar() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isLogged)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.sortAscending)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.sortDescending)
    }
}

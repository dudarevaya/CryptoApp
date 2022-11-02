//
//  TableViewModelProtocol.swift
//  CryptoApp
//
//  Created by Яна Дударева on 07.10.2022.
//

import Foundation
import UIKit

protocol TableViewModelProtocol {
    func getData(completion: @escaping () -> Void)
    func count() -> Int
    func crypto(at index: Int) -> CryptoData
    func sortCrypto(tableView: UITableView, sortType: Sorting)
    func checkSort(tableView: UITableView)
    func setupRightNavigationBar(set: String, remove: String)
    func setupLeftNavigationBar()
}

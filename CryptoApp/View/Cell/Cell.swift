//
//  Cell.swift
//  CryptoApp
//
//  Created by Яна Дударева on 07.10.2022.
//

import Foundation
import UIKit
import SnapKit

class Cell: UITableViewCell {
    
    //MARK: ViewModel
    
    var viewModel: CryptoViewModelProtocol? {
        didSet {
            bindViewModel()
        }
    }
    
    //MARK: Outlets
    
    private lazy var name: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var symbol: UILabel = {
        var label = UILabel()
        
        return label
    }()
    
    private lazy var priceUsd: UILabel = {
        var label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var persentChangeUsdLast24Hours: UILabel = {
        var label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    private lazy var image: UIImageView = {
        var image = UIImageView()
        image.backgroundColor = .systemGray4
        image.layer.cornerRadius = 25
        return image
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.frame = CGRect(x: 20, y: 20, width: 10, height: 10)
        return view
    }()
    
    //MARK: init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Bind
    
    private func bindViewModel() {
        let dispatchGroup = DispatchGroup()
        if let vm = viewModel {
            dispatchGroup.enter()
            DispatchQueue.main.async(group: dispatchGroup) { [weak self] in
                self?.name.text = vm.name
                self?.symbol.text = vm.symbol
                self?.priceUsd.text = vm.priceUsd.toStringWith(currency: "$")
                self?.persentChangeUsdLast24Hours.text = vm.persentChangeUsdLast24Hours.toStringWith(currency: "%")
                self?.image.load(id: vm.id)
                dispatchGroup.leave()
            }
            dispatchGroup.notify(queue: .main) { [weak self] in
                    guard let self = self else {return}
                if vm.persentChangeUsdLast24Hours < 0 {
                    self.persentChangeUsdLast24Hours.textColor = .systemRed
                } else if vm.persentChangeUsdLast24Hours > 0 {
                    self.persentChangeUsdLast24Hours.textColor = .systemGreen
                } else {
                    self.persentChangeUsdLast24Hours.textColor = .systemGray
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    // MARK: setupViews
    
    private func setupViews() {
        contentView.addSubview(name)
        contentView.addSubview(image)
        contentView.addSubview(priceUsd)
        contentView.addSubview(persentChangeUsdLast24Hours)
        contentView.addSubview(symbol)
        image.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func setupConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.top.equalTo(8)
            make.leading.equalTo(15)
            make.bottom.equalTo(-15)
        }
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(10)
            make.top.equalTo(8)
        }
        
        symbol.translatesAutoresizingMaskIntoConstraints = false
        symbol.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(10)
            make.top.equalTo(name.snp.bottom).offset(8)
        }
        
        priceUsd.translatesAutoresizingMaskIntoConstraints = false
        priceUsd.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.top.equalTo(8)
        }
        
        persentChangeUsdLast24Hours.translatesAutoresizingMaskIntoConstraints = false
        persentChangeUsdLast24Hours.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.top.equalTo(priceUsd.snp.bottom).offset(8)
        }
    }
}

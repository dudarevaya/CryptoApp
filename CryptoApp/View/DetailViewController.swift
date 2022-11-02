//
//  DetailViewController.swift
//  CryptoApp
//
//  Created by Яна Дударева on 07.10.2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    //MARK: ViewModel
    
    var viewModel: CryptoViewModelProtocol? {
        didSet {
            bindViewModel()
        }
    }
    
    //MARK: Outlets
    
    private lazy var symbol: UILabel = {
        var label = UILabel()
        return label
    }()
    
    private lazy var priceUsdLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Price:"
        return label
    }()
    
    private lazy var priceUsd: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var persentChangeUsdLast24HoursLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "24h Price Change:"
        return label
    }()
    
    private lazy var persentChangeUsdLast24Hours: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.addArrangedSubview(priceUsdLabel)
        stackView.addArrangedSubview(priceUsd)
        stackView.addArrangedSubview(persentChangeUsdLast24HoursLabel)
        stackView.addArrangedSubview(persentChangeUsdLast24Hours)
        stackView.setCustomSpacing(10, after: priceUsd)
        return stackView
    }()
    
    private lazy var image: UIImageView = {
        var image = UIImageView()
        image.backgroundColor = .systemGray4
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.frame = CGRect(x: 20, y: 20, width: 10, height: 10)
        return view
    }()
    
    //MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupViews()
        setupConstraints()
    }
    
    //MARK: Bind
    
    private func bindViewModel() {
        let dispatchGroup = DispatchGroup()
        if let vm = viewModel {
            dispatchGroup.enter()
            image.load(id: vm.id)
            DispatchQueue.main.async(group: dispatchGroup) { [weak self] in
                self?.title = vm.name
                self?.symbol.text = vm.symbol
                self?.priceUsd.text = vm.priceUsd.toStringWith(currency: "$")
                self?.persentChangeUsdLast24Hours.text = vm.persentChangeUsdLast24Hours.toStringWith(currency: "%")
                dispatchGroup.leave()
            }
            dispatchGroup.notify(queue: .main) {
                [weak self] in
                    guard let self = self else {return}
                if vm.persentChangeUsdLast24Hours < 0 {
                        self.persentChangeUsdLast24Hours.textColor = .systemRed
                } else if vm.persentChangeUsdLast24Hours > 0 {
                        self.persentChangeUsdLast24Hours.textColor = .systemGreen
                    } else {
                        self.persentChangeUsdLast24Hours.textColor = .systemGray
                    }
                    self.activityIndicator.stopAnimating()
                    self.image.backgroundColor = .white
            }
        }
    }
    
    // MARK: setupViews
    
    private func setupViews() {
        view.addSubview(stackView)
        view.addSubview(symbol)
        self.navigationController?.navigationBar.addSubview(image)
        image.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.equalTo(20)
            make.trailing.equalToSuperview()
        }
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-12)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        symbol.translatesAutoresizingMaskIntoConstraints = false
        symbol.snp.makeConstraints { make in
            make.leading.equalTo(17)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-5)
        }
    }
}

// MARK: Extensions

extension DetailViewController {
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showImage(false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showImage(true)
    }
    
    private func showImage(_ show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.image.alpha = show ? 1.0 : 0.0
        }
    }
}

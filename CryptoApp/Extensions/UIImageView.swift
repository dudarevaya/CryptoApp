//
//  UIImageView.swift
//  CryptoApp
//
//  Created by Яна Дударева on 17.10.2022.
//

import Foundation
import UIKit

extension UIImageView {
    func load(id: String) {
        let url = "https://messari.io/asset-images/\(id)/64.png"
        guard let url = URL(string: url) else {
            print("Failed to load image")
            return
        }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

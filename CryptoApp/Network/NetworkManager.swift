//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Яна Дударева on 08.10.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    var cryptoArray = [CryptoData]()
    
    private func getURL(strData: String) -> String {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "data.messari.io"
        components.path = "/api/v1/assets/" + strData + "/metrics"
        return components.url?.absoluteString ?? "ERROR"
    }
    
    func fetchData(strData: String, completion: @escaping () -> Void) {
        let url = getURL(strData: strData)
        performRequest(urlString: url) { [self] (result) in
            switch result {
            case .success(let data):
                do {
                    let cryptoData = try JSONDecoder().decode(CryptoData.self, from: data)
                    cryptoArray.append(cryptoData)
                    completion()
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
            }
        }
        
    }
    
    private func performRequest(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
        }.resume()
    }
}

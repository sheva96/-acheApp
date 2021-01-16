//
//  NetworkManager.swift
//  СacheApp
//
//  Created by Yevhen Shevchenko on 16.01.2021.
//

import Foundation


class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(completionHandler: @escaping (Company) -> ()) {
        guard let url = URL(string: "https://randomuser.me/api/?results=50") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let _ = error { return }
            
            guard let data = data else { return }
            
            do {
                let data = try JSONDecoder().decode(Company.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(data)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

class ImageManager {
    static var shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completionHandler: @escaping (Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard url == response.url else { return }
                completionHandler(data, response)
        }.resume()
    }
}

//
//  CustomeImageView.swift
//  СacheApp
//
//  Created by Yevhen Shevchenko on 16.01.2021.
//

import UIKit


class CustomeImageView: UIImageView {

    // присвоение ячейке изображение
    func fetchImage(from url: String) {
        guard let imageURL = URL(string: url) else {
            image = #imageLiteral(resourceName: "noImage")
            return
        }
        
        // Загрузка изображения из кэша, если оно есть
        if let chachedImage = getChachedImage(from: imageURL) {
            image = chachedImage
        }
        
        // Загрузка изображения из сети
        ImageManager.shared.fetchImage(from: imageURL) { (data, response) in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            // Сохранение изображения в кэш
            self.saveDataToCached(with: data, and: response)
        }
    }
    
    private func getChachedImage(from url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let chachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: chachedResponse.data)
        }
        
        return nil
    }
    
    private func saveDataToCached(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        let urlRequst = URLRequest(url: url)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequst)
    }
}

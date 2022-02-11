//
//  NetworkManager.swift
//  ImageView
//
//  Created by Mohammed Abbas on 2/11/22.
//

import Foundation

enum NetworkUrl {
    static let keyWidth = "$WIDTH$"
    static let keyHeight = "$HEIGHT$"
    static let imageURL = "https://picsum.photos/\(keyWidth)/\(keyHeight)"
}

enum NetworkError : Error {
    case badURL
    case other(Error)
}

class NetworkManager {
    
    func getData(from url: String, completion: @escaping (Result<Data, NetworkError>) -> ()) {
                
        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
    
        URLSession
            .shared
            .dataTask(with: url) { data, response, error in
                
                if let error = error {
                    completion(.failure(.other(error)))
                    return
                }
                
                if let data = data {
                    completion(.success(data))
                    return
                }
            }
            .resume()
    }
}

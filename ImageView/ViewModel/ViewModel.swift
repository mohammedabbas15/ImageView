//
//  ViewModel.swift
//  ImageView
//
//  Created by Mohammed Abbas on 2/11/22.
//

import Foundation
import Combine

class ViewModel {
    
    @Published private(set) var data = Data()
    
    private let networkManager = NetworkManager()
    
    func loadImage(width: Int, height: Int) {
        let url = NetworkUrl.imageURL
            .replacingOccurrences(of: NetworkUrl.keyWidth, with: "\(width)")
            .replacingOccurrences(of: NetworkUrl.keyHeight, with: "\(height)")
        
        networkManager.getData(from: url) { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

//
//  Service.swift
//  NewsFeedApp
//
//  Created by mehtab alam on 03/02/2021.
//
import Foundation
import UIKit
class Service {
    
    func getRequest<T: Decodable>(url: String, decodingType: T.Type, _ completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let jsonData = try JSONDecoder().decode(decodingType, from: data)
                    completion(.success(jsonData))
                } catch let error {
                    completion(.failure(error))
                    print(completion(.failure(error)))
                }
            }
        }
        dataTask.resume()
    }
}

//
//  ApiClient.swift
//  Upstox
//
//  Created by MacBook on 15/11/24.
//

import Foundation

protocol ApiClientProtocol {
    // Fetch method for GET requests
    /// URLSESSION for Server Handling
    /// - Parameters:
    ///   - completionHandler:generic method to give succes, failure from server when we call
  func fetchGetRequest<T: Decodable>(endpoint:  URL, completionHandler: @escaping (Result<T,NetworkErrors>) -> Void)
}

final class ApiClient: ApiClientProtocol {
    
    func fetchGetRequest<T: Decodable>(endpoint:  URL, completionHandler: @escaping (Result<T,NetworkErrors>) -> Void){
        let request = RequestBuilder.buildRequest(for: endpoint)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let _ = error {
                completionHandler(.failure(.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let errorMessage = String(data: data ?? Data(), encoding: .utf8) ?? "Unknown error"
                completionHandler(.failure(.serverError(errorMessage)))
                return
            }
            
            guard let dataTask = data  else {
                completionHandler(.failure(.decodingFailed))
                return
            }
            
            do {
                let task = try JSONDecoder().decode(T.self, from: dataTask)
                completionHandler(.success(task))
                
            }catch{
                completionHandler(.failure(.decodingFailed))
            }
            
        }.resume()
    }
}

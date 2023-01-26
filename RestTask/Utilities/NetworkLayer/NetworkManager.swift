//
//  NetworkManager.swift
//  RestTask
//
//  Created by John Doe on 2023-01-25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    func getResults<M: Codable>(APICase: API,decodingModel: M.Type, completed: @escaping (Result<M,ErorrMessage> ) -> Void) {
        
        let request : URLRequest = APICase.request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error =  error {
                completed((.failure(.InvalidData)))
            }
            guard let data = data else {
                completed((.failure(.InvalidData)))
                return
            }
            guard let response =  response  as? HTTPURLResponse ,response.statusCode == 200 else{
                completed((.failure(.InvalidResponse)))
                return
            }
            let decoder = JSONDecoder()
            do
            {
                //                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let results = try decoder.decode(M.self, from: data)
                print(results)
                completed((.success(results)))
                
            }catch {
                print(error)
                completed((.failure(.InvalidData)))
            }
            
        }
        task.resume()
    }
}

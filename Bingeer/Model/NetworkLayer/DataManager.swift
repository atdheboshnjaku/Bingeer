//
//  DataManager.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 4/26/23.
//

import Foundation
import Alamofire

struct DataManager {
     
    func fetchData<T: Decodable>(for endpoint: String, forNestedEndpointKey: String = "results", isFirstQuery: Bool = true, completionHandler: @escaping(_ data: [T], _ error: Error?) -> Void) {

            guard let url = API.shared.url(for: endpoint, isFirstQuery: isFirstQuery) else {
                return
            }

            AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
     
                guard let json = response.value as? [String: Any] else { return }

                var results: [[String: Any]] = []
                if forNestedEndpointKey == "" {
                    results.append(json)
                } else if let nestedResults = json[forNestedEndpointKey] as? [[String: Any]] {
                    results = nestedResults
                }

                do {
                    let data = try JSONSerialization.data(withJSONObject: results)
                    let decoder = JSONDecoder()
                    let objectData = try decoder.decode([T].self, from: data)
                    completionHandler(objectData, nil)
                } catch {
                    completionHandler([], error)
                    print("Error fetching \(endpoint): \(error)")
                }

            }

        }

    
// best working version so far
//    func fetchData<T: Decodable>(for endpoint: String, forNestedEndpointKey: String = "results", isFirstQuery: Bool = true, completionHandler: @escaping(_ data: [T], _ error: Error?) -> Void) {
//
//        guard let url = API.shared.url(for: endpoint, isFirstQuery: isFirstQuery) else {
//            return
//        }
//
//        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
//
//            guard let json = response.value as? [String: Any] else { return }
//            guard let results = json[forNestedEndpointKey] as? [[String: Any]] else { return }
//
//            do {
//                let data = try JSONSerialization.data(withJSONObject: results)
//                let decoder = JSONDecoder()
//                let objectData = try decoder.decode([T].self, from: data)
//                completionHandler(objectData, nil)
//            } catch {
//                completionHandler([], error)
//                print("Error fetching \(endpoint): \(error)")
//            }
//
//        }
//
//    }

    
//    func fetchData<T: Decodable>(for endpoint: String, isFirstQuery: Bool = true, completionHandler: @escaping(_ data: [T], _ error: Error?) -> Void) {
//
//        guard let url = API.shared.url(for: endpoint, isFirstQuery: isFirstQuery) else {
//            return
//        }
//
//        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
//
//            guard let json = response.value as? [String: Any] else { return }
//            guard let results = json["results"] as? [[String: Any]] else { return }
//
//            do {
//                let data = try JSONSerialization.data(withJSONObject: results)
//                let decoder = JSONDecoder()
//                let objectData = try decoder.decode([T].self, from: data)
//                completionHandler(objectData, nil)
//            } catch {
//                completionHandler([], error)
//                print("Error fetching \(endpoint): \(error)")
//            }
//
//        }
//
//    }

    
}

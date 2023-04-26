//
//  DataManager.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 4/26/23.
//

import Foundation
import Alamofire

struct DataManager {
        
    func fetchData<T: Decodable>(for endpoint: String, completionHandler: @escaping(_ data: [T], _ error: Error?) -> Void) {

        guard let url = API.shared.url(for: endpoint) else {
            return
        }

        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in

            guard let value = response.value else {
                completionHandler([], response.error)
                return
            }

            guard let json = value as? [String: Any], let results = json["results"] as? [[String: Any]] else {
                completionHandler([], nil)
                return
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

    
}

//    func fetchTvShows(for endpoint: String, completionHandler: @escaping(_ shows: [Show], _ error: Error?) -> Void) {
//
//        guard let url = API.shared.url(for: endpoint) else {
//            return
//        }
//
//        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
//
//            guard let value = response.value else {
//                completionHandler([], response.error)
//                return
//            }
//
//            guard let json = value as? [String: Any], let results = json["results"] as? [[String: Any]] else {
//                completionHandler([], nil)
//                return
//            }
//
//            do {
//                let data = try JSONSerialization.data(withJSONObject: results)
//                let decoder = JSONDecoder()
//                let showData = try decoder.decode([Show].self, from: data)
//                completionHandler(showData, nil)
//            } catch {
//                completionHandler([], error)
//                print("Error fetching \(endpoint): \(error)")
//            }
//
//        }
//
//    }
//
//    func fetchMovies(for endpoint: String, completionHandler: @escaping(_ movies: [Movie], _ error: Error?) -> Void) {
//
//        guard let url = API.shared.url(for: endpoint) else {
//            return
//        }
//
//        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
//
//            guard let value = response.value else {
//                completionHandler([], response.error)
//                return
//            }
//
//            guard let json = value as? [String: Any], let results = json["results"] as? [[String: Any]] else {
//                completionHandler([], nil)
//                return
//            }
//
//            do {
//                let data = try JSONSerialization.data(withJSONObject: results)
//                let decoder = JSONDecoder()
//                let movieData = try decoder.decode([Movie].self, from: data)
//                completionHandler(movieData, nil)
//            } catch {
//                completionHandler([], error)
//                print("Error fetching \(endpoint): \(error)")
//            }
//
//        }
//
//    }

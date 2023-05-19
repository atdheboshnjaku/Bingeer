//
//  Api.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 4/25/23.
//

import Foundation

struct API {
    
    static let shared = API()
    
    private let baseUrl = "https://api.themoviedb.org/3"
    private let apiKey = Env.shared.value(for: "API_KEY")
    private let originalLanguage: String = "with_original_language=en"
    
    func url(for endpoint: String, isFirstQuery: Bool) -> URL? {
        
        guard let apiKey = apiKey else {
            print("Error: API key is missing")
            return nil
        }
        
        let queryParameter = isFirstQuery ? "?" : "&"
        let urlString = "\(baseUrl)\(endpoint)\(queryParameter)api_key=\(apiKey)&\(originalLanguage)"
        
        return URL(string: urlString)
        
    }
    
}

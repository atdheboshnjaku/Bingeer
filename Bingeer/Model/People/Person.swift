//
//  Person.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 5/2/23.
//

import Foundation

struct Person: Codable, ComparableDate {
    
    var id: Int
    var name: String?
    var profile_path: String?
    var biography: String?
    var birthday: String?
    var place_of_birth: String?
    
    var title: String?
    var overview: String?
    var poster_path: String?
    var release_date: String?
    var first_air_date: String?
    var character: String?
    var media_type: String?
    var episode_count: Int?
    var job: String?
  
    var releaseDate: Date? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let releaseDate = formatter.date(from: release_date ?? "") {
            return releaseDate
        } else if let releaseDate = formatter.date(from: first_air_date ?? "") {
            return releaseDate
        } else {
            return nil
        }
        
    }
//    var releaseDate: Date? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        return formatter.date(from: release_date ?? "")
//    }
    
}

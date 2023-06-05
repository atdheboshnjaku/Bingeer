//
//  Movie.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 4/25/23.
//

import Foundation
import RealmSwift

struct Movie: Codable {
    
    var release_date: String?
    var id: Int
    var title: String
    var overview: String?
    var vote_average: Double?
    var poster_path: String?
    var backdrop_path: String?
    
}

class MovieNotificationObject: Object {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var release_date: String
    
}

//
//  Movie.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 4/25/23.
//

import Foundation

struct Movie: Codable {
    
    var release_date: String?
    var id: Int
    var title: String
    var overview: String?
    var vote_average: Double?
    var poster_path: String?
    var backdrop_path: String?
    
}

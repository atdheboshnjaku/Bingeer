//
//  K.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 4/27/23.
//
import Foundation

struct K {
    
    static let appName = "Bingeer"
    
    static let coverURL = "https://www.themoviedb.org/t/p/w300_and_h450_bestv2"
    static let posterURL = "https://www.themoviedb.org/t/p/w1920_and_h800_multi_faces"
        
    struct TVShowEndpoint {
        
        // First query true
        static let trendingTVShowsWeekly = "/trending/tv/week"
        static let trendingTVShowsDaily = "/trending/tv/day"
        static let popularTVShows = "/tv/popular"
        static let topRatedTVShows = "/tv/top_rated"
        
        // First query false
        
    }
    
    struct MovieEndpoint {
        
        // First query true
        static let trendingMoviesWeekly = "/trending/movie/week"
        static let trendingMoviesDaily = "/trending/movie/day"
        static let inCinemaMovies = "/movie/now_playing"
        static let topRatedMovies = "/movie/top_rated"
        
        // First query false
        static var upcomingMovies: String {
            return "/discover/movie" + getDateParams()
        }
        
        
    }
    
    struct PeopleEndpoint {
        
        static let smallPeopleImageURL = "https://www.themoviedb.org/t/p/w235_and_h235_face"
        static let largePeopleImageURL = "https://www.themoviedb.org/t/p/original"
        
        // First query true
        static let popularPeople = "/person/popular"
        static let trendingPeopleWeekly = "/trending/person/week"
        static let trendingPeopleDaily = "/trending/person/day"
        static let fetchPersonByID = "/person/"
        // First query false
        
    }
    
    static func getDateParams() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let calendar = Calendar.current
        var components = DateComponents()
        components.day = 1
        let tomorrow = calendar.date(byAdding: components, to: Date())!
        let threeWeeksLater = calendar.date(byAdding: .day, value: 21, to: tomorrow)!
        let startDateString = dateFormatter.string(from: tomorrow)
        let endDateString = dateFormatter.string(from: threeWeeksLater)
        return "?primary_release_date.gte=\(startDateString)&primary_release_date.lte=\(endDateString)"
        
    }
    
}

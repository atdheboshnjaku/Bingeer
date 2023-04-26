//
//  ViewController.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 4/24/23.
//

import UIKit


class ViewController: UIViewController {
    
    var dataManager = DataManager()
    var popularShowsArray: [Show] = []
    var popularMoviesArray: [Movie] = []
    var topMoviesArray: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //fetchPopShows()
        //fetchPopMovies()
        fetchTopMovies()
        //fetchTopTVShows()
    }
    
    func fetchPopShows() {
        
        dataManager.fetchData(for: "/tv/popular") { (shows: [Show], error: Error?) in
            if let error = error {
                print("Error getting popular tv shows: \(error)")
                return
            }

            self.popularShowsArray = shows
            print(self.popularShowsArray)
        }
        
    }
    
    func fetchTopTVShows() {
        
        dataManager.fetchData(for: "/tv/top_rated") { (data: [Show], error: Error?) in
            
            if let error = error {
                print("Error getting popular tv shows: \(error)")
                return
            }
            
            self.popularShowsArray = data
            print(self.popularShowsArray)
        }
        
    }
    
    func fetchPopMovies() {
        
        dataManager.fetchData(for: "/movie/popular") { (movies: [Movie], error: Error?) in
            
            if let error = error {
                print("Error getting popular movies: \(error)")
                return
            }

            self.popularMoviesArray = movies
            print(self.popularMoviesArray)
            
        }
        
    }
    
    func fetchTopMovies() {
        
        dataManager.fetchData(for: "/movie/top_rated") { (data: [Movie], error: Error?) in
            
            if let error = error {
                print("Error getting popular movies: \(error)")
                return
            }
            
            self.popularMoviesArray = data
            print(self.popularMoviesArray)
            
        }
        
    }

//    func fetchPopShows() {
//
//        dataManager.fetchTvShows(for: "/tv/popular") { shows, error in
//
//            if let error = error {
//                print("Error getting popular tv shows: \(error.localizedDescription)")
//                return
//            }
//
//            self.popularShowsArray = shows
//            print(self.popularShowsArray)
//
//        }
//
//    }
//
//    func fetchPopMovies() {
//
//        dataManager.fetchMovies(for: "/movie/popular") { movies, error in
//
//            if let error = error {
//                print("Error getting popular movies: \(error.localizedDescription)")
//                return
//            }
//
//            self.popularMoviesArray = movies
//            print(self.popularMoviesArray)
//
//        }
//
//    }

}


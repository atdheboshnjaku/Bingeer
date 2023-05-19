//
//  HomeViewController.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 4/24/23.
//

import UIKit
import Kingfisher

protocol ComparableDate {
    var releaseDate: Date? { get }
}

class HomeViewController: UIViewController {
    
    // Top trending show
    @IBOutlet weak var topTrendingShowContainer: UIView!
    @IBOutlet weak var topTrendingShowPosterImage: UIImageView!
    @IBOutlet weak var topTrendingShowNameLabel: UILabel!
    @IBOutlet weak var topTrendingShowAverageVoteButton: UIButton!
    
    // Top trending movie
    @IBOutlet weak var topTrendingMovieContainer: UIView!
    @IBOutlet weak var topTrendingMoviePosterImage: UIImageView!
    @IBOutlet weak var topTrendingMovieNameLabel: UILabel!
    @IBOutlet weak var topTrendingMovieAverageVoteButton: UIButton!
    
    @IBOutlet weak var topTrendingTvShowsCollection: UICollectionView!
    @IBOutlet weak var topTrendingMoviesCollection: UICollectionView!
    
    
    
    var dataManager = DataManager()
    
    var weeklyTrendingTVShows: [Show] = []
    var weeklyTrendingMovies: [Movie] = []
    
    var personArray: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
        fetchWeeklyTrendingTVShows()
        fetchWeeklyTrendingMovies()
        topTrendingShowPosterImage.addoverlay()
        topTrendingMoviePosterImage.addoverlay()
        
    }
    
    func fetchWeeklyTrendingTVShows() {
        
        dataManager.fetchData(for: K.TVShowEndpoint.trendingTVShowsWeekly) { (data: [Show], error) in

            if let error = error {
                print("\(error.localizedDescription)\n\(error)")
                return
            }

            self.weeklyTrendingTVShows = data
            //dump(self.weeklyTrendingTVShows)
            self.setTopTrendingShowDetails()
            self.topTrendingTvShowsCollection.reloadData()

        }
        
    }
    
    func fetchWeeklyTrendingMovies() {
        
        dataManager.fetchData(for: K.MovieEndpoint.trendingMoviesWeekly) { (data: [Movie], error: Error?) in
            if let error = error {
                print("\(error.localizedDescription)\n\(error)")
                return
            }
            
            self.weeklyTrendingMovies = data
            dump(self.weeklyTrendingMovies)
            self.setTopTrendingShowDetails()
            self.topTrendingMoviesCollection.reloadData()
            
        }
        
    }
    
    func setTopTrendingShowDetails() {
        
        topTrendingShowContainer.layer.cornerRadius = 10
        topTrendingShowPosterImage.layer.cornerRadius = 10
        topTrendingShowPosterImage.kf.setImage(with: URL(string: K.posterURL + (weeklyTrendingTVShows.first?.backdrop_path ?? "")), placeholder: UIImage(named: "bingeer-icon"))
        topTrendingShowNameLabel.text = weeklyTrendingTVShows.first?.name

        if let averageVote = weeklyTrendingTVShows.first?.vote_average {
            topTrendingShowAverageVoteButton.setTitle(" \(String(format: "%.1f", averageVote))", for: .normal)
        }
        
        topTrendingMovieContainer.layer.cornerRadius = 10
        topTrendingMoviePosterImage.layer.cornerRadius = 10
        topTrendingMoviePosterImage.kf.setImage(with: URL(string: K.posterURL + (weeklyTrendingMovies.first?.backdrop_path ?? "")), placeholder: UIImage(named: "bingeer-icon"))
        topTrendingMovieNameLabel.text = weeklyTrendingMovies.first?.title

        if let averageVote = weeklyTrendingMovies.first?.vote_average {
            topTrendingMovieAverageVoteButton.setTitle(" \(String(format: "%.1f", averageVote))", for: .normal)
        }
        
    }

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
    func setup() {

        topTrendingTvShowsCollection.dataSource = self
        topTrendingTvShowsCollection.delegate = self
        topTrendingTvShowsCollection.register(UINib(nibName: "CombinedCell", bundle: nil), forCellWithReuseIdentifier: "CombinedCell")
        
        topTrendingMoviesCollection.dataSource = self
        topTrendingMoviesCollection.delegate = self
        topTrendingMoviesCollection.register(UINib(nibName: "CombinedCell", bundle: nil), forCellWithReuseIdentifier: "CombinedCell")
        
        topTrendingTvShowsCollection.layer.cornerRadius = 10
        topTrendingMoviesCollection.layer.cornerRadius = 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == topTrendingTvShowsCollection {
            return weeklyTrendingTVShows.count - 1
        } else {
            return weeklyTrendingMovies.count - 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CombinedCell", for: indexPath) as! CombinedCell
        cell.layer.cornerRadius = 10
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.05
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.shadowRadius = 5.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.layer.cornerRadius).cgPath
        
        if collectionView == topTrendingTvShowsCollection {
            
            cell.setDetails(item: weeklyTrendingTVShows[indexPath.item + 1])
            return cell
            
        } else {
            
            cell.setDetails(item: weeklyTrendingMovies[indexPath.item + 1])
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - 20) / 2
        return CGSize(width: width * 0.90, height: 310)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension ComparableDate {
    var releaseDate: Date? { return nil }
}




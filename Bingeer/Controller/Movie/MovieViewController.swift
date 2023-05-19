//
//  MovieViewController.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 5/20/23.
//

import UIKit
import BouncyLayout

class MovieViewController: UIViewController {
    
    @IBOutlet weak var movieSegmentController: UISegmentedControl!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var dataManager = DataManager()
    
    var inCinemaMoviesArray: [Movie] = []
    var upcomingMoviesArray: [Movie] = []
    var topRatedMoviesArray: [Movie] = []
    
    var selectedSegmentIndexAt: Int {
        movieSegmentController.selectedSegmentIndex
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDesign()
        setup()
        fetchMovies()
        
    }
    
    func setupDesign() {
        
        let futuraFont = UIFont(name: "Futura", size: 12) ?? UIFont.systemFont(ofSize: 12)
        let textAttributes = [NSAttributedString.Key.font: futuraFont]

        movieSegmentController.setTitleTextAttributes(textAttributes, for: .normal)
        movieSegmentController.setTitleTextAttributes(textAttributes, for: .selected)
        
        movieSegmentController.applyWhiteBackgroundColor()
        
    }
    
    func fetchMovies() {
        
        dataManager.fetchData(for: K.MovieEndpoint.inCinemaMovies) { (data: [Movie], error) in
            
            if let error = error {
                print(error)
                return
            }
            
            self.inCinemaMoviesArray = data
            self.movieCollectionView.reloadData()
            
        }
        
        dataManager.fetchData(for: K.MovieEndpoint.upcomingMovies, isFirstQuery: false) { (data: [Movie], error) in
            
            if let error = error {
                print(error)
                return
            }
            
            self.upcomingMoviesArray = data
            self.movieCollectionView.reloadData()
            
        }
        
        dataManager.fetchData(for: K.MovieEndpoint.topRatedMovies) { (data: [Movie], error) in
            
            if let error = error {
                print(error)
                return
            }
            
            self.topRatedMoviesArray = data
            self.movieCollectionView.reloadData()
            
        }
        
        
    }
    
    @IBAction func movieSegmentedControlButtonPressed(_ sender: UISegmentedControl) {
        
        self.movieCollectionView.reloadData()
        
    }
    

}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setup() {
        
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        movieCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch selectedSegmentIndexAt {
            
            case 0:
                return inCinemaMoviesArray.count
            case 1:
                return upcomingMoviesArray.count
            case 2:
                return topRatedMoviesArray.count
            default:
                return inCinemaMoviesArray.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.layer.cornerRadius = 10
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.05
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.shadowRadius = 5.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.layer.cornerRadius).cgPath
        
        switch selectedSegmentIndexAt {
            
            case 0:
                cell.setDetails(movie: inCinemaMoviesArray[indexPath.item])
            case 1:
                cell.setDetails(movie: upcomingMoviesArray[indexPath.item])
            case 2:
                cell.setDetails(movie: topRatedMoviesArray[indexPath.item])
            default:
                cell.setDetails(movie: inCinemaMoviesArray[indexPath.item])
            
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
}

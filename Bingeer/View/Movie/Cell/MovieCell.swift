//
//  MovieCell.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 5/19/23.
//

import UIKit
import RealmSwift

protocol MovieNotificationDelegate {
    func addToBingeerList(movie: Movie)
}

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var averageVoteButton: UIButton!
    @IBOutlet weak var addToBingeerListButton: UIButton!
    
    var delegate: MovieNotificationDelegate?
    var movie: Movie?
    let realm = try! Realm()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDetails(movie: Movie) {
        
        self.movie = movie
        coverImageView.kf.setImage(with: URL(string: K.coverURL + (movie.poster_path ?? "")), placeholder: UIImage(named: "bingeer-icon"))
        nameLabel.text = movie.title
        
        let dateString = movie.release_date
        if let dateString = dateString {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            
            dateFormatter.dateFormat = "dd MMMM yyyy"
            let formattedDate = dateFormatter.string(from: date ?? Date())
            
            releaseDateLabel.text = formattedDate
            
            let currentDate = Date()
            
            if let releaseDate = date, releaseDate > currentDate {
                // Movie has not been released yet
                addToBingeerListButton.isHidden = false
            } else {
                // Movie has been released
                addToBingeerListButton.isHidden = true
            }
            
        }
         
        if let averageVote = movie.vote_average {
            
            if averageVote == 0.0 {
                averageVoteButton.isHidden = true
            } else {
                averageVoteButton.setTitle(" \(String(format: "%.1f", averageVote))", for: .normal)
            }
            
        }
        
        movieOverview.text = movie.overview
        addToBingeerListButton.setTitle("", for: .normal)
        
        let mov = realm.object(ofType: MovieNotificationObject.self, forPrimaryKey: movie.id)
        if (mov != nil) {
            addToBingeerListButton.setImage(UIImage(systemName: "plus.app.fill"), for: .normal)
        } else {
            addToBingeerListButton.setImage(UIImage(systemName: "plus.app"), for: .normal)
        }
        
        coverImageView.layer.cornerRadius = 10
        coverImageView.clipsToBounds = true
        
    }
    
    
    @IBAction func addToBingeerListPressed(_ sender: UIButton) {
        
        if let movie = movie {
            delegate?.addToBingeerList(movie: movie)
        }
        
    }
    

}

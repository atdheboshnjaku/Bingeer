//
//  MovieCell.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 5/19/23.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var averageVoteButton: UIButton!
    @IBOutlet weak var addToBingeerListButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDetails(movie: Movie) {
        
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
            
        }
        //releaseDateLabel.text = movie.release_date
        if let averageVote = movie.vote_average {
            
            if averageVote == 0.0 {
                averageVoteButton.isHidden = true
                //averageVoteButton.setTitle("", for: .normal)
            } else {
                averageVoteButton.setTitle(" \(String(format: "%.1f", averageVote))", for: .normal)
            }
            
        }
        
        movieOverview.text = movie.overview
        addToBingeerListButton.setTitle("", for: .normal)
        coverImageView.layer.cornerRadius = 10
        coverImageView.clipsToBounds = true
        
    }

}

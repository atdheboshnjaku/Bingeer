//
//  CombinedCell.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 5/16/23.
//

import UIKit
import Kingfisher

class CombinedCell: UICollectionViewCell {
    
    // 
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var averageVoteButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addToBingeerListButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    
    func setDetails<T>(item: T) {
        
        if let show = item as? Show {
            
            coverImageView.kf.setImage(with: URL(string: K.coverURL + (show.poster_path ?? "")), placeholder: UIImage(named: "bingeer-icon"))
            if let averageVote = show.vote_average {
                averageVoteButton.setTitle(" \(String(format: "%.1f", averageVote))", for: .normal)
            }
            
            nameLabel.text = show.name
            
        } else if let movie = item as? Movie {
            
            coverImageView.kf.setImage(with: URL(string: K.coverURL + (movie.poster_path ?? "")), placeholder: UIImage(named: "bingeer-icon"))
            if let averageVote = movie.vote_average {
                averageVoteButton.setTitle(" \(String(format: "%.1f", averageVote))", for: .normal)
            }
            
            nameLabel.text = movie.title
            
        }
        
        addToBingeerListButton.setTitle("", for: .normal)
        coverImageView.layer.cornerRadius = 10
        coverImageView.clipsToBounds = true
        
    }



    
//    func setDetails(show: Show) {
//
//        coverImageView.kf.setImage(with: URL(string: K.coverURL + (show.poster_path ?? "")), placeholder: UIImage(named: "bingeer-icon"))
//        if let averageVote = show.vote_average {
//            averageVoteButton.setTitle("\(String(format: "%.1f", averageVote))", for: .normal)
//
//        }
//        nameLabel.text = show.name
//        addToBingeerListButton.setTitle("", for: .normal)
//        coverImageView.layer.cornerRadius = 10
//        coverImageView.clipsToBounds = true
//
//    }

}

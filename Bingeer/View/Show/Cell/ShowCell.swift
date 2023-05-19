//
//  ShowCell.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 5/19/23.
//

import UIKit
import Kingfisher

class ShowCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var addToBingeerListButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var averageVoteButton: UIButton!
    @IBOutlet weak var showOverviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        coverImageView.addoverlay(alpha: 0.3)
    }
    
    func setDetails(show: Show) {
        
        coverImageView.kf.setImage(with: URL(string: K.posterURL + (show.backdrop_path ?? "")), placeholder: UIImage(named: "bingeer-icon"))
        nameLabel.text = show.name
        if let averageVote = show.vote_average {
            averageVoteButton.setTitle(" \(String(format: "%.1f", averageVote))", for: .normal)
        }
        
        showOverviewLabel.text = show.overview
        addToBingeerListButton.setTitle("", for: .normal)
        coverImageView.layer.cornerRadius = 10
        coverImageView.clipsToBounds = true
        
        
    }

}

//
//  ActorCreditsCell.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 5/11/23.
//

import UIKit
import Kingfisher

class ActorCreditsCell: UITableViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var creditsNameLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDetails(person: Person) {
        
        coverImageView.kf.setImage(with: URL(string: K.coverURL + (person.poster_path ?? "")), placeholder: UIImage(named: "bingeer-icon"))
        
        if person.media_type == "movie" {
            creditsNameLabel.text = person.title
            if let year = person.release_date {
                releaseYearLabel.text = String(year.prefix(4))
            } else {
                releaseYearLabel.text = "-"
            }
        } else {
            creditsNameLabel.text = person.name
            if let year = person.first_air_date {
                releaseYearLabel.text = String(year.prefix(4))
            } else {
                releaseYearLabel.text = "-"
            }
        }
        
        if person.character != "" {
            characterNameLabel.text = person.character
        } else {
            characterNameLabel.text = ""
        }
        
        
    }
    
}

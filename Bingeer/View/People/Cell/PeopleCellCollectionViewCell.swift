//
//  PeopleCellCollectionViewCell.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 5/2/23.
//

import UIKit
import Kingfisher

class PeopleCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    func setDetails(person: Person) {
        
        personImageView.kf.setImage(with: URL(string: K.PeopleEndpoint.smallPeopleImageURL + (person.profile_path ?? "")), placeholder: UIImage(named: "bingeer-icon"))
        personNameLabel.text = person.name ?? ""
        
    }
    
    func setup() {
        
        personImageView.layer.cornerRadius = 10
        personImageView.clipsToBounds = true
        
    }

}

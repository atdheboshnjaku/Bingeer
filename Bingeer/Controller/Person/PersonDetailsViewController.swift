//
//  PersonDetailsViewController.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 5/7/23.
//

import UIKit
import Kingfisher

class PersonDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var topSpacerView: UIView!
    @IBOutlet weak var bioContainerView: UIView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var actorTableView: UITableView!
    @IBOutlet weak var actorCreditsTableView: UITableView!
    
    @IBOutlet weak var biographyHeadingLabel: PaddingLabel!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personBiographyLabel: UILabel!
    @IBOutlet weak var toggleBiographyButton: UIButton!
    
    var person: Person?
    var dataManager = DataManager()
    
    var personDataArray: [Person] = []
    var personCastCreditsArray: [Person] = []
    var personCrewCreditsArray: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        positionSpacerView()
        setDetails()
        setupTable()

    }
    
    func positionSpacerView() {

        let screenSize = UIScreen.main.bounds.size
        let newHeight = screenSize.height * 2 / 3
        
        topSpacerView.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
        
        toggleBiographyButton.titleLabel?.font = UIFont(name: "Futura-Bold", size: 14.0)
        toggleBiographyButton.layer.cornerRadius = 10.0
        toggleBiographyButton.clipsToBounds = true
        
    }
    
    func setDetails() {
        
        profileImageView.clipsToBounds = true
        profileImageView.kf.setImage(with: URL(string: K.PeopleEndpoint.largePeopleImageURL + (person?.profile_path ?? "")))
        profileImageView.addoverlay()
        
        personNameLabel.text = person?.name
        bioContainerView.layer.cornerRadius = 20
        bioContainerView.layer.masksToBounds = true
        bioContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        if let personID = person?.id {

            dataManager.fetchData(for: K.PeopleEndpoint.fetchPersonByID + "\(personID)", forNestedEndpointKey: "") { (data: [Person], error) in

                if let error = error {
                    print(error)
                    return
                }

                self.personDataArray = data
                let personData = self.personDataArray[0]


                self.personBiographyLabel.text = personData.biography
                //self.personBiographyLabel.layoutIfNeeded()
               
            }
            
            dataManager.fetchData(for: K.PeopleEndpoint.fetchPersonByID + "\(personID)/combined_credits", forNestedEndpointKey: "cast") { (data: [Person], error) in
                
                if let error = error {
                    print(error)
                    return
                }
                
                let sortedData = self.sortByReleaseDate(data)
                self.personCastCreditsArray = sortedData
                //dump(self.personCastCreditsArray)
                self.actorTableView.reloadData()
                
            }
            
            dataManager.fetchData(for: K.PeopleEndpoint.fetchPersonByID + "\(personID)/combined_credits", forNestedEndpointKey: "crew") { (data: [Person], error) in
                
                if let error = error {
                    print(error)
                    return
                }
                
                let sortedData = self.sortByReleaseDate(data)
                self.personCrewCreditsArray = sortedData
                //dump(self.personCrewCreditsArray)
                self.actorCreditsTableView.reloadData()
                
            }

        }
        
    }
    
    func sortByReleaseDate<T: ComparableDate>(_ array: [T]) -> [T] {
        
        let itemsWithDate = array.filter { $0.releaseDate != nil }
        let itemsWithoutDate = array.filter { $0.releaseDate == nil }
        
        let sortedWithDate = itemsWithDate.sorted { $0.releaseDate! > $1.releaseDate! }
        
        return itemsWithoutDate + sortedWithDate
        
    }
    
    @IBAction func toggleBiographyButtonPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            
            guard let self = self else { return }
            
            if self.personBiographyLabel.numberOfLines == 3 {
                self.personBiographyLabel.numberOfLines = 0
                print(sender)
                sender.setTitle("View Less", for: .normal)
            } else {
                self.personBiographyLabel.numberOfLines = 3
                sender.setTitle("View More", for: .normal)
            }
            
            self.personBiographyLabel.sizeToFit()
            self.view.layoutIfNeeded()
            
        }
        
    }
    


}

extension PersonDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTable() {
        
        actorTableView.dataSource = self
        actorTableView.delegate = self
        actorTableView.register(UINib(nibName: "ActorCreditsCell", bundle: nil), forCellReuseIdentifier: "ActorCreditsCell")
        
        actorCreditsTableView.dataSource = self
        actorCreditsTableView.delegate = self
        actorCreditsTableView.register(UINib(nibName: "ActorCreditsCell", bundle: nil), forCellReuseIdentifier: "ActorCreditsCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView == actorTableView {
            return personCastCreditsArray.count
        } else {
            return personCrewCreditsArray.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == actorTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActorCreditsCell", for: indexPath) as! ActorCreditsCell
            cell.setDetails(person: personCastCreditsArray[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActorCreditsCell", for: indexPath) as! ActorCreditsCell
            cell.setDetails(person: personCrewCreditsArray[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension UIView {
    
    func addoverlay(color: UIColor = .black, alpha : CGFloat = 0.5) {
    
        let overlay = UIView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.frame = bounds
        overlay.backgroundColor = color
        overlay.alpha = alpha
        addSubview(overlay)
    
    }
    
}






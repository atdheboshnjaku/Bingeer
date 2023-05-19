//
//  PersonViewController.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 5/2/23.
//

import UIKit
import BouncyLayout

class PersonViewController: UIViewController {
    
    var dataManager = DataManager()
    
    var peopleArray: [Person] = []
    
    @IBOutlet weak var personCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        fetchWeeklyTrendingPeople()

    }
    
    func fetchWeeklyTrendingPeople() {
        
        dataManager.fetchData(for: K.PeopleEndpoint.trendingPeopleWeekly) { (data: [Person], error) in
            
            if let error = error {
                print(error)
                return
            }
            
            self.peopleArray = data
            self.personCollectionView.reloadData()
            //dump(self.peopleArray)
            
        }
        
    }

}

extension PersonViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setup() {
        
        let layout = BouncyLayout()
        personCollectionView.setCollectionViewLayout(layout, animated: false)
        personCollectionView.dataSource = self
        personCollectionView.delegate = self
        personCollectionView.register(UINib(nibName: "PeopleCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PeopleCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return peopleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleCell", for: indexPath) as! PeopleCellCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.05
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.shadowRadius = 5.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.layer.cornerRadius).cgPath
        
        cell.setDetails(person: peopleArray[indexPath.item])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == personCollectionView {
            let width = (collectionView.frame.width - 20) / 2
            return CGSize(width: width, height: 220)
        } else {
            return CGSize(width: 150, height: 220)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == personCollectionView {
            
            let person = peopleArray[indexPath.item]
            
            if let PersonDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "PersonDetailsViewController") as? PersonDetailsViewController {

                PersonDetailsViewController.person = person
//                self.navigationController?.pushViewController(PersonDetailsViewController, animated: true)
                present(PersonDetailsViewController, animated: true)

            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

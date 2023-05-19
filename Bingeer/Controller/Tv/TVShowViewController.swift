//
//  TVShowViewController.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 5/17/23.
//

import UIKit
import BouncyLayout

class TVShowViewController: UIViewController {
    
    @IBOutlet weak var tvShowSegmentedController: UISegmentedControl!
    @IBOutlet weak var selectedSegmentContainer: UIView!
    @IBOutlet weak var tvShowCollectionView: UICollectionView!
    
    var dataManager = DataManager()
    
    var dailyTrendingTVShowsArray: [Show] = []
    var popularTVShowsArray: [Show] = []
    var topRatedTVShowsArray: [Show] = []
    
    var selectedSegmentIndexAt: Int {
        tvShowSegmentedController.selectedSegmentIndex
    }
    
    let selectedSegmentBar = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDesign()
        setup()
        fetchTVShows()
        
    }
    
    func setupDesign() {
        
        let futuraFont = UIFont(name: "Futura", size: 12) ?? UIFont.systemFont(ofSize: 12)
        let textAttributes = [NSAttributedString.Key.font: futuraFont]

        tvShowSegmentedController.setTitleTextAttributes(textAttributes, for: .normal)
        tvShowSegmentedController.setTitleTextAttributes(textAttributes, for: .selected)
        //createSelectedSegmentNavigatorBar()
        
        tvShowSegmentedController.applyWhiteBackgroundColor()
        
    }
    
    func fetchTVShows() {
        
        dataManager.fetchData(for: K.TVShowEndpoint.trendingTVShowsDaily) { (data: [Show], error) in
            
            if let error = error {
                print(error)
                return
            }
            
            self.dailyTrendingTVShowsArray = data
            dump(self.dailyTrendingTVShowsArray)
            self.tvShowCollectionView.reloadData()
            
        }
        
        dataManager.fetchData(for: K.TVShowEndpoint.popularTVShows) { (data: [Show], error) in
            
            if let error = error {
                print(error)
                return
            }
            
            self.popularTVShowsArray = data
            self.tvShowCollectionView.reloadData()
            
        }
        
        dataManager.fetchData(for: K.TVShowEndpoint.topRatedTVShows) { (data: [Show], error) in
            
            if let error = error {
                print(error)
                return
            }
            
            self.topRatedTVShowsArray = data
            self.tvShowCollectionView.reloadData()
            
        }
        
    }
    
    func createSelectedSegmentNavigatorBar() {
        
        let segmentWidth = self.view.frame.width - 30
        selectedSegmentBar.frame = CGRect(x: 0, y: tvShowSegmentedController.frame.height, width: segmentWidth / 3, height: 2)
        selectedSegmentBar.backgroundColor = UIColor(named: "brandPurple")
        selectedSegmentContainer.addSubview(selectedSegmentBar)
        
        NSLayoutConstraint.activate([
            selectedSegmentBar.leadingAnchor.constraint(equalTo: selectedSegmentContainer.leadingAnchor, constant: 0),
            selectedSegmentBar.trailingAnchor.constraint(equalTo: selectedSegmentContainer.trailingAnchor, constant: 0),
            selectedSegmentBar.topAnchor.constraint(equalTo: tvShowSegmentedController.bottomAnchor, constant: 0)
        ])

    }
    
    @IBAction func tvShowSegmentedControlButtonPressed(_ sender: UISegmentedControl) {
        
        let selectedSegmentIndex = sender.selectedSegmentIndex
        let segmentWidth = sender.frame.width / CGFloat(sender.numberOfSegments)
        let indicatorX = CGFloat(selectedSegmentIndex) * segmentWidth
        let indicatorFrame = CGRect(x: indicatorX, y: sender.frame.height - 2, width: segmentWidth, height: 2)
        
        UIView.animate(withDuration: 0.2) {
            self.selectedSegmentBar.frame = indicatorFrame
        }
        
        self.tvShowCollectionView.reloadData()
        
    }
    
}

extension TVShowViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setup() {
        
        let layout = BouncyLayout()
        tvShowCollectionView.setCollectionViewLayout(layout, animated: false)
        tvShowCollectionView.dataSource = self
        tvShowCollectionView.delegate = self
        tvShowCollectionView.register(UINib(nibName: "ShowCell", bundle: nil), forCellWithReuseIdentifier: "ShowCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch selectedSegmentIndexAt {
            
            case 0:
                return dailyTrendingTVShowsArray.count
            case 1:
                return popularTVShowsArray.count
            case 2:
                return topRatedTVShowsArray.count
            default:
                return dailyTrendingTVShowsArray.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowCell", for: indexPath) as! ShowCell
        cell.layer.cornerRadius = 10
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.05
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.shadowRadius = 5.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.layer.cornerRadius).cgPath
        
        switch selectedSegmentIndexAt {
        
            case 0:
                cell.setDetails(show: dailyTrendingTVShowsArray[indexPath.item])
            case 1:
                cell.setDetails(show: popularTVShowsArray[indexPath.item])
            case 2:
                cell.setDetails(show: topRatedTVShowsArray[indexPath.item])
                
            default:
                cell.setDetails(show: dailyTrendingTVShowsArray[indexPath.item])
            
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

extension UISegmentedControl {

    func applyWhiteBackgroundColor() {
        // remove bottom shadow of selected element
        self.selectedSegmentTintColor = selectedSegmentTintColor?.withAlphaComponent(0.99)
        if #available(iOS 13.0, *) {
            //just to be sure it is full loaded
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                guard let self = self else {
                    return
                }
                for i in 0 ..< (self.numberOfSegments)  {
                    let backgroundSegmentView = self.subviews[i]
                    //it is not enogh changing the background color. It has some kind of shadow layer
                    backgroundSegmentView.isHidden = true
                }
            }
        }
    }
    
}

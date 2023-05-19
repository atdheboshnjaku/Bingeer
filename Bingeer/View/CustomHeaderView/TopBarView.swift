//
//  TopBarView.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 4/29/23.
//

import UIKit

class TopBarView: UIView {


    @IBOutlet var contentView: UIView!
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var theSearchButton: UIButton!
    @IBOutlet weak var appNameLabel: UILabel!
    
    
    let kCONTENT_XIB_NAME = "TopBarView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        accountButton.setTitle("", for: .normal)
        theSearchButton.setTitle("", for: .normal)
        appNameLabel.text = K.appName
    }
    
}

extension UIView {
    
    func fixInView(_ container: UIView!) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
}

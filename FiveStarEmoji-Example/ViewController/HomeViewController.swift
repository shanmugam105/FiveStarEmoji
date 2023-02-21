//
//  HomeViewController.swift
//  FiveStarEmoji
//
//  Created by Sparkout on 21/02/23.
//

import UIKit
import FiveStarEmoji

class HomeViewController: UIViewController {

    @IBOutlet weak var ratingsView: FiveStarEmoji!
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingsView.starEmoji = [ #imageLiteral(resourceName: "star-1"), #imageLiteral(resourceName: "star-2"), #imageLiteral(resourceName: "star-3"), #imageLiteral(resourceName: "star-4"), #imageLiteral(resourceName: "star-5") ]
        ratingsView.starSelected = #imageLiteral(resourceName: "star-selected")
        ratingsView.starUnselected = #imageLiteral(resourceName: "star-unselected")
        ratingsView.swipable = false
    }
    
    @IBAction func rateNowTapped(_ sender: Any) {
        print(ratingsView.starRating)
    }
}


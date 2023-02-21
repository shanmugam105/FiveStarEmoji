//
//  HomeViewController.swift
//  FiveStarEmoji
//
//  Created by Sparkout on 21/02/23.
//

import UIKit

public class FiveStarEmoji: UIView {
    private lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(starSwiped))
    
    public var swipable: Bool = true {
        didSet {
            configureView()
        }
    }
    
    public var starEmoji: [UIImage]? {
        didSet {
            configureView()
        }
    }
    
    public var starSelected: UIImage! {
        didSet {
            configureView()
        }
    }
    
    public var starUnselected: UIImage! {
        didSet {
            configureView()
        }
    }
    
    private(set) var starRating: Int = 0
    
    
    private lazy var stars: [UIImageView] = [ starImageView1,
                                              starImageView2,
                                              starImageView3,
                                              starImageView4,
                                              starImageView5 ]
    
    private lazy var baseStackView: UIStackView = {
        let stars: [ UIImageView ] = Array(self.stars.prefix(starEmoji?.count ?? 5))
        let stackView: UIStackView = .init(arrangedSubviews: stars)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var starImageView1: UIImageView = {
        let imageView1: UIImageView = .init()
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        return imageView1
    }()
    
    private lazy var starImageView2: UIImageView = {
        let imageView1: UIImageView = .init()
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        return imageView1
    }()
    
    private lazy var starImageView3: UIImageView = {
        let imageView1: UIImageView = .init()
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        return imageView1
    }()
    
    private lazy var starImageView4: UIImageView = {
        let imageView1: UIImageView = .init()
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        return imageView1
    }()
    
    private lazy var starImageView5: UIImageView = {
        let imageView1: UIImageView = .init()
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        return imageView1
    }()
    
    private func configureView() {
        self.addSubview(baseStackView)
        NSLayoutConstraint.activate([
            // MARK: - Constraints for StackView
            baseStackView.topAnchor.constraint(equalTo: topAnchor),
            // baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            baseStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            baseStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // MARK: - Constraints for Star ImageView
        NSLayoutConstraint.activate([
            starImageView1.heightAnchor.constraint(equalTo: starImageView1.widthAnchor),
            starImageView2.heightAnchor.constraint(equalTo: starImageView2.widthAnchor),
            starImageView3.heightAnchor.constraint(equalTo: starImageView3.widthAnchor),
            starImageView4.heightAnchor.constraint(equalTo: starImageView4.widthAnchor),
            starImageView5.heightAnchor.constraint(equalTo: starImageView5.widthAnchor)
        ])
        
        baseStackView.removeGestureRecognizer(panGesture)
        if swipable { baseStackView.addGestureRecognizer(panGesture) }
        baseStackView.isUserInteractionEnabled = true
        
        stars.enumerated().forEach { i, imageView in
            imageView.image = starUnselected
            imageView.isUserInteractionEnabled = true
            imageView.tag = i
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(starTapped))
            imageView.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc private func starTapped(sender: UITapGestureRecognizer)  {
        updateStar(with: sender.view?.tag ?? 0)
    }
    
    @objc private func starSwiped(sender: UISwipeGestureRecognizer)  {
        let position = sender.location(in: baseStackView).x
        let ratingViewWidth = baseStackView.frame.width
        let starCount = starEmoji?.count ?? stars.count
        var rating = 0
        if position > ratingViewWidth {
            rating = starCount - 1
        } else if position < 0 {
            rating = 0
        } else {
            let ratingPosition = position / CGFloat(starCount)
            rating = Int(round(ratingPosition / ratingViewWidth * 20))
        }
        updateStar(with: rating)
    }
    
    private func updateStar(with imageTag: Int) {
        // guard let starImageTag = gestureRecognizer.view?.tag else { return }
        stars.enumerated().forEach { i, imageView in
            if i < imageTag {
                imageView.image = starSelected
            } else if i > imageTag {
                imageView.image = starUnselected
            } else {
                imageView.image = starEmoji?.prefix(5)[i] ?? starSelected
                starRating = i + 1
            }
        }
    }
}

class HomeViewController: UIViewController {

    @IBOutlet weak var ratingsView: FiveStarEmoji!
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingsView.starEmoji = [ #imageLiteral(resourceName: "star-1"), #imageLiteral(resourceName: "star-2"), #imageLiteral(resourceName: "star-3"), #imageLiteral(resourceName: "star-4"), #imageLiteral(resourceName: "star-5") ]
        ratingsView.starSelected = #imageLiteral(resourceName: "star-selected")
        ratingsView.starUnselected = #imageLiteral(resourceName: "star-unselected")
        // ratingsView.swipable = false
    }
    
    @IBAction func rateNowTapped(_ sender: Any) {
        print(ratingsView.starRating)
    }
}


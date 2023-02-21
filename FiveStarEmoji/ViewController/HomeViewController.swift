//
//  HomeViewController.swift
//  FiveStarEmoji
//
//  Created by Sparkout on 21/02/23.
//

import UIKit

class FiveStarEmoji: UIView {
    public var starEmoji: [UIImage]! {
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
        
        stars.enumerated().forEach { i, imageView in
            imageView.image = starUnselected
            imageView.isUserInteractionEnabled = true
            imageView.tag = i
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(starTapped))
            imageView.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func starTapped(sender: UITapGestureRecognizer)  {
        guard let starImageTag = sender.view?.tag else { return }
        stars.enumerated().forEach { i, imageView in
            starRating = i
            if i < starImageTag {
                imageView.image = starSelected
            } else if i > starImageTag {
                imageView.image = starUnselected
            } else {
                imageView.image = starEmoji.prefix(5)[i]
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
    }
}

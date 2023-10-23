//
//  HomeViewController.swift
//  MedBook
//
//  Created by Pranjal Verma on 21/10/23.
//

import UIKit

protocol HomeViewControllerDisplayLogic: AnyObject {
    func displayLogout()
}

class HomeViewController: UIViewController {
    
    var interactor: HomeViewControllerBusinessLogic!
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeViewControllerDataPassing)!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        HomeConfigurator.configure(view: self)
    }
    
    // Constraints constant
    private let leadingConstantForImageView: CGFloat = 20
    private let topConstantForImageView: CGFloat = 6
    private let heightConstantForImageView: CGFloat = 34
    private let widthConstantForImageView: CGFloat = 34

    private let leadingConstantForLabel: CGFloat = 12
    private let heightMultiplierForLabel: CGFloat = 1

    
    private let titleLeadingConstant: CGFloat = 36
    private let titleTrailingConstant: CGFloat = -20
    private let titleTopConstant: CGFloat = 85
    private let titleHeightConstant: CGFloat = 90

    private let logoutLeadingConstant: CGFloat = 154
    private let logoutTrailingConstant: CGFloat = -154
    private let logoutBottomConstant: CGFloat = -35
    private let logoutHeightConstant: CGFloat = 36

    // Define your UI elements
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Which topic interests you today?"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = FontFactory.degularSemiboldFont(size: .titleFont)
        return label
    }()
    
    let appTitleLabel: UILabel = {
        let appTitleLabel = UILabel()
        appTitleLabel.text = "MedBook"
        appTitleLabel.font = FontFactory.degularSemiboldFont(size: .headerFont)
        appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return appTitleLabel
    }()
    
    let bookImageView: UIImageView = {
        // Create an image view
        let bookImageView = UIImageView(image: UIImage(systemName: "book.fill"))
        bookImageView.contentMode = .scaleAspectFill
        bookImageView.tintColor = UIColor.label
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        return bookImageView
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = FontFactory.degularSemiboldFont(size: .buttonFont)
        return button
    }()
    
    override func loadView() {
        super.loadView()
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor1
        logoutButton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
    }
    
    // Programmatic constraints
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bookImageView)
        view.addSubview(appTitleLabel)
        
        view.addSubview(titleLabel)
        view.addSubview(logoutButton)
        
        let safeArea = view.safeAreaLayoutGuide
        
        // constraints
        NSLayoutConstraint.activate([
            bookImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leadingConstantForImageView),
            bookImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstantForImageView),
            bookImageView.heightAnchor.constraint(equalToConstant: heightConstantForImageView),
            bookImageView.widthAnchor.constraint(equalToConstant: widthConstantForImageView),
            
            appTitleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: leadingConstantForLabel),
            appTitleLabel.topAnchor.constraint(equalTo: bookImageView.topAnchor),
            appTitleLabel.heightAnchor.constraint(equalTo: bookImageView.heightAnchor, multiplier: heightMultiplierForLabel),
            
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: titleLeadingConstant),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: titleTrailingConstant),
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: titleTopConstant),
            titleLabel.heightAnchor.constraint(equalToConstant: titleHeightConstant),

            logoutButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: logoutLeadingConstant),
            logoutButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: logoutTrailingConstant),
            logoutButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: logoutBottomConstant),
            logoutButton.heightAnchor.constraint(equalToConstant: logoutHeightConstant)
        ])
    }
    
    
    @objc func logoutAction() {
        interactor.logoutUser()
    }
    
}

extension HomeViewController: HomeViewControllerDisplayLogic {
    func displayLogout() {
        router.routeToLandingVC()
    }
}

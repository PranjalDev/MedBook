//
//  LandingViewController.swift
//  MedBook
//
//  Created by Pranjal Verma on 21/10/23.
//

import UIKit

class LandingViewController: UIViewController {
    
    private let titleLeadingConstant: CGFloat = 20
    private let titleTrailingConstant: CGFloat = -20
    private let titleTopConstant: CGFloat = 20
    private let titleHeightConstant: CGFloat = 34

    private let signUpTrailingConstant: CGFloat = -4
    private let signUpLeadingConstant: CGFloat = 25
    private let signUpBottomConstant: CGFloat = -26
    private let signUpHeightConstant: CGFloat = 44

    private let loginLeadingConstant: CGFloat = 4
    private let loginTrailingConstant: CGFloat = -25
    private let loginBottomConstant: CGFloat = -26
    private let loginHeightConstant: CGFloat = 44

    private let backgroundHeightMultiplier: CGFloat = 0.8

    
    lazy var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.image = UIImage(resource: .landing)
        return backgroundImageView
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Signup", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = FontFactory.degularSemiboldFont(size: .buttonFont)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.backgroundColor = .buttonBGColor
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = FontFactory.degularSemiboldFont(size: .buttonFont)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = .buttonCornerRadius
        button.layer.borderWidth = 1
        button.backgroundColor = .buttonBGColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .backgroundColor1
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        // title
        let titleLbl = UILabel()
        titleLbl.text = "MedBook"
        titleLbl.font = FontFactory.degularSemiboldFont(size: .headerFont)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        // add subviews to view
        view.addSubview(titleLbl)
        view.addSubview(signUpButton)
        view.addSubview(loginButton)
        
        
        // constraints
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: titleLeadingConstant),
            titleLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: titleTrailingConstant),
            titleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: titleTopConstant),
            titleLbl.heightAnchor.constraint(equalToConstant: titleHeightConstant),
            
            signUpButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: signUpTrailingConstant),
            signUpButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: signUpLeadingConstant),
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: signUpBottomConstant),
            signUpButton.heightAnchor.constraint(equalToConstant: signUpHeightConstant),
            
            loginButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: loginLeadingConstant),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: loginTrailingConstant),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: loginBottomConstant),
            loginButton.heightAnchor.constraint(equalToConstant: loginHeightConstant),
            
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: view.frame.height * backgroundHeightMultiplier)
        ])
        
        
        // add targets
        signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
    }
    
    @objc func signUpAction(sender: UIButton) {
        let signVC = UserSignupViewController()
        navigationController?.pushViewController(signVC, animated: true)
    }
    
    @objc func loginAction(sender: UIButton) {
        let signVC = UserLoginViewController()
        navigationController?.pushViewController(signVC, animated: true)
    }
}

//
//  UserLoginViewController.swift
//  MedBook
//
//  Created by Pranjal Verma on 21/10/23.
//

import UIKit

protocol UserLoginViewControllerDisplayLogic: AnyObject {
    func displayAlert(viewModel: UserLoginEntity.login.ViewModel)
    func routeToHomeVC()
}

class UserLoginViewController: UIViewController {
    
    var interactor: UserLoginViewControllerBusinessLogic!
    var router: (NSObjectProtocol & UserLoginRoutingLogic & UserLoginDataPassing)!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    private func configure() {
        UserLoginConfigurator.configure(view: self)
    }
    
    // Background Image Constants
    private let backgroundImageTop: CGFloat = 0
    private let backgroundImageLeading: CGFloat = 0
    private let backgroundImageTrailing: CGFloat = 0
    private let backgroundImageHeight: CGFloat = 0.42

    // Welcome Label Constants
    private let welcomeLabelTop: CGFloat = 40
    private let welcomeLabelLeading: CGFloat = 16

    // Login Label Constants
    private let loginLabelTop: CGFloat = 12.67
    private let loginLabelLeading: CGFloat = 16

    // Email Text Field Constants
    private let emailTextFieldTop: CGFloat = 40
    private let emailTextFieldLeading: CGFloat = 30
    private let emailTextFieldTrailing: CGFloat = -30
    private let emailTextFieldHeight: CGFloat = 48

    // Password Text Field Constants
    private let passwordTextFieldTop: CGFloat = 41
    private let passwordTextFieldLeading: CGFloat = 30
    private let passwordTextFieldTrailing: CGFloat = -30
    private let passwordTextFieldHeight: CGFloat = 48

    // Login Button Constants
    private let loginButtonBottom: CGFloat = -30
    private let loginButtonLeading: CGFloat = 100
    private let loginButtonTrailing: CGFloat = -100
    private let loginButtonHeight: CGFloat = 48
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "shape"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome,"
        label.font = FontFactory.degularSemiboldFont(size: .titleFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "log in to continue"
        label.font = FontFactory.degularSemiboldFont(size: .titleFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .none
        textField.textAlignment = .natural
        textField.minimumFontSize = 17
        textField.addBottomLine(color: .lightGray)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .none
        textField.textAlignment = .natural
        textField.minimumFontSize = 17
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addBottomLine(color: .lightGray)
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login ", for: .normal)
        button.titleLabel?.font = FontFactory.degularFont(size: .buttonFont)
        button.backgroundColor = .buttonBGColor
        button.tintColor = .lightGray
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    
    override func loadView() {
        super.loadView()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .white
        
        addBottomLineToTxtFld()
        setupTapGesture()
        loginButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }
    
    
    private func setupViews() {
        view.addSubview(backgroundImage)
        view.addSubview(welcomeLabel)
        view.addSubview(loginLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Background Image Constraints
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: backgroundImageTop),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: backgroundImageLeading),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: backgroundImageTrailing),
            backgroundImage.heightAnchor.constraint(equalToConstant: view.frame.height * backgroundImageHeight),
            
            // Welcome Label Constraints
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: welcomeLabelTop),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: welcomeLabelLeading),
            
            // Login Label Constraints
            loginLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: loginLabelTop),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: loginLabelLeading),
            
            // Email Text Field Constraints
            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: emailTextFieldTop),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: emailTextFieldLeading),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: emailTextFieldTrailing),
            emailTextField.heightAnchor.constraint(equalToConstant: emailTextFieldHeight),
            
            // Password Text Field Constraints
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: passwordTextFieldTop),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: passwordTextFieldLeading),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: passwordTextFieldTrailing),
            passwordTextField.heightAnchor.constraint(equalToConstant: passwordTextFieldHeight),
            
            // Login Button Constraints
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: loginButtonBottom),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: loginButtonLeading),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: loginButtonTrailing),
            loginButton.heightAnchor.constraint(equalToConstant: loginButtonHeight)
        ])
    }
    
   private func addBottomLineToTxtFld() {
        emailTextField.addBottomLine(color: .lightGray)
        passwordTextField.addBottomLine(color: .lightGray)
    }
    
    private func setupTapGesture() {
        emailTextField.becomeFirstResponder()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @objc func nextAction() {
        login()
    }
    
    private func login() {
        interactor.validateCredentials(request: UserLoginEntity.login.Request(email: emailTextField.text, password: passwordTextField.text))
    }
}

extension UserLoginViewController: UserLoginViewControllerDisplayLogic {
    func displayAlert(viewModel: UserLoginEntity.login.ViewModel) {
        UIAlertController.showAlert(title: viewModel.title ?? "", message: viewModel.message ?? "", present: self)
    }
    
    func routeToHomeVC() {
        router.routeToHomeVC()
    }
}

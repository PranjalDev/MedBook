//
//  UserSignupViewController.swift
//  MedBook
//
//  Created by Pranjal Verma on 21/10/23.
//

import UIKit

protocol UserSignupViewControllerDisplayLogic: AnyObject {
    func display(viewModel: UserSignupEntity.Signup.ViewModel)
    func displayAlert(viewModel: UserSignupEntity.ShowAlert.ViewModel)
    func routeToHomeVC()
    func displayPasswordConditions(viewModel: UserSignupEntity.PasswordCondition.ViewModel)
}

class UserSignupViewController: UIViewController {
    
    var interactor: UserSignupViewControllerBusinessLogic!
    var router: (NSObjectProtocol & UserSignupRoutingLogic & UserSignupDataPassing)!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    private func configure() {
        UserSignupConfigurator.configure(view: self)
    }
    
    private let backgroundTopConstant: CGFloat = 0
    private let backgroundLeadingConstant: CGFloat = 0
    private let backgroundTrailingConstant: CGFloat = 0
    private let backgroundHeightConstant: CGFloat = 0.42

    private let welcomeTopConstant: CGFloat = 20
    private let welcomeLeadingConstant: CGFloat = 16

    private let signUpTopConstant: CGFloat = 12.67
    private let signUpLeadingConstant: CGFloat = 16

    private let emailTopConstant: CGFloat = 50
    private let emailLeadingConstant: CGFloat = 30
    private let emailTrailingConstant: CGFloat = -30
    private let emailHeightConstant: CGFloat = 48

    private let passwordTopConstant: CGFloat = 40
    private let passwordLeadingConstant: CGFloat = 30
    private let passwordTrailingConstant: CGFloat = -30
    private let passwordHeightConstant: CGFloat = 48

    private let signUpButtonBottomConstant: CGFloat = -30
    private let signUpButtonLeadingConstant: CGFloat = 100
    private let signUpButtonTrailingConstant: CGFloat = -100
    private let signUpButtonHeightConstant: CGFloat = 48

    private let countryPickerViewBottomConstant: CGFloat = -35
    private let countryPickerViewHeightConstant: CGFloat = 140
    private let tableTopConstant: CGFloat = 20
    private let tableBottomConstant: CGFloat = -20

    
    // Define all the UI elements
    let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "shape"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome,"
        // CodeReview: Custom font p2
        label.font = FontFactory.degularSemiboldFont(size: .titleFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "sign up to continue"
        label.font = FontFactory.degularSemiboldFont(size: .titleFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.textAlignment = .natural
        textField.minimumFontSize = .textFont
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.textAlignment = .natural
        textField.minimumFontSize = .textFont
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Let's go ", for: .normal)
        button.titleLabel?.font = FontFactory.degularFont(size: .buttonFont)
        button.backgroundColor = .buttonBGColor
        button.tintColor = .lightGray
        button.layer.cornerRadius = .buttonCornerRadius
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    let countryPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.clipsToBounds = true
        tableView.contentMode = .scaleToFill
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    var countries: [Country] = []
    var passwordConditions: [PasswordConditionModel] = []
    
    override func loadView() {
        super.loadView()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the background color
        view.backgroundColor = .white
        tableView.backgroundColor = .clear
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        
        // Add action for the button
        signupButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)

        interactor.fetch(request: UserSignupEntity.Signup.Request())
        interactor.fetchPasswordConditionsModel()
        setupDelegates()

        setupTapGesture()
        addBottomLineToTxtFld()
    }
    
    private func setupViews() {
        // Add the UI elements to the view
        view.addSubview(backgroundImage)
        view.addSubview(welcomeLabel)
        view.addSubview(signUpLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signupButton)
        view.addSubview(countryPickerView)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        // Add constraints for each UI element
        NSLayoutConstraint.activate([
            // Background Image Constraints
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: backgroundTopConstant),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: backgroundLeadingConstant),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: backgroundTrailingConstant),
            backgroundImage.heightAnchor.constraint(equalToConstant: view.frame.height * backgroundHeightConstant),

            // Welcome Label Constraints
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: welcomeTopConstant),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: welcomeLeadingConstant),

            // Sign Up Label Constraints
            signUpLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: signUpTopConstant),
            signUpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: signUpLeadingConstant),

            // Email Text Field Constraints
            emailTextField.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: emailTopConstant),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: emailLeadingConstant),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: emailTrailingConstant),
            emailTextField.heightAnchor.constraint(equalToConstant: emailHeightConstant),

            // Password Text Field Constraints
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: passwordTopConstant),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: passwordLeadingConstant),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: passwordTrailingConstant),
            passwordTextField.heightAnchor.constraint(equalToConstant: passwordHeightConstant),

            // Sign Up Button Constraints
            signupButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: signUpButtonBottomConstant),
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: signUpButtonLeadingConstant),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: signUpButtonTrailingConstant),
            signupButton.heightAnchor.constraint(equalToConstant: signUpButtonHeightConstant),

            // Country Picker View Constraints
            countryPickerView.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: countryPickerViewBottomConstant),
            countryPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countryPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countryPickerView.heightAnchor.constraint(equalToConstant: countryPickerViewHeightConstant),

            // Table View Constraints
            tableView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: tableTopConstant),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: countryPickerView.topAnchor, constant: tableBottomConstant)
        ])
    }
    
    private func addBottomLineToTxtFld() {
        emailTextField.addBottomLine(color: .lightGray)
        passwordTextField.addBottomLine(color: .lightGray)
    }
    
    private func setupDelegates() {
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        tableView.dataSource = self
        passwordTextField.delegate = self
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
    
    // Add action for the button
    @objc func nextAction() {
        signUp()
    }
    
    private func signUp() {
        let selectedRow = countryPickerView.selectedRow(inComponent: 0)
        let selectedCountry = countries[selectedRow].country
        
        interactor.validateAndSaveUserDetail(request: UserSignupEntity.ValidateAndSave.Request(email: emailTextField.text, password: passwordTextField.text, selectedCountry: selectedCountry))
    }
    
}

extension UserSignupViewController: UserSignupViewControllerDisplayLogic {
    func displayAlert(viewModel: UserSignupEntity.ShowAlert.ViewModel) {
        UIAlertController.showAlert(title: viewModel.title ?? "", message: viewModel.message ?? "", present: self)
    }
    
    func routeToHomeVC() {
        router.routeToHomeVC()
    }
    
    func display(viewModel: UserSignupEntity.Signup.ViewModel) {
        countries = viewModel.countries
        self.countryPickerView.reloadAllComponents()
    }
    
    func displayPasswordConditions(viewModel: UserSignupEntity.PasswordCondition.ViewModel) {
        passwordConditions = viewModel.passwordConditions
        tableView.reloadData()
    }
}

extension UserSignupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        passwordConditions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = passwordConditions[indexPath.row].condition
        cell.imageView?.image = passwordConditions[indexPath.row].image
        cell.imageView?.tintColor = .black
        cell.backgroundColor = .clear
        return cell
    }
}

extension UserSignupViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        countries[row].country
    }
}

extension UserSignupViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = passwordTextField.text else {
            return true
        }
        
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        interactor.checkPasswordStrength(password: updatedText)
        return true
    }
}


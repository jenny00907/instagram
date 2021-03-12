//
//  LoginController.swift
//  Instagram
//
//  Created by Jenny Woorim Lee on 2021/03/09.
//

import UIKit

protocol AuthenticationDelegate: class { //retain cycle
    func authenticationDidComplete()
}


class LoginController: UIViewController {
    
    private var viewModel = LoginViewModel()
    weak var delegate: AuthenticationDelegate?
    
    private let iconImage : UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let PasswordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handlelogin), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.attributedTitle(firstPart: "Forgot your password?", secondPart: "Get help signing in. ")
        
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have account?", secondPart: "Sign up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    //MARK: - Actions
    @objc func handleShowSignUp() {
        let controller = RegisterController()
        navigationController?.pushViewController(controller, animated: true)
        controller.delegate = delegate
    }
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    @objc func handlelogin() {
        guard let email = emailTextField.text else {return}
        guard let password = PasswordTextField.text else {return}
        
        AuthService.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to log user in \(error.localizedDescription)")
                return
        }
            self.delegate?.authenticationDidComplete()
        }
    }
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    func configureUI() {
        configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, PasswordTextField, loginButton, forgotPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
    
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left:view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        PasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}
//MARK: - FormViewModel
extension LoginController: FormViewModel {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
}


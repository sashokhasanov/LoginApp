//
//  ViewController.swift
//  LoginApp
//
//  Created by Сашок on 14.12.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let login = "Happy"
    private let password = "123"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "loginSegue") {
            let welocmeController = segue.destination as! WelcomeViewController
            welocmeController.login = login
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    @IBAction func loginButtonPressed() {
        processLogin()
    }
    
    @IBAction func unwindLoginSegue(_ segue: UIStoryboardSegue) {
        loginTextField.text = nil
        passwordTextField.text = nil
    }
    
    @IBAction func forgotLoginpressed() {
        showAlert(title: "🦄", message: "username is \"\(login)\"")
    }
    
    @IBAction func forgotPasswordPressed() {
        showAlert(title: "🦄", message: "password is \"\(password)\"")
    }
    
    private func processLogin() {
        if (checkLoginAndPassword()) {
            performSegue(withIdentifier: "loginSegue", sender: self)
        } else {
            showAlert(title: "Oops 😥", message: "invalid login or password")
        }
    }
    
    private func checkLoginAndPassword() -> Bool {
        let inputLogin = loginTextField.text ?? ""
        let inputPassword = passwordTextField.text ?? ""
        
        return login == inputLogin && password == inputPassword
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            processLogin()
        default:
            break
        }

        return true
    }
}


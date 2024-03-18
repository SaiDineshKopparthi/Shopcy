//
//  CreateAccountVC.swift
//  Shopcy
//
//  Created by Sai Dinesh Kopparthi on 3/5/24.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    //UILabels
    @IBOutlet weak var messageLBL: UILabel!
    
    //UITextFields
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var checkPasswordTF: UITextField!
    
    @IBOutlet weak var registerBTN: UIButton!
    //UIButtons
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = ""
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func passwordCheck(_ sender: UITextField) {
        guard let password = sender.text, !(self.checkPasswordTF.text!).isEmpty, password == self.checkPasswordTF.text else{
            self.messageLBL.text = "Password should match!"
            return
        }
        self.messageLBL.text = ""
    }
    @IBAction func rePasswordCheck(_ sender: UITextField) {
        guard let password = sender.text, !password.isEmpty, password == self.passwordTF.text else{
            self.messageLBL.text = "Password should match!"
            return
        }
        self.messageLBL.text = ""
    }
    
    //To exit text fields when tapped on return
    @IBAction func exitTextFieldOnReturn(_ sender: UITextField) {
    }
    
    @IBAction func createUser(_ sender: UIButton) {
        guard let email = self.emailTF.text, !email.isEmpty else{
            self.messageLBL.text = "Please enter email!"
            return
        }
        guard let password = self.passwordTF.text, !password.isEmpty, let rePassword = self.checkPasswordTF.text, !rePassword.isEmpty else{
            self.messageLBL.text = "Please enter password in both fields!"
            return
        }
        guard password == rePassword else{
            self.messageLBL.text = "Password should match!"
            return
        }
        self.messageLBL.text = ""
        Task {
            do{
                _ = try await AuthenticationManager.shared.createUser(email: email, password: password)
                self.performSegue(withIdentifier: "createAccountToLogin", sender: sender)
                
            } catch {
                self.messageLBL.text = error.localizedDescription
            }
        }
    }
    
    @IBAction func cancelAccountCreation(_ sender: UIButton) {
        self.performSegue(withIdentifier: "createAccountToLogin", sender: sender)
    }
    
    
}

//
//  ResetPasswordVC.swift
//  Shopcy
//
//  Created by Sai Dinesh Kopparthi on 3/5/24.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    //UITextFields
    @IBOutlet weak var emailTF: UITextField!
    
    //UILabel
    @IBOutlet weak var messageLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = ""
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func onClickSendLink(_ sender: UIButton) {
        guard let email = self.emailTF.text, !email.isEmpty else {
            self.messageLBL.text = "Please enter email!"
            return
        }
        self.messageLBL.text = ""
        Task{
            do{
                try await AuthenticationManager.shared.resetPassword(email: email)
                self.performSegue(withIdentifier: "resetPasswordToLogin", sender: self)
            }catch {
                print("Error at Resetting password: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func cancelPasswordReset(_ sender: UIButton) {
        self.performSegue(withIdentifier: "resetPasswordToLogin", sender: self)
    }
    
    //To close text field when tapped on return
    @IBAction func exitTextFieldOnReturn(_ sender: UITextField) {
    }
}

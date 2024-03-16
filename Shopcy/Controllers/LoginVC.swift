//
//  LoginVC.swift
//  Shopcy
//
//  Created by Sai Dinesh Kopparthi on 2/15/24.
//

import UIKit
import Lottie

class LoginVC: UIViewController {
    
    //Lottie Animation Views
    @IBOutlet weak var loginLAV: LottieAnimationView!{
        didSet{
            loginLAV.animation = LottieAnimation.named("Shopcy_Login")
            loginLAV.loopMode = .loop
            loginLAV.play()
        }
    }
    
    //Labels
    @IBOutlet weak var messageLBL: UILabel!
    
    //Text Fields
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    //Buttons
    @IBOutlet weak var loginBTN: UIButton!
    
    
    //Products Array
    var products: [String : Product] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func exitTextFieldOnReturn(_ sender: UITextField) {
    }
    
    
    @IBAction func onLogin(_ sender: UIButton) {
        guard let username = self.usernameTF.text, !username.isEmpty else {
            self.messageLBL.text = "Please enter Username!"
            return
        }
        
        guard let password = self.passwordTF.text, !password.isEmpty else{
            self.messageLBL.text = "Please enter Password!"
            return
        }
        
        self.messageLBL.text = ""
        Task{
            do{
                _ = try await AuthenticationManager.shared.signIn(email: username, password: password)
                self.performSegue(withIdentifier: "loginToProducts", sender: self)
            }
            catch {
                print(error)
                self.messageLBL.text = "Invalid Login Credentials! Please try again."
            }
        }
    }
}

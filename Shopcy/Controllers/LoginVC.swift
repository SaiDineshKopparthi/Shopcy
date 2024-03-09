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
    @IBOutlet weak var launchLAV: LottieAnimationView!{
        didSet{
            launchLAV.animation = LottieAnimation.named("Shopcy_Launch")
            launchLAV.loopMode = .playOnce
            launchLAV.alpha = 1.0
            launchLAV.play{ [weak self] _ in
                UIViewPropertyAnimator.runningPropertyAnimator(
                    withDuration: 1.0,
                    delay: 0.0,
                    options: [.curveEaseInOut]){
                        self?.launchLAV.alpha = 0.0
                    }
                
            }
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
    //MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.identifier{
//        case "loginToProducts":
//            guard let destVC = segue.destination as? ProductsVC else {return}
//            //destVC.products = self.products
//        default:
//            break
//        }
//    }
    
}

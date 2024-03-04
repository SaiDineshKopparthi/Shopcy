//
//  LoginVC.swift
//  Shopcy
//
//  Created by Sai Dinesh Kopparthi on 2/15/24.
//

import UIKit
import Lottie

class LoginVC: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
}

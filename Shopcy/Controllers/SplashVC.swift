//
//  SplashVC.swift
//  Shopcy
//
//  Created by Sai Dinesh Kopparthi on 3/15/24.
//

import UIKit
import Lottie

class SplashVC: UIViewController {
            
    @IBOutlet weak var launchLAV: LottieAnimationView!{
        didSet{
            launchLAV.animation = LottieAnimation.named("Shopcy_Launch")
            launchLAV.loopMode = .playOnce
            launchLAV.play{ [weak self] _ in
                self?.performSegue(withIdentifier: "SplashToLogin", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

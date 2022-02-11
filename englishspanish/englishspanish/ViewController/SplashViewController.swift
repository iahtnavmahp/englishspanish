//
//  SplashViewController.swift
//  englishspanish
//
//  Created by Pham Van Thai on 06/05/2021.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in

                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc:UIViewController = storyboard.instantiateViewController(withIdentifier: "TabarController") as! UIViewController
                vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
                self.present(vc, animated:true)
                timer.invalidate()
        }
    }
    

}

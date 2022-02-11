//
//  MainTabBarController.swift
//  englishspanish
//
//  Created by Pham Van Thai on 27/06/2021.
//

import UIKit
protocol MainTabBarControllerDelegate {
    func onTabSelected(isTheSame: Bool)
}
class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        (viewController as? MainTabBarControllerDelegate)?.onTabSelected(isTheSame: selectedViewController == viewController)
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

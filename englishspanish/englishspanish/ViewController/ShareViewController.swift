//
//  ShareViewController.swift
//  englishspanish
//
//  Created by Pham Van Thai on 09/05/2021.
//

import UIKit
import Social

class ShareViewController: UIViewController {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func shareNow(_ sender: Any) {
        
        // Setting description
            let firstActivityItem = "Description you want.."

            // Setting url
            let secondActivityItem : NSURL = NSURL(string: "http://google.com/")!
            
            // If you want to use an image
        UIGraphicsBeginImageContext(view.frame.size)
               view.layer.render(in: UIGraphicsGetCurrentContext()!)
               let image = UIGraphicsGetImageFromCurrentImageContext()
               UIGraphicsEndImageContext()
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem, secondActivityItem,image ?? #imageLiteral(resourceName: "app-logo")], applicationActivities: nil)
            
            // This lines is for the popover you need to show in iPad
            activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
            
            // This line remove the arrow of the popover to show in iPad
            activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
            
            // Pre-configuring activity items
        if #available(iOS 13.0, *) {
            activityViewController.activityItemsConfiguration = [
                UIActivity.ActivityType.message
            ] as? UIActivityItemsConfigurationReading
        } else {
            // Fallback on earlier versions
        }
            
            // Anything you want to exclude
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.print,
            ]
            
        if #available(iOS 13.0, *) {
            activityViewController.isModalInPresentation = true
        } else {
            // Fallback on earlier versions
        }
            self.present(activityViewController, animated: true, completion: nil)
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


//
//  SpeakingViewController.swift
//  englishspanish
//
//  Created by Pham Van Thai on 18/06/2021.
//

import UIKit

class SpeakingViewController: UIViewController {
   
    
    var txtTitle:String = ""
    var isSpeak:Int = 0
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passDataToGreeting"{
            let vc = segue.destination as! GreetingViewController
            vc.textAsSpeaking = self.txtTitle
            vc.isAsSpeaking = self.isSpeak
        }
       
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func scrConversation(_ sender: Any) {
        self.txtTitle = "General conversation"
        self.isSpeak = 0
        performSegue(withIdentifier: "passDataToGreeting", sender: self)
        
    }
    
    @IBAction func scrAlphabet(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:UIViewController = storyboard.instantiateViewController(withIdentifier: "AlphabetViewController") as! AlphabetViewController
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated:true)
        
    }
    @IBAction func scrGreeting(_ sender: Any) {
        self.txtTitle = "Greeting"
        self.isSpeak = 1
        performSegue(withIdentifier: "passDataToGreeting", sender: self)
      
    }
    
    @IBAction func scrNumbers(_ sender: Any) {
        self.txtTitle = "Numbers"
        self.isSpeak = 2
        performSegue(withIdentifier: "passDataToGreeting", sender: self)
    }
    @IBAction func scrTimeAndDate(_ sender: Any) {
        self.txtTitle = "Time and Date"
        self.isSpeak = 3
        performSegue(withIdentifier: "passDataToGreeting", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func unwindToSpeakingViewController(unwindSegue: UIStoryboardSegue){
        
    }
}

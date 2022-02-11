//
//  TranslatorViewController.swift
//  englishspanish
//
//  Created by Pham Van Thai on 11/05/2021.
//

import UIKit
import InstantSearchVoiceOverlay

class TranslatorViewController: UIViewController, VoiceOverlayDelegate {
    var listdataDictionary:[DictionaryModel] = [DictionaryModel]()
    @IBOutlet weak var txtEnglish: UITextField!
    
    @IBOutlet weak var txtHindi: UITextField!
    let voiceOverlay = VoiceOverlayController()
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        SqliteService.shared.getDictionaryApp(){ response,error in
            if let response = response{
                self.listdataDictionary = response
                
            }
            
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recordVoice(_ sender: Any) {
        voiceOverlay.delegate = self
        voiceOverlay.settings.autoStart = false
        voiceOverlay.settings.autoStop = true
        voiceOverlay.settings.autoStopTimeout = 2
        voiceOverlay.start(on: self, textHandler: {text, final, _ in
            if final {
                self.txtEnglish.text = text
                for x in self.listdataDictionary {
                    if x.English.uppercased().contains(text.uppercased()){
                        print("\(x)")
                        self.txtHindi.text = x.Hindi
                        break
                    }else{
                        self.txtHindi.text = "not found"
                    }
                    
                }
                    
                
                
                
            }else {
                self.txtEnglish.text = "not found : \(text)"
            }
            
        }, errorHandler: {error in
            
        })
    }
    func recording(text: String?, final: Bool?, error: Error?){
        
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

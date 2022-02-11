//
//  MeaningViewController.swift
//  englishspanish
//
//  Created by Pham Van Thai on 11/05/2021.
//

import UIKit
import AVFoundation

class MeaningViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var listdataDictionary1:[DictionaryModel] = [DictionaryModel]()
    var listdataSearch:[DictionaryModel] = [DictionaryModel]()
    var hindiString :String = ""
    var arrHindi : [String] = []
    var myTable: Bool = true
    
    
    @IBOutlet weak var meaningSearchbar: UISearchBar!
    
    
    
    var finalTextField1 = ""
    
   
    @IBOutlet weak var meaningTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        meaningSearchbar.delegate = self
        let nib = UINib(nibName: "MeaningTableViewCell", bundle: nil)
        meaningTable.register(nib, forCellReuseIdentifier: "MeaningTableViewCell")
        meaningTable.dataSource = self
        meaningTable.delegate = self
        
        meaningSearchbar.text = finalTextField1
        SqliteService.shared.getDictionaryApp(){ response,error in
            if let response = response{
                self.listdataDictionary1 = response
                
            }
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(myTable == true){
            return self.listdataSearch.count
        }else{
            return self.arrHindi.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeaningTableViewCell", for: indexPath) as! MeaningTableViewCell
        if(myTable == true){
            cell.txtLabel.text = self.listdataSearch[indexPath.row].English
        }else{
            cell.txtLabel.text = self.arrHindi[indexPath.row]
        }
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listdataSearch = []
       
        for x in listdataDictionary1 {
            if x.English.uppercased().contains(searchText.uppercased()){
                listdataSearch.append(x)
            }
        }
        if(searchText.count == 0){
            self.myTable = true
        }
        self.meaningTable.reloadData()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(myTable == true){
            hindiString = self.listdataSearch[indexPath.row].Hindi
           self.meaningSearchbar.text = self.listdataSearch[indexPath.row].English
           self.arrHindi = hindiString.split(separator: ",").map({ (substring) in
               return String(substring)
           })
          
           
           self.myTable = false
           self.meaningTable.reloadData()
        }else{
            self.meaningSearchbar.text = self.arrHindi[indexPath.row]
            
        }
    }
    @IBAction func textToSpeech(_ sender: Any) {
        let  stringToSpeech: String = self.meaningSearchbar.text! 
        let utterance = AVSpeechUtterance(string: stringToSpeech)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
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

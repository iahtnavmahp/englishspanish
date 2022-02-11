//
//  MainViewController.swift
//  englishspanish
//
//  Created by Pham Van Thai on 06/05/2021.
//
import InstantSearchVoiceOverlay
import AVFoundation
import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate , VoiceOverlayDelegate, MainTabBarControllerDelegate{
    func onTabSelected(isTheSame: Bool) {
        self.searchBar.text = ""
        print("ban vua nhan vao main")
        self.isTable = 0
        self.listRandomWordByDays.removeAll()
        self.listdataDictionary.removeAll()
        SqliteService.shared.getDictionaryApp(){ response,error in
            if let response = response{
                self.listdataDictionary = response
               
            }
        }
        for x in list1{
            listRandomWordByDays.append(listdataDictionary[x])
        }
        
        if let tableView = tableView{
            tableView.reloadData()
        }
    }
    
    func recording(text: String?, final: Bool?, error: Error?) {
        
    }
    var isUnwind1:Bool = false
    var isUnwind2:Bool = false
    var isVoice:Bool = false
    var unwindStr:String = ""
    var list1:[Int] = []
    var listdataDictionary:[DictionaryModel] = [DictionaryModel]()
    var listdataSearch:[DictionaryModel] = [DictionaryModel]()
    var isTable = 0
    var listRandomWordByDays:[DictionaryModel] = [DictionaryModel]()
    var hindiString :String = ""
    var arrHindi : [String] = []
    let voiceOverlay = VoiceOverlayController()
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myViewCrl: UIView!
    
    //--------------------text to speech
    @IBAction func scrMeaningViewController(_ sender: Any) {
        isUnwind2 = false
        //-----------------setting
        let audioSession = AVAudioSession.sharedInstance()  //2
                    do {
                        try audioSession.setCategory(AVAudioSession.Category.soloAmbient)
                        try audioSession.setMode(AVAudioSession.Mode.spokenAudio)
                        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                    } catch {
                        print("err text to speech")
                    }
                //-----------------setting
                let  stringToSpeech: String = self.searchBar.text!
                let utterance = AVSpeechUtterance(string: stringToSpeech)
        if(isVoice == true){
            utterance.voice = AVSpeechSynthesisVoice(language: "es-ES")
            print("nhan vao noi \(isVoice)")
        }else{
            print("nhan vao noi \(isVoice)")
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        }
       
                
                let synth = AVSpeechSynthesizer()
                synth.speak(utterance)
        
    }
    
    //----------------- void to text
    @IBAction func scrTranslatorViewController(_ sender: Any) {
        
        isUnwind2 = false
        voiceOverlay.delegate = self
        voiceOverlay.settings.autoStart = false
        voiceOverlay.settings.autoStop = true
        voiceOverlay.settings.autoStopTimeout = 2
        voiceOverlay.start(on: self, textHandler: {text, final, _ in
            if final {
                self.isTable = 2
                self.arrHindi.removeAll()
                self.searchBar.text = text
                self.hindiString = text
                for x in self.listdataDictionary {
                    if x.English.uppercased().contains(self.hindiString.uppercased()){
                        print("\(x.Hindi)")
                        self.arrHindi = x.Hindi.split(separator: ",").map({ (substring) in
                            return String(substring)
                        })
                        print("mang la \(self.arrHindi)")
                        self.tableView.reloadData()
                        break
                    }else{
                        
                        
                    }
                    
                }
               
                
            }else {
//                self.myLabel.text = "not found : \(text)"
                self.isTable = 0
                self.tableView.reloadData()
            }
            
        }, errorHandler: {error in
            
        })
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .pad{
            searchBar.frame.size = CGSize(width: myViewCrl.frame.size.width, height: 75)
            myViewCrl.frame.size = CGSize(width:view.frame.size.width/1.15 , height: 500)
        }
        let nib = UINib(nibName: "WordTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "WordTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        myViewCrl.layer.cornerRadius = 20
        searchBarSearchButtonClicked(searchBar)
        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            tap.cancelsTouchesInView = false
        
            view.addGestureRecognizer(tap)
        
      //---------------custom search bar
        searchBar.delegate = self
        searchBar.endEditing(true)
        searchBar.placeholder = "Search"
        searchBar.layer.borderWidth = 0
        if #available(iOS 13.0, *) {
         searchBar.searchTextField.textColor = .white
            searchBar.heightAnchor.constraint(equalToConstant: 130).isActive = true
            
            func getImageWithCustomColor(color: UIColor, size: CGSize) -> UIImage {
                let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                UIGraphicsBeginImageContextWithOptions(size, false, 0)
                color.setFill()
                UIRectFill(rect)
                let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                return image
            }
            func viewDidLayoutSubviews() {
                self.searchBar.layoutIfNeeded()
                self.searchBar.layoutSubviews()
           
            }
            let backgroundImage = getImageWithCustomColor(color: UIColor.clear, size: CGSize(width: 265, height: 130))

            searchBar.setSearchFieldBackgroundImage(backgroundImage, for: .normal)
            
           
        }
      //----------------get database
        SqliteService.shared.getDictionaryApp(){ response,error in
            if let response = response{
                self.listdataDictionary = response
                let index1 = Int.random(in: 0...self.listdataDictionary.count)
                self.listRandomWordByDays.append(self.listdataDictionary[index1])
                self.list1.append(index1)
                let index2 = Int.random(in: 0...self.listdataDictionary.count)
                self.listRandomWordByDays.append(self.listdataDictionary[index2])
                self.list1.append(index2)
                let index3 = Int.random(in: 0...self.listdataDictionary.count)
                self.listRandomWordByDays.append(self.listdataDictionary[index3])
                self.list1.append(index3)
                let index4 = Int.random(in: 0...self.listdataDictionary.count)
                self.listRandomWordByDays.append(self.listdataDictionary[index4])
                self.list1.append(index4)
                self.tableView.reloadData()
            }
            
        }
    }
    //--------------set number of row table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch isTable {
        case 0:
            return self.listRandomWordByDays.count
        case 1:
             return self.listdataSearch.count
        case 2:
            return arrHindi.count
        default:
            print("looix")
            return self.listRandomWordByDays.count
        }
    
    }
    //-----------------set cell table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordTableViewCell", for: indexPath) as! WordTableViewCell
        cell.myButton.tag = indexPath.row
        switch isTable {
        case 0:
            cell.firstLabel.text = self.listRandomWordByDays[indexPath.row].English
            cell.secondLabel.text = self.listRandomWordByDays[indexPath.row].Hindi
            if self.listRandomWordByDays[indexPath.row].Fav == 0{
                cell.myButton.setImage(UIImage.init(named: "Heart"), for: .normal)
            }else{
                cell.myButton.setImage(UIImage.init(named: "icons8-heart-100"), for: .normal)
            }
            cell.myButton.addTarget(self, action: #selector(addtoFavotire), for: .touchUpInside)
        case 1:
            cell.firstLabel.text = self.listdataSearch[indexPath.row].English
            cell.secondLabel.text = self.listdataSearch[indexPath.row].Hindi
            if self.listdataSearch[indexPath.row].Fav == 0{
                cell.myButton.setImage(UIImage.init(named: "Heart"), for: .normal)
            }else{
                cell.myButton.setImage(UIImage.init(named: "icons8-heart-100"), for: .normal)
            }
            cell.myButton.addTarget(self, action: #selector(addtoFavotire), for: .touchUpInside)
        case 2:
            cell.firstLabel.text = self.arrHindi[indexPath.row]
            cell.secondLabel.text = ""
            cell.myButton.setImage(nil, for: .normal)
        default:
            print("looix cell")
        }
      
        
        return cell
    }
    //set height cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    //---------------set action click cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch isTable {
        case 0:
            arrHindi.removeAll()
            hindiString = self.listRandomWordByDays[indexPath.row].Hindi
           self.searchBar.text = self.listRandomWordByDays[indexPath.row].English
           self.arrHindi = hindiString.split(separator: ",").map({ (substring) in
               return String(substring)
           })
          
           
           self.isTable = 2
           self.tableView.reloadData()
            isUnwind1 = false
            isUnwind2 = false
            isVoice = false
        case 1:
            arrHindi.removeAll()
            hindiString = self.listdataSearch[indexPath.row].Hindi
           self.searchBar.text = self.listdataSearch[indexPath.row].English
            
           self.arrHindi = hindiString.split(separator: ",").map({ (substring) in
               return String(substring)
           })
          
           
           self.isTable = 2
           self.tableView.reloadData()
            isUnwind1 = true
            isUnwind2 = true
            isVoice = false
        case 2:
            self.searchBar.text = self.arrHindi[indexPath.row]
            isVoice = true;
            if(isUnwind1 == true){
                isUnwind2 = true
            }else{
                isUnwind2 = false
            }
            
        default:
            print("loi tai didSselect")
        }
    }
    //------------fuc them vao favorite
    @objc func addtoFavotire(sender:UIButton){
        let indexpath1 = IndexPath(row: sender.tag, section: 0)
        if isTable == 0{
            if self.listRandomWordByDays.count > indexpath1.row{
            if self.listRandomWordByDays[indexpath1.row].Fav == 0{
                self.listRandomWordByDays[indexpath1.row].Fav = 1
            }else{
                self.listRandomWordByDays[indexpath1.row].Fav = 0
            }
            SqliteService.shared.updateFaviroteDictionary(inputDic: self.listRandomWordByDays[indexpath1.row]){_ in
                self.tableView.reloadData()
            }
            }
        }else if isTable == 1{
            if self.listdataSearch.count > indexpath1.row{
                if self.listdataSearch[indexpath1.row].Fav == 0{
                    self.listdataSearch[indexpath1.row].Fav = 1
                }else{
                    self.listdataSearch[indexpath1.row].Fav = 0
                }
                SqliteService.shared.updateFaviroteDictionary(inputDic: self.listdataSearch[indexpath1.row]){_ in
                    self.tableView.reloadData()
                }
            }
        }else{
            print("loi tai add favorite")
            tableView.reloadData()
        }
       
    }
   
    //----------unwind to main
    @IBAction func unwindToMainViewController(unwindSegue: UIStoryboardSegue){
        
    }

    //------------action textdidchange
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listdataSearch = []
        self.unwindStr = searchText
        for x in listdataDictionary {
            if x.English.uppercased().contains(searchText.uppercased()){
                listdataSearch.append(x)
            }
        }
        
        if(searchText.count == 0){
            isTable = 0
            self.tableView.reloadData()
            self.myLabel.text = "Word of the day"
        }else{
            isTable = 1
            self.myLabel.text = ""
            self.tableView.reloadData()
        }
        
        self.tableView.reloadData()
        
    }
    
    // quay lai
    @IBAction func unwindString(_ sender: Any) {
        if(isUnwind2 == true){
            listdataSearch.removeAll()
            self.searchBar.text = unwindStr
            for x in listdataDictionary {
                if x.English.uppercased().contains(unwindStr.uppercased()){
                    listdataSearch.append(x)
                }
            }
            isTable = 1
            tableView.reloadData()
        }else{
           isTable = 0
            self.searchBar.text = ""
            tableView.reloadData()
        }
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
            print("end searching --> Close Keyboard")
            self.searchBar.endEditing(true)
        }
    
}


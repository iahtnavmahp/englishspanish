//
//  GreetingViewController.swift
//  englishspanish
//
//  Created by Pham Van Thai on 19/06/2021.
//

import AVFoundation
import UIKit

class GreetingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var listdataSpanish:[SpanishModel] = [SpanishModel]()
    var listdataSpanishGreeting:[SpanishModel] = [SpanishModel]()
    var listdataSpanishGeneral:[SpanishModel] = [SpanishModel]()
    var listdataSpanishNumbers:[SpanishModel] = [SpanishModel]()
    var listdataSpanishTime:[SpanishModel] = [SpanishModel]()
    var textAsSpeaking:String = ""
    var isAsSpeaking:Int = 0
    var player: AVAudioPlayer?
    @IBOutlet weak var labelBar: UILabel!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch isAsSpeaking {
        case 0:
            return listdataSpanishGeneral.count
        case 1:
            return listdataSpanishGreeting.count
        case 2:
            return listdataSpanishNumbers.count
        case 3:
            return listdataSpanishTime.count
        default:
            return listdataSpanishGeneral.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GreetingTableViewCell", for: indexPath) as! GreetingTableViewCell
        cell.greetingView.layer.cornerRadius = 15
        cell.btnFavorite.tag = indexPath.row
        switch isAsSpeaking {
        case 0:
            cell.labelOne.text = listdataSpanishGeneral[indexPath.row].english
            cell.labelTwo.text = ""
            if self.listdataSpanishGeneral[indexPath.row].favorite == 0{
                    cell.btnFavorite.setImage(UIImage.init(named: "Frame 19"), for: .normal)
                }else{
                    cell.btnFavorite.setImage(UIImage.init(named: "Frame 19-1"), for: .normal)
                }
            cell.btnFavorite.addTarget(self, action: #selector(addToFavotire), for: .touchUpInside)
        case 1:
            cell.labelOne.text = listdataSpanishGreeting[indexPath.row].english
            cell.labelTwo.text = ""
            if self.listdataSpanishGreeting[indexPath.row].favorite == 0{
                    cell.btnFavorite.setImage(UIImage.init(named: "Frame 19"), for: .normal)
                }else{
                    cell.btnFavorite.setImage(UIImage.init(named: "Frame 19-1"), for: .normal)
                }
            cell.btnFavorite.addTarget(self, action: #selector(addToFavotire), for: .touchUpInside)
        case 2:
            cell.labelOne.text = listdataSpanishNumbers[indexPath.row].english
            cell.labelTwo.text = ""
            if self.listdataSpanishNumbers[indexPath.row].favorite == 0{
                    cell.btnFavorite.setImage(UIImage.init(named: "Frame 19"), for: .normal)
                }else{
                    cell.btnFavorite.setImage(UIImage.init(named: "Frame 19-1"), for: .normal)
                }
            cell.btnFavorite.addTarget(self, action: #selector(addToFavotire), for: .touchUpInside)
        case 3:
            cell.labelOne.text = listdataSpanishTime[indexPath.row].english
            cell.labelTwo.text = ""
            if self.listdataSpanishTime[indexPath.row].favorite == 0{
                    cell.btnFavorite.setImage(UIImage.init(named: "Frame 19"), for: .normal)
                }else{
                    cell.btnFavorite.setImage(UIImage.init(named: "Frame 19-1"), for: .normal)
                }
            cell.btnFavorite.addTarget(self, action: #selector(addToFavotire), for: .touchUpInside)
        default:
            print("loi tai cell speaking")
        }
      

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch isAsSpeaking {
        case 0:
            playSound(fileName: listdataSpanishGeneral[indexPath.row].voice)
        case 1:
            playSound(fileName: listdataSpanishGreeting[indexPath.row].voice)
        case 2:
            playSound(fileName: listdataSpanishNumbers[indexPath.row].voice)
        case 3:
            playSound(fileName: listdataSpanishTime[indexPath.row].voice)
        default:
            print("loi tai click cell item")
        }
      
       
    }
   
    @IBOutlet weak var greetingTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "GreetingTableViewCell", bundle: nil)
        greetingTable.register(nib, forCellReuseIdentifier: "GreetingTableViewCell")
        greetingTable.dataSource = self
        greetingTable.delegate = self
        // Do any additional setup after loading the view.
        labelBar.text = textAsSpeaking
        
        SqliteServiceSpanish.shared1.getSpanishApp(){ response,error in
            if let response = response{
                self.listdataSpanish = response
                
            }
            
        }
        listdataSpanishGreeting = listdataSpanish.filter({$0.category_id == 1})
        listdataSpanishGeneral = listdataSpanish.filter({$0.category_id == 2})
        listdataSpanishNumbers = listdataSpanish.filter({$0.category_id == 3})
        listdataSpanishTime = listdataSpanish.filter({$0.category_id == 4})
    }
        
    @objc func addToFavotire(sender:UIButton){
        let indexpath1 = IndexPath(row: sender.tag, section: 0)
        switch isAsSpeaking {
        case 0:
            if self.listdataSpanishGeneral[indexpath1.row].favorite == 0{
                self.listdataSpanishGeneral[indexpath1.row].favorite = 1
            }else{
                self.listdataSpanishGeneral[indexpath1.row].favorite = 0
            }
            SqliteServiceSpanish.shared1.updateFaviroteSpanish(inputDic: self.listdataSpanishGeneral[indexpath1.row]){_ in
                self.greetingTable.reloadData()
            }
        case 1:
            if self.listdataSpanishGreeting[indexpath1.row].favorite == 0{
                self.listdataSpanishGreeting[indexpath1.row].favorite = 1
            }else{
                self.listdataSpanishGreeting[indexpath1.row].favorite = 0
            }
            SqliteServiceSpanish.shared1.updateFaviroteSpanish(inputDic: self.listdataSpanishGreeting[indexpath1.row]){_ in
                self.greetingTable.reloadData()
            }
        case 2:
            if self.listdataSpanishNumbers[indexpath1.row].favorite == 0{
                self.listdataSpanishNumbers[indexpath1.row].favorite = 1
            }else{
                self.listdataSpanishNumbers[indexpath1.row].favorite = 0
            }
            SqliteServiceSpanish.shared1.updateFaviroteSpanish(inputDic: self.listdataSpanishNumbers[indexpath1.row]){_ in
                self.greetingTable.reloadData()
            }
        case 3:
            if self.listdataSpanishTime[indexpath1.row].favorite == 0{
                self.listdataSpanishTime[indexpath1.row].favorite = 1
            }else{
                self.listdataSpanishTime[indexpath1.row].favorite = 0
            }
            SqliteServiceSpanish.shared1.updateFaviroteSpanish(inputDic: self.listdataSpanishTime[indexpath1.row]){_ in
                self.greetingTable.reloadData()
            }
        default:
            print("loi tai add favorite")
        }
        
    }
 
    
    func playSound(fileName:String){
        let urlString = Bundle.main.path(forResource: "raw1/\(fileName)_m", ofType: "mp3")
        do{
            
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else {
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            guard let player = player else {
                return
            }
            player.play()
        }catch{
            print("khong doc dc file mp3")
        }
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

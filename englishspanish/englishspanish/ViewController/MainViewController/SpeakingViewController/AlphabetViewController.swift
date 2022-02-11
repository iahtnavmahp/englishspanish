//
//  AlphabetViewController.swift
//  englishspanish
//
//  Created by Pham Van Thai on 19/06/2021.
//
import AVFoundation
import UIKit



struct ResponseData: Decodable {
    var hiragana: [Hiragana]
}
struct Hiragana : Decodable {
    var character: String
    var voice: String
    var write: String
    var sound: String
}

func loadJson(filename fileName: String) -> [Hiragana]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(ResponseData.self, from: data)
            return jsonData.hiragana
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

class AlphabetViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var alpabetData:[Hiragana] = []
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        26
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlphabetCollectionViewCell.identifier, for: indexPath) as! AlphabetCollectionViewCell
        cell.myView.layer.cornerRadius = 12
        cell.labelOne.text = alpabetData[indexPath.row].character
        cell.labelTwo.text = alpabetData[indexPath.row].voice
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let stringSound = alpabetData[indexPath.row].sound
        let mySubString = stringSound.prefix(10)
        print("cat cd : \(mySubString)")
        playSound(fileName: String(mySubString))
        print("ban vua nhan vaof \(indexPath)")
    }
    @IBOutlet weak var myCollectionView: UICollectionView!
    var player: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.register(AlphabetCollectionViewCell.nib(), forCellWithReuseIdentifier: AlphabetCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        myCollectionView.collectionViewLayout = layout
        layout.itemSize = CGSize(width: (view.frame.width + 10) / 4, height: 120)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumInteritemSpacing = 7
        layout.minimumLineSpacing = 7
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        //load file json
        alpabetData =   loadJson(filename: "alphabet/alphabet")!
        
    }
    
    func playSound(fileName:String){
        let urlString = Bundle.main.path(forResource: fileName, ofType: "mp3")
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

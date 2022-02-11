//
//  FavoriteViewController.swift
//  englishspanish
//
//  Created by Pham Van Thai on 09/05/2021.
//

import UIKit



class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MainTabBarControllerDelegate {
   
    
    var listdataDictionary:[DictionaryModel] = [DictionaryModel]()
    var listFavoriteDictionary:[DictionaryModel] = [DictionaryModel]()
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFavoriteDictionary.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        cell.firstLabel.text = listFavoriteDictionary[indexPath.row].English
        cell.secondLabel.text = listFavoriteDictionary[indexPath.row].Hindi
        cell.btnFavorite.tag = indexPath.row
        cell.btnFavorite.addTarget(self, action: #selector(deletetoFavotire), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    @objc func deletetoFavotire(sender:UIButton){
        
        let indexpath1 = IndexPath(row: sender.tag, section: 0)
        self.listFavoriteDictionary[indexpath1.row].Fav = 0
        
        SqliteService.shared.updateFaviroteDictionary(inputDic: self.listFavoriteDictionary[indexpath1.row]){_ in
            self.myTableView.reloadData()
        }
        self.listFavoriteDictionary.remove(at: indexpath1.row)
        myTableView.beginUpdates()
        myTableView.deleteRows(at: [indexpath1], with: .left)
        myTableView.endUpdates()
    }

    @IBOutlet weak var myTableView: UITableView!
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let nib = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: "FavoriteTableViewCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        
        
        //get data sqlite
//        SqliteService.shared.getDictionaryApp(){ response,error in
//            if let response = response{
//                self.listdataDictionary = response
//
//            }
//
//        }
        //filter favorite------------------
//
//        listFavoriteDictionary = listdataDictionary.filter({$0.Fav == 1})
//        //-----------------------------
//        refreshControl.attributedTitle = NSAttributedString(string: "Loading..")
//        refreshControl.addTarget(self, action: #selector(PullToRefresh(sender:)), for: .valueChanged)
//        myTableView.refreshControl = refreshControl
    }
    
//    @objc func PullToRefresh(sender: UIRefreshControl){
//        //get data sqlite
//        SqliteService.shared.getDictionaryApp(){ response,error in
//            if let response = response{
//                self.listdataDictionary = response
//                self.myTableView.reloadData()
//            }
//        }
//        //filter favorite------------------
//
//        listFavoriteDictionary = listdataDictionary.filter({$0.Fav == 1})
//        //-----------------------------
//        sender.endRefreshing()
//        myTableView.reloadData()
//    }
  func onTabSelected(isTheSame: Bool) {
        
        SqliteService.shared.getDictionaryApp(){ response,error in
            if let response = response{
                self.listdataDictionary = response
               
            }
        }
        listFavoriteDictionary = listdataDictionary.filter({$0.Fav == 1})
        
        print("mang co \(listFavoriteDictionary.count)")
   
    if let myTableview = myTableView{
        myTableview.reloadData()
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

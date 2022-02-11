//
//  SearchViewController.swift
//  englishspanish
//
//  Created by Pham Van Thai on 10/05/2021.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var listdataDictionary1:[DictionaryModel] = [DictionaryModel]()
    var listdataSearch:[DictionaryModel] = [DictionaryModel]()
    var finalTextField = ""
    var myTable :Bool = true
    var hindiString :String = ""
    var arrHindi : [String] = []
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mySearchTable: UITableView!
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchBar.delegate = self
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        mySearchTable.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
        mySearchTable.delegate = self
        mySearchTable.dataSource = self
        searchBar.text = finalTextField
        
        
        
        // Do any additional setup after loading the view.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        if(myTable == true){
            cell.myLabel.text = self.listdataSearch[indexPath.row].English
        }else{
            cell.myLabel.text = self.arrHindi[indexPath.row]
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
        self.mySearchTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(myTable == true){
            hindiString = self.listdataSearch[indexPath.row].Hindi
           self.searchBar.text = self.listdataSearch[indexPath.row].English
           self.arrHindi = hindiString.split(separator: ",").map({ (substring) in
               return String(substring)
           })
          
           
           self.myTable = false
           self.mySearchTable.reloadData()
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

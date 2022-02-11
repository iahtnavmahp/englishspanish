//
//  DictionaryModel.swift
//  englishspanish
//
//  Created by Pham Van Thai on 06/05/2021.
//

import UIKit
import Foundation

class DictionaryModel{
    var Id: Int = 0
    var English: String = ""
    var Hindi: String = ""
    var Fav: Int = 0
    
    
    init(Id:Int, English:String, Hindi: String, Fav: Int){
        self.Id = Id
        self.English = English
        self.Hindi = Hindi
        self.Fav = Fav
    }
    
}

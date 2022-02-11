//
//  SpanishModel.swift
//  englishspanish
//
//  Created by Pham Van Thai on 18/06/2021.
//

import Foundation
import UIKit
class SpanishModel{
    var _id: Int = 0
    var category_id: Int = 0
    var english: String = ""
    var spanish: String = ""
    var favorite: Int = 0
    var voice: String = ""
    var status: Int = 0
    
    
    
    init(_id:Int, category_id:Int, english: String, spanish: String,favorite: Int,voice: String ,status: Int){
        self._id = _id
        self.category_id = category_id
        self.english = english
        self.spanish = spanish
        self.favorite = favorite
        self.voice = voice
        self.status = status
    }
    
}

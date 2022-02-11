//
//  SqliteServiceSpanish.swift
//  englishspanish
//
//  Created by Pham Van Thai on 20/06/2021.
//
import UIKit
import SQLite

extension FileManager {
    func copyfileToUserDocumentSpanish(forResource name: String,
                                         ofType ext: String) throws -> String
    {
        if let bundlePath = Bundle.main.path(forResource: name, ofType: ext),
            let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                .userDomainMask,
                                true).first {
            let fileName = "\(name).\(ext)"
            let fullDestPath = URL(fileURLWithPath: destPath)
                                   .appendingPathComponent(fileName)
            let fullDestPathString = fullDestPath.path

            if !self.fileExists(atPath: fullDestPathString) {
                try self.copyItem(atPath: bundlePath, toPath: fullDestPathString)
                
            }
            return fullDestPathString
        }
        return ""
    }
}


class SqliteServiceSpanish:NSObject {
    var checkMax = 0
    var checkMin = 0
    
    var dataSpanishAll = [SpanishModel]()
    static let shared1: SqliteServiceSpanish = SqliteServiceSpanish()
    var DatabaseRoot:Connection?
    
    func loadInit(linkPath:String){
        do {
            let fileManager = FileManager.default
            let dbPath = try fileManager.copyfileToUserDocumentSpanish(forResource: "spanish", ofType: "sqlite")
            DatabaseRoot = try Connection ("\(dbPath)")
        }catch{
            DatabaseRoot = nil
            let nserror = error as NSError
            print("Cannot connect to Databace. Error is: \(nserror), \(nserror.userInfo)")
        }

    }
    
  
    //get data spanish ---------------------------------
    func getSpanishApp(closure: @escaping (_ response: [SpanishModel]?, _ error: Error?) -> Void) {
        let speak = Table("speak")
        let id1 = Expression<Int64>("_id")
        let category_id1 = Expression<Int64>("category_id")
        let english1 = Expression<String>("english")
        let spanish1 = Expression<String>("spanish")
        let favorite1 = Expression<Int64>("favorite")
        let voice1 = Expression<String>("voice")
        let status1 = Expression<Int64>("status")
        dataSpanishAll.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
               
                for user in try DatabaseRoot.prepare(speak) {
                    let idAdd:Int = Int(user[id1])
                    let category_idAdd:Int =  Int(user[category_id1])
                    let englishAdd:String = user[english1]
                    let spanishAdd:String = user[spanish1]
                    let favoriteAdd:Int = Int(user[favorite1])
                    let voiceAdd:String = user[voice1]
                    let statusAdd:Int = Int(user[status1])

                    let abc:SpanishModel = SpanishModel(_id: idAdd, category_id: category_idAdd, english: englishAdd, spanish: spanishAdd, favorite: favoriteAdd, voice: voiceAdd, status: statusAdd)
                    dataSpanishAll.append(abc)
                   
                }
            } catch  {
                print("Error")
            }
        }
        
        closure(dataSpanishAll, nil)
    }
    
    //--------------------update spanish
    func updateFaviroteSpanish(inputDic:SpanishModel,closure: @escaping (_ error: Error?) -> Void) {
        let speak = Table("speak")
        let Id1 = Expression<Int64>("_id")
        let Fav1 = Expression<Int64>("favorite")
        if let DatabaseRoot = DatabaseRoot{
            do{
                let alice = speak.filter(Id1 == Int64(inputDic._id))
                try DatabaseRoot.run(alice.update(Fav1 <- Int64(inputDic.favorite)))
            } catch  {
                print(error)
            }
            closure( nil)
        }
    
    }
   
}


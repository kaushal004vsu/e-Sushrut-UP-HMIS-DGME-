//
//  DateSlotDetails.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 15/02/23.
//

import Foundation
struct DateSlotDetails{
    var app_date = ""
    var t_app = ""
    var book_app = ""
    var avl_app = ""
  
    init(){
        
    }
    init(app_date:String,t_app:String,book_app:String,avl_app:String){
        self.app_date = app_date
        self.t_app = t_app
        self.book_app = book_app
        self.avl_app = avl_app

    }

    init(json:JSON){
       app_date = json["APP_DATE"].stringValue
        t_app = json["T_APP"].stringValue
        book_app = json["BOOK_APP"].stringValue
        avl_app = json["AVL_APP"].stringValue
             
    }
}

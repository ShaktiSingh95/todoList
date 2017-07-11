//
//  Task.swift
//  TheStrew
//
//  Created by Shakti Pratap Singh on 11/07/17.
//  Copyright © 2017 Shakti Pratap Singh. All rights reserved.
//

import Foundation
import RealmSwift

class Task:Object{
    dynamic var title = ""
    dynamic var date = Date(timeIntervalSince1970: 11222121)
    dynamic var priority = 0
//    init(title:String,date:Date,priority:Int) {
//        self.title=title
//        self.date=date
//        self.priority=priority
//    }
//    required init(){
//        super.init()
//    }
}

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
    dynamic var date : Date! = nil
    dynamic var priority = 0
}

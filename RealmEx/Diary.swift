//
//  Diary.swift
//  RealmEx
//
//  Created by 津吹陸 on 2019/05/19.
//  Copyright © 2019 津吹陸. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class Day: Object {
    @objc dynamic var jugyou_name = ""
    let dairys = List<Diary>()
    
    override static func primaryKey() -> String? {
        return "jugyou_name"
    }
}

class Diary: Object {
    @objc dynamic var id = 0
    @objc dynamic var url = ""
}


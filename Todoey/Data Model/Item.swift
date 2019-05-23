//
//  Item.swift
//  Todoey
//
//  Created by user on 20/05/2019.
//  Copyright © 2019 Oladipupo Oluwatbi. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
   @objc dynamic var title: String = ""
   @objc dynamic var marked: Bool = false
   @objc dynamic var dateCreated: Date?
   var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

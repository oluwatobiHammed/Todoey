//
//  Category.swift
//  Todoey
//
//  Created by user on 20/05/2019.
//  Copyright © 2019 Oladipupo Oluwatbi. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
  @objc dynamic var name: String = ""
  let items = List<Item>()
    
}

//
//  List.swift
//  coreDataExaple
//
//  Created by test on 4/19/15.
//  Copyright (c) 2015 jvm corp. All rights reserved.
//

import UIKit
import CoreData
@objc (Model)
class List: NSManagedObject {
    @NSManaged var item:String
    @NSManaged var quantity:String
    @NSManaged var info:String
}

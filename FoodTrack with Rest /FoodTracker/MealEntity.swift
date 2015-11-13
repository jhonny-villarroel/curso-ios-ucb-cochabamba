//
//  MealEntity.swift
//  FoodTracker
//
//  Created by jhonny on 11/12/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

// map entity to object

import CoreData
@objc(MealEntity)

class MealEntity:NSManagedObject{
    @NSManaged var name:String
    @NSManaged var photo:NSData
    @NSManaged var rating:Int32
    @NSManaged var identifier:Int16
    @NSManaged var latitud:Double
    @NSManaged var longitud:Double

}

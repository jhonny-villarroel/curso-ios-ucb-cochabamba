//
//  MealEntity.swift
//  FoodTracker
//
//  Created by jhonny on 11/12/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//
import CoreData
@objc(MealEntity)
class MealEntity:NSManagedObject{
    
    @NSManaged var name:String
    @NSManaged var photo:NSData
    @NSManaged var rating:Int16
    
}
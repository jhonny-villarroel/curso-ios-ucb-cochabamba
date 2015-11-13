//
//  Meal.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 5/26/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//  See LICENSE.txt for this sample’s licensing information.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class Meal:NSObject, MKAnnotation{
    // MARK: Properties
    
    var name: String
    var title: String?
    var photo: UIImage?
    var rating: Int
    var identifier: NSManagedObjectID?
     var coordinate: CLLocationCoordinate2D

    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int, coordinate: CLLocationCoordinate2D) {
        // Initialize stored properties.
        self.name = name
        self.title = name
        self.photo = photo
        self.rating = rating
        self.coordinate = coordinate
        super.init()
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
        
    }

}
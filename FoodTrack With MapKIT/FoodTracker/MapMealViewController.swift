//
//  MapViewController.swift
//  FoodTracker
//
//  Created by Jhonny Villarroel.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import CoreLocation
import AlecrimCoreData

class MapMealViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Properties
    
    let locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()
    var zoomRect = MKMapRectNull
    var dataContext:DataContext = DataContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        print("viewDidLoad Map View Controller")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        // Remove all pins
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove )
        
        // Init CoreLocation
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        // store max rectangle
        zoomRect = MKMapRectNull
        
        // get core data
        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
       // let context: NSManagedObjectContext = appDelegate.managedObjectContext
        //let request = NSFetchRequest(entityName: "MealEntity")
        //request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Add pins
      /*  var matches: NSArray
        do {
            matches = try context.executeFetchRequest(request)
            
            for object in matches {
                let mealObject: MealEntity = object as! MealEntity
                
                
                let meal = Meal(title: mealObject.name!, photo: mealObject.photo, rating: mealObject.rating as! Int, coordinate: CLLocationCoordinate2D(latitude: mealObject.latitude as! Double, longitude: mealObject.longitude as! Double))
                
                mapView.addAnnotation(meal!)
                
                let annotationPoint = MKMapPointForCoordinate(CLLocationCoordinate2D(latitude: mealObject.latitude as! Double, longitude: mealObject.longitude as! Double))
                let pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1)
                zoomRect = MKMapRectUnion(zoomRect, pointRect)
            }
            
        } catch {
            print("Unresolved error \(error)")
            abort()
        }*/
        
        for mealObject in dataContext.meals{
            //let mealObject: MealEntity = object as! MealEntity
            let coordinates =  CLLocationCoordinate2D(latitude: mealObject.latitud, longitude: mealObject.longitud)
            let image = UIImage(data: mealObject.photo)
            let meal = Meal(name: mealObject.name, photo: image, rating: Int(mealObject.rating), coordinate: coordinates)
            
            mapView.addAnnotation(meal!)
            
            let annotationPoint = MKMapPointForCoordinate((meal?.coordinate)!)
            let pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1)
            zoomRect = MKMapRectUnion(zoomRect, pointRect)
        }
        mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
    }
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
            
            if control == view.rightCalloutAccessoryView {
                performSegueWithIdentifier("detail", sender: self)
            }
    }
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        currentLocation = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let myLocationPointRect = MKMapRectMake(currentLocation.latitude, currentLocation.longitude, 0, 0)
        zoomRect = myLocationPointRect
        self.locationManager.stopUpdatingLocation()
    }
    
    
    // MARK: - Annotation View
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation)-> MKAnnotationView? {
        
        if !(annotation is Meal) {
            return nil
        }
        
        let object = annotation as! Meal
        let reuseId = "pin"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = true
            anView!.calloutOffset = CGPoint(x: -5, y: 5)
            //anView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
            
            let imageview = UIImageView(frame: CGRectMake(0, 0, 50, 50))
            imageview.image = object.photo
            imageview.sizeThatFits(CGSize(width: 50, height: 50))
            
            anView!.leftCalloutAccessoryView = imageview as UIView
            
        } else {
            anView!.annotation = annotation
        }
        
        return anView
    }
    
}


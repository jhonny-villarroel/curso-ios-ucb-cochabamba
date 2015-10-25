//
//  ViewController.swift
//  coreDataExaple
//
//  Created by test on 4/19/15.
//  Copyright (c) 2015 jvm corp. All rights reserved.
//

import UIKit
import CoreData


class ItemViewController: UIViewController {

    @IBOutlet weak var textFieldItem: UITextField!
    @IBOutlet weak var textFieldQuantity: UITextField!
    @IBOutlet weak var textFieldDescription: UITextField!
    var currentItem: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(currentItem)
        if(currentItem != nil){
            print (currentItem)
            textFieldQuantity.text = currentItem.valueForKey("quantity") as? String
            textFieldItem.text = currentItem.valueForKey("item") as? String
            textFieldDescription.text = currentItem.valueForKey("info") as? String
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressSave(sender: AnyObject) {
        print("Save")
    // Reference to our app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let contxt:NSManagedObjectContext = appDel.managedObjectContext!
        let en = NSEntityDescription.entityForName("List", inManagedObjectContext: contxt)
        if (currentItem != nil){
            currentItem.setValue(textFieldDescription.text, forKey: "info");
            currentItem.setValue(textFieldQuantity.text, forKey: "quantity");
            currentItem.setValue(textFieldItem.text, forKey: "item");
        } else {
            let newItem = List(entity:en!, insertIntoManagedObjectContext:contxt)
            newItem.item = textFieldItem.text!
            newItem.quantity = textFieldQuantity.text!
            newItem.info = textFieldDescription.text!
            print(newItem)
            
        }
        
        do {
            try contxt.save()
        } catch _ {
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    // reference Moc
    // Create instance of pur data model and initialize
        // Map our properties
        // save our context
        // navigation back to root
        
    }

}


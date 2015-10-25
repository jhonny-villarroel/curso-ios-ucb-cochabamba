//
//  ListTableViewController.swift
//  coreDataExaple
//
//  Created by test on 4/19/15.
//  Copyright (c) 2015 jvm corp. All rights reserved.
//

import UIKit
import CoreData
class ListTableViewController: UITableViewController {

    var myList:Array<AnyObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
           print("Load...ddd.")
        //var id = UIDevice.currentDevice().identifierForVendor.UUIDString
        //print(id)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidAppear(animated: Bool) {
        print("Load....")
        // Dispose of any resources that can be recreated.
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest (entityName: "List")
        
        myList = try! context.executeFetchRequest(freq)
        print("Load....")
        tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Variable..")
        if (segue.identifier == "update")
        {   print("NEXT...")
            let seletedIndex = self.tableView.indexPathForSelectedRow?.row
            let selectedItem: NSManagedObject = myList[seletedIndex!] as! NSManagedObject
            let desti = segue.destinationViewController as! ItemViewController
            desti.currentItem = selectedItem
        }
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellID: NSString = "Cell"
        //var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID as String) as UITableViewCell!	
        //cell.textLabel!.text = "test"
        
        var data:NSManagedObject = myList[indexPath.row] as! NSManagedObject
        cell.textLabel?.text = data.valueForKey("item") as? String
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let contxt:NSManagedObjectContext = appDel.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete{
            var deletedItem:NSManagedObject = myList[indexPath.row] as! NSManagedObject
            contxt.deleteObject(deletedItem)
            myList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
        }
        
        do {
            try contxt.save()
        } catch _ {
        };
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

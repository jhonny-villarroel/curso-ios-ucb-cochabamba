//
//  ViewController.swift
//  podsExample
//
//  Created by jbian on 10/23/15.
//  Copyright © 2015 jbian. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        testHttp()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func testHttp(){
        do {
            let opt = try HTTP.GET("http://web-5d8083e0-76f4-436d-8f2c-eb007feec292.runnablecodesnippets.com")
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
               // print("data is: \(response.data)")
                let json = JSON(data: response.data)//access the response of the data with response.data
               print( "teh json is \(json[0])")
                //If json is .Dictionary
                for (key,subJson):(String, JSON) in json {
                    //Do something you want
                    //print("the json in the key \(key)")
                    print("sub JSON \(subJson)")
                    let raitin = subJson["rating"]
                    let name = subJson["name"]
                    let photo = subJson["photo"]
                    
                    print(" raiting :\(raitin)")
                    print(" name :\(name)")
                    print(" photo :\(photo)")
                    
                }
            
             
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


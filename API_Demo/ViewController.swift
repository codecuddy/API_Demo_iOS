//
//  ViewController.swift
//  API_Demo
//
//  Created by Charlie Cuddy on 1/16/18.
//  Copyright © 2018 Charlie Cuddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=7f86fa8088d3a888525a01077377200c")!
        
        let task = URLSession.shared.dataTask(with: url)  {(data, response, error) in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                if let urlContent = data {
                    
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                        print(jsonResult)
                        print(jsonResult["name"])
                        
                        if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                            
                            print(description)
                            
                        }

                    } catch {
                        
                        print("JSon Processing Failed")
                        
                    }
                    
                }
                
            }
            
        }
        
            task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  API_Demo
//
//  Created by Charlie Cuddy on 1/16/18.
//  Copyright © 2018 Charlie Cuddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var cityTextField: UITextField!
   
    @IBAction func submit(_ sender: Any) {
        
        if let url = URL(string: "http://openweathermap.org/data/2.5/weather?q=" + cityTextField.text!.replacingOccurrences(of: " ", with: "%20") + "&appid=b6907d289e10d714a6e88b30761fae22") {
        
            let task = URLSession.shared.dataTask(with: url)  {(data, response, error) in
                
                if error != nil {
                    
                    print(error as Any)
                    
                } else {
                    
                    if let urlContent = data {
                        
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            
                            print(jsonResult)
                            print(jsonResult["name"])
                            
                            if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                        
                                DispatchQueue.main.sync {
                                    
                                    self.resultLabel.text = description.capitalized
                                    
                                }
                                
                            }
                            
                        } catch {
                            
                            print("JSon Processing Failed")
                            
                        }
                        
                    }
                    
                }
                
            }
            
            task.resume()
    
        } else {
            
            cityTextField.text = "Couldn't find weather for that city. Please try another city."
            
        }
    
    }
        
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


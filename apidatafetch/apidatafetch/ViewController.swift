//
//  ViewController.swift
//  apidatafetch
//
//  Created by Ishmam Islam on 16/7/18.
//  Copyright © 2018 Ishmam Islam. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request("http://umairjihan.com:8081/artists",
                          method: .get, parameters: nil)
            .responseJSON{ (response) in
                print(response.result.value!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  AppLogs
//
//  Created by Chetu on 04/12/18.
//  Copyright © 2018 Chetu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    print(Logger.sharedInstance.deviceDetails)
    Logger.sharedInstance.DebugLogs(className: "ViewController", methodName: "viewDidLoad", debugLogs: "view did load logs here")
    let savedLogs = Logger.sharedInstance.readLogFromDisk()
    print(savedLogs)
    
    print(savedLogs)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}


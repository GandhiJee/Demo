//
//  LogTimeManager.swift
//  AppLogs
//
//  Created by Chetu on 05/12/18.
//  Copyright © 2018 Chetu. All rights reserved.
//

import Foundation

open class LogTimeManager {
  
  static let sharedInstance = LogTimeManager()
  private init() {}
  
  var sendLogTimeDurationMinutes: TimeInterval = 30.0
  var timer: Timer?
 
  func startTimer() {
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: sendLogTimeDurationMinutes, repeats: true) { _ in
      
        let logs = Logger.sharedInstance.readLogFromDisk()
        LogServiceClient.sendLogsToServer(logs, onSuccess: { status in
          switch status {
          case  true:
            Logger.sharedInstance.deleteLogsFromDisk()
          case false:
            break
          }
      }, onError: {error in
        print(error)
      })
    }
  }
  
  func stopTimer() {
    timer?.invalidate()
  }
}

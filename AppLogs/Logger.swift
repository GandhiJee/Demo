//
//  Logger.swift
//  AppLogs
//
//  Created by Chetu on 04/12/18.
//  Copyright © 2018 Chetu. All rights reserved.
//

import Foundation
import UIKit


open class Logger {
  
    static let sharedInstance = Logger()
  
    private init () {}
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    static var dateFormatter: DateFormatter {
      let formatter = DateFormatter()
      formatter.dateFormat = dateFormat
      formatter.locale = Locale.current
      formatter.timeZone = TimeZone.current
      return formatter
   }
  
   let deviceDetails = "\(UIDevice.current.name)\t" + "\(UIDevice.current.model)\t" + "\(UIDevice.current.systemName)\t" + "\(UIDevice.current.systemVersion)"
  
   func DebugLogs(className: String,methodName: String, debugLogs: String) {
      let detailedLogs = "\(Date().toString())\t \(deviceDetails)\t \(className)\t \(methodName)\t \(debugLogs)\n"
      writeToFile(message: detailedLogs)
   }
  
   func writeToFile(message: String) {
      let fileURL = getDocumentsDirectory().appendingPathComponent("Logs.txt")
      let fileManager = FileManager.default
        if fileManager.fileExists(atPath: fileURL.path) {
            let existingLogs = readLogFromDisk()
            let logsToWrite = "\(existingLogs)\t\n \(message)"
            do {
              try logsToWrite.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            } catch {
              print("Some error occur")
            }
        } else {
            do {
                try message.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("Some error occur")
            }
        }
    
  }
  
  func readLogFromDisk() -> String {
      let fileURL = getDocumentsDirectory().appendingPathComponent("Logs.txt")
        do {
            let logs = try String(contentsOf: fileURL, encoding: .utf8)
            return logs
        } catch {
            print("Some error occur")
            return ""
        }
  }
  
  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  func deleteLogsFromDisk() {
    
      let fileURL = getDocumentsDirectory().appendingPathComponent("Logs.txt")
      let fileManager = FileManager.default
      if fileManager.fileExists(atPath: fileURL.path) {
        do {
          try fileManager.removeItem(atPath: fileURL.path)
        } catch {
          print("Error while removing file at path \(fileURL.path)")
        }
      } else { print("No file exists") }
    }
}

extension Date {
  func toString() -> String {
    return Logger.dateFormatter.string(from: self as Date)
  }
}

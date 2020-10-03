//
//  LogServiceClient.swift
//  AppLogs
//
//  Created by Chetu on 05/12/18.
//  Copyright © 2018 Chetu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

open class LogServiceClient {
  
  static var endPoint: String?
  static var userAccessToken: String?
  
  public static func sendLogsToServer(_ logs: String, onSuccess: @escaping(_ status: Bool) -> Void, onError: @escaping(_ error: Error) -> Void) {
      
      
      let headers: [String: String] = [
        "Authorization": "Bearer \(userAccessToken ?? "")"
      ]
      
    let params: [String: String] = ["logs": logs]
      
      Alamofire.request(endPoint ?? "", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
        //.validate(statusCode: 200...201)
        .responseJSON { response in
          let statusCode = response.response?.statusCode ?? 200
          let json = JSON(response.result.value ?? "{}")
          let status = json["status"].boolValue
          switch statusCode {
          case 200...209:
            onSuccess(status)
          default:
            onError( response.error!)
          }
        }
        .responseString { response in
         print("Got \(response.response?.statusCode ?? 0) - \(response)")
      }
    }
  
}

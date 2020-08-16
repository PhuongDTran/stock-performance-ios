//
//  ViewController.swift
//  stock-performance-ios
//
//  Created by Phuong Tran on 7/27/20.
//  Copyright © 2020 Phuong Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        fetch();
//        fetch2();
        fetch3();
    }
    func fetch3() {

        // prepare json data
        let json: [String: Any] = ["symbols" : "[\"AMZN\"]", "start_date" : "2019-06-01", "end_date": "2020-07-01"]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        print(jsonData as )
        // create post request
        let url = URL(string: "http://localhost:4567/stock/server/data/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }

        task.resume()
    }
    func fetch2() {
        // server endpoint
        let endpoint = "http://localhost:4567/stock/server/data/"
        
        guard let endpointUrl = URL(string: endpoint) else {
            return
        }
        
        //Make JSON to send to send to server
        var json = [String:Any]()
        
//        ["symbols" : "[\"AMZN\"]", "start_date" : "2019-06-01", "end_date": "2020-07-01"]
        json["symbols"] = "[\"AMZN\"]"
        json["start_date"] = "2019-06-01"
        json["end_date"] = "2020-07-01"
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            
            var request = URLRequest(url: endpointUrl)
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                print(data as Any)
                print(response as Any)
                print(error as Any)
               if let data = data {
                              do {
                               let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                  print(json)
                              } catch {
                                  print(error)
                              }
                          }
            }.resume()
            
        }catch{
        }
    }
    func fetch() {
        let Url = String(format: "http://localhost:4567/stock/server/data/")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = ["symbols" : "[\"AMZN\"]", "start_date" : "2019-06-01", "end_date": "2020-07-01"]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
         let session = URLSession.shared
          session.dataTask(with: request) { (data, response, error) in
             print(data as Any)
             print(response as Any)
             print(error as Any)
            if let data = data {
                           do {
                            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                               print(json)
                           } catch {
                               print(error)
                           }
                       }
         }.resume()
     }

}


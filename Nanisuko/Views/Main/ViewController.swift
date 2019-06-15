//
//  ViewController.swift
//  Nanisuko
//
//  Created by 福田走 on 2019/06/15.
//  Copyright © 2019 福田走. All rights reserved.
//

import Foundation
import UIKit
import Material

class ViewController: UIViewController {

    @IBOutlet weak var text: TextField!

    @IBAction func submit(_ sender: RaisedButton) {

        let urlString = "https://script.google.com/macros/s/AKfycbxn19k9qbp1D1ZyPGUsZWfAv6ryKR7b7xDXphh6-JcfVClmmH4F/exec"
        let request = NSMutableURLRequest(url: URL(string: urlString)!)

        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        
        
        let formatter = ISO8601DateFormatter()
        let d = formatter.string(from: Date())

        
        let params: [String: Any] = [
            "timestamp": d,
            "time" : d,
            "data" : text.text ?? ""
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)

            let task: URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                let resultData = String(data: data!, encoding: .utf8)!
                print("result:\(resultData)")
                print("response:\(response)")
            })
            task.resume()
        } catch {
            print("Error:\(error)")
            return
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


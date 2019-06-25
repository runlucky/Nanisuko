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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBOutlet weak var expireLabel: UILabel!

    @IBOutlet weak var text: TextField!

    @IBAction func submit(_ sender: RaisedButton) {
        self.view.endEditing(true)

        sender.title = "sending..."
        sender.isEnabled = false

        let urlString = "https://script.google.com/macros/s/AKfycbxn19k9qbp1D1ZyPGUsZWfAv6ryKR7b7xDXphh6-JcfVClmmH4F/exec"
        let request = NSMutableURLRequest(url: URL(string: urlString)!)

        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let params: [String: Any?] = [
            "timestamp": Date().toString(.ISO8601),
            "time" : text.text?.toDate()?.toString(.ISO8601) ?? nil,
            "data" : text.text ?? ""
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)

            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                let resultData = String(data: data!, encoding: .utf8)!
                print("result:\(resultData)")
                print("response:\(response)")
                DispatchQueue.main.async {
                    self.showToast("sent.")
                    sender.isEnabled = true
                    sender.title = "sent!"
                    self.text.text = ""
                    
                }
  

            })
            task.resume()
        } catch {
            print("Error:\(error)")
            return
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        expireLabel.text = "expire: " + (Bundle.main.ExpirationDate?.toString(.shortDate) ?? "")
        // Do any additional setup after loading the view.
    }
}


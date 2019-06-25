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
import Hydra

class ViewController: UIViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBOutlet weak var expire: UILabel!
    @IBOutlet weak var text: TextField!

    @IBAction func submit(_ sender: RaisedButton) {
        self.view.endEditing(true)

        sender.title = "sending..."
        sender.isEnabled = false

        let params: [String: Any?] = [
            "timestamp": Date().toString(.ISO8601),
            "time" : text.text?.toDate()?.toString(.ISO8601) ?? nil,
            "data" : text.text ?? ""
        ]

        async { _ -> Void in
            _ = try await(Requester.shared.request(params: params))

            DispatchQueue.main.async {
                self.text.text = ""
                sender.isEnabled = true
                sender.title = "sent!"
            }

            return ()
        }.catch {_ in
            sender.title = "send"
            sender.isEnabled = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        expire.text = "expire: " + (Bundle.main.ExpirationDate?.toString(.shortDate) ?? "")
        // Do any additional setup after loading the view.
    }
}


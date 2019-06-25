//
//  Requester.swift
//  Nanisuko
//
//  Created by H5266 on 2019/06/25.
//  Copyright © 2019 福田走. All rights reserved.
//

import Foundation
import Hydra

public class Requester {
    private let url = "https://script.google.com/macros/s/AKfycbxn19k9qbp1D1ZyPGUsZWfAv6ryKR7b7xDXphh6-JcfVClmmH4F/exec"

    public static let shared: Requester = Requester()

    private init() {}

    private var urlRequest: URLRequest? {
        guard let url = URL(string: url) else { return nil }

        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request as URLRequest
    }
    
    public func request(params: [String: Any?]) -> Promise<URLResponse> {
        return Promise<URLResponse> { resolve, reject, _ in
            guard var request = self.urlRequest,
                  let body = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) else {
                reject(PromiseError.rejected)
                return
            }

            request.httpBody = body

            URLSession.shared.dataTask(with: request){ (data, response, error) -> Void in
                guard let response = response else {
                    reject(PromiseError.attemptsFailed)
                    return
                }
                resolve(response)
            }.resume()
        }
    }

}

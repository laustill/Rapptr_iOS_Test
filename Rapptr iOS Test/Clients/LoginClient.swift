//
//  LoginClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 *
*/

class LoginClient {
    
    var session: URLSession?
    
    func login(email: String, password: String, completion: @escaping (String, String) -> Void, error errorHandler: @escaping (String?) -> Void) {
        var components = URLComponents(string: "http://dev.rapptrlabs.com/Tests/scripts/login.php")!
        let parameters = ["email": email, "password": password]
        components.queryItems = parameters.map { (key, value) in URLQueryItem(name: key, value: value)}
        let request = URLRequest(url: components.url!)
        let startDate = Date()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let data = data
            do{
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(responseData.self, from: data!)
                print("Decoded Data: " + "\(decodedData)")
                let codeData = decodedData.code
                let timeSince = String(format: "%.2f", Date().timeIntervalSince(startDate) * 1000)
                completion(codeData, timeSince)
            }
            catch{
                let timeSince = String(format: "%.2f", Date().timeIntervalSince(startDate) * 1000)
                completion("Error", timeSince )
            }
        }
    task.resume()
    }
}


struct responseData: Codable{
    let code: String
    let message: String
}

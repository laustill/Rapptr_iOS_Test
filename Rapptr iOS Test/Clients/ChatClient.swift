//
//  ChatClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 *
 */

class ChatClient {
    
    var session: URLSession?
    var url = URL(string: "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php")
    
    func fetchChatData(completion: @escaping ([Message]) -> Void, error errorHandler: @escaping (String?) -> Void) {
        guard let url = url else {return}
        let session = URLSession.shared
        let data = session.dataTask(with: url) { data, response, error in
            if error == nil && data != nil{
                let decoder = JSONDecoder()
                do{
                    guard let data = data else {return}
                    let decodedData = try decoder.decode(phpData.self, from: data)
                    var messageArray: [Message] = []
                    for x in 0...decodedData.data.count - 1{
                        var buildMessage = Message(testName: decodedData.data[x].name, withTestMessage: decodedData.data[x].message)
                        buildMessage.userID = Int(decodedData.data[x].user_id) ?? 000
                        buildMessage.avatarURL = URL(string: decodedData.data[x].avatar_url)
                        messageArray.append(buildMessage)
                    }
                    completion(messageArray)
                }
                catch{
                    print("Error in parsing data")
                }
            }
        }
        data.resume()
    }
}

struct phpData: Codable{
    let data: [nestedData]
}
struct nestedData: Codable {
    public let user_id: String
    public let name: String
    public let avatar_url: String
    public let message: String
}

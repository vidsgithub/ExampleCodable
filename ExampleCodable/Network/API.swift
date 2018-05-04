//
//  API.swift
//  ExampleCodable
//
//  Created by Shingade on 5/3/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit

let gitHUB_URL = "https://api.github.com/users/"
class API: NSObject {
    //Singleton
    static let shared:API = API()
    
    let urlSession:URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        return session
    }()
    
    func getGitHubData(userName:String, completionHandler: @escaping (MyGitHub) -> Void) {
        guard let url = URL.init(string: gitHUB_URL + userName) else { return }
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let jsonDecoder = JSONDecoder.init()
                // call decoder to convert data into model object
                let gitData = try jsonDecoder.decode(MyGitHub.self, from: data)
                completionHandler(gitData)
            } catch {
                print("Error in fetching github url")
            }
        }
        task.resume()
    }
}

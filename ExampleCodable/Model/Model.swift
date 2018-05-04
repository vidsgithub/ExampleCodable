//
//  Model.swift
//  ExampleCodable
//
//  Created by Shingade on 5/3/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit

struct MyGitHub: Codable {
    
    let name: String?
    let location: String?
    let followers: Int?
    let avatar_url: URL?
    let public_repo: Int?

}

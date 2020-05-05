//
//  Count.swift
//  Media Finder
//
//  Created by Ahmed Kamal on 4/2/20.
//  Copyright © 2020 Intake 4. All rights reserved.
//

import Foundation

struct Count: Decodable {
    var resultCount: Int
    var results: [MyMovie]
}

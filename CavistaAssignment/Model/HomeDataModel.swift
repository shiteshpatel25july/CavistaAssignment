//
//  HomeDataModel.swift
//  CavistaAssignment
//
//  Created by Shitesh Patel on 15/08/20.
//  Copyright © 2020 Shitesh Patel. All rights reserved.
//

import Foundation
 
// MARK: - HomeDataModel

struct HomeDataModel: Decodable {
    let id: String
    let type: DataType
    let date: String?
    let data: String?
}

enum DataType: String, Decodable {
    case image = "image"
    case text = "text"
    case other = "other"
}

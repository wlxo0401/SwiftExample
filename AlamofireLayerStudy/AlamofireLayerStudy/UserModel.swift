//
//  UserModel.swift
//  AlamofireLayerStudy
//
//  Created by 김지태 on 2023/02/13.
//

import Foundation

struct User: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let image: URL
}

struct Article: Codable {
    let id: Int
    let title: String
    let image: URL
    let author : String
    let categories: [Category]
    let datePublished: Date
    let body: String?
    let publisher: String?
    let url: URL?
}


struct Category: Codable {
    let id: Int
    let name: String
    let parentID: Int?
}

extension Category {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case parentID = "parent_id"
    }
}

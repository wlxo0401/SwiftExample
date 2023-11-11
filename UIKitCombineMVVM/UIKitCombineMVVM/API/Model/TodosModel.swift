//
//  TodosModel.swift
//  UIKitCombineMVVM
//
//  Created by 김지태 on 11/10/23.
//

import Foundation

struct TodosModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

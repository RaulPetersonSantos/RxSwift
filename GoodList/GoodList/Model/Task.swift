//
//  Task.swift
//  GoodList
//
//  Created by raul.santos on 19/01/23.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}

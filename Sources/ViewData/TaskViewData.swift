//
//  TaskViewData.swift
//
//
//  Created by Work on 25/6/24.
//

import SwiftUI

struct TaskViewData: Identifiable {
    let id = UUID.init()
    let name: String
    let start: Int
    let end: Int
}

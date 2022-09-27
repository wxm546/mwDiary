//
//  Tab.swift
//  mmDiary
//
//  Created by wxm on 2022/9/23.
//

import Foundation
import SwiftUI

// MARK: - tab model
struct TabItem:Identifiable{
    var id = UUID()
    var name: String
    var icon: String
    var tab:Tab
}

enum Tab : String{
    case diary
    case journals
    case favs
    case setting
}

var tabItems = [
    TabItem(name: "Diary", icon: "doc",tab: .diary),
    TabItem(name: "Journals", icon: "calendar",tab: .journals),
    TabItem(name: "Favs", icon: "heart",tab: .favs),
    TabItem(name: "Setting", icon: "ellipsis",tab: .setting)
]



//
//  Themes.swift
//  mwDiary
//
//  Created by wxm on 2022/9/27.
//

import Foundation
import SwiftUI


//MARK: - Theme
struct Theme : Identifiable{
    var id = UUID()
    var name:String {
        switch self.theme {
        case .Automatic:
            return "Automatic"
        case .Light:
            return "Light"
        case .Dark:
            return "Dark"
        case .rainbow:
            return "Rainbow"
        }
    }
    var icon:String {
        switch self.theme {
        case .Automatic:
            return "sparkles"
        case .Light:
            return "sun.max"
        case .Dark:
            return "moon"
        case .rainbow:
            return "rainbow"
        }
    }

    var theme:ThemeType
        
}


enum ThemeType:String{
    case Automatic
    case Light
    case Dark
    case rainbow
    
    var SystemColorScheme:ColorScheme? {
        get {
            switch self {
            case .Automatic:
                return nil
            case .Light:
                return ColorScheme.light
            case .Dark:
                return ColorScheme.dark
            case .rainbow:
                return ColorScheme.light
            }
        }
    }
    
    //基于系统哪个主题
    
    var fontColor:Color {
        get {
            switch self {
            case .Automatic:
                return Color(.label)
            case .Light:
                return Color(.label)
            case .Dark:
                return Color(.label)
            case .rainbow:
                return Color(.label)
            }
        }
    }
    
    //systemBackground secondarySystemBackground tertiarySystemBackground
    //https://sarunw.com/posts/dark-color-cheat-sheet/
    var backColor:Color {
        get {
            switch self {
            case .Automatic:
                return Color(.systemBackground)
            case .Light:
                return Color(.systemBackground)
            case .Dark:
                return Color(.systemBackground)
            case .rainbow:
                return Color(.systemBlue)
            }
        }
    }
    var backColor2:Color {
        get {
            switch self {
            case .Automatic:
                return Color(.secondarySystemBackground)
            case .Light:
                return Color(.secondarySystemBackground)
            case .Dark:
                return Color(.secondarySystemBackground)
            case .rainbow:
                return Color(.systemBlue)
            }
        }
    }

    
}




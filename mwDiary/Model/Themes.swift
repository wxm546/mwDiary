//
//  Themes.swift
//  mwDiary
//
//  Created by wxm on 2022/9/27.
//

import Foundation
import SwiftUI


struct Themes : Identifiable{
    var id = UUID()
    
    var name:String
    //基于系统哪个主题
    var SystemColorScheme:String
    
    var fontColor:UIColor
    var backColor:UIColor
    var backColor2:UIColor
    
    
    var theme:Theme
    
}


enum Theme:String{
    case Automatic
    case Light
    case Dark
    case rainbow
}



struct Themetest:Identifiable {
    var id = UUID()
    var name : String
    var icon : String


}

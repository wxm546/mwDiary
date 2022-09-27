//
//  BlankButtonStyle.swift
//  mwDiary
//
//  Created by wxm on 2022/9/27.
//

import SwiftUI


struct BlankButtonStyle:ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

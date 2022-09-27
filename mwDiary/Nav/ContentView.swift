//
//  ContentView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/14.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("appTheme") var appTheme:String = "Automatic"
//    @State var selectView:Tab = .setting
    @AppStorage("selectView") var selectView:Tab = .setting
    private func selectTheme(selectTheme:String?) -> ColorScheme?{
        if selectTheme == "Light" {
            return ColorScheme.light
        }else if selectTheme == "Dark" {
            return ColorScheme.dark
        }else {
            return nil
        }
    }
    
    
    var body: some View {
        ZStack(alignment: .bottom){
            Group{
                switch selectView{
                case .diary:
                    DiaryView()
                case .journals:
                    JournalView()
                case .favs:
                    FavView()
                case .setting:
                    SettingView()
                }
            }
//            .zIndex(0)
            .preferredColorScheme(selectTheme(selectTheme: appTheme))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            MyTabView(selectView: $selectView).zIndex(1)
            MyTabView()
//                .zIndex(1)
        }
    }
}









// MARK: - 预览
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DiaryViewMode())
    }
}



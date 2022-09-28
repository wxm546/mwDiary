//
//  ContentView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/14.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("appTheme") var appTheme:ThemeType = .Automatic
    @State var selectTab:Tab = .diary
    @State var selectView:Tab = .diary

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
            .preferredColorScheme(appTheme.SystemColorScheme)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            MyTabView(selectTab: $selectTab,selectView: $selectView)
            
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



//
//  SettingView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/16.
//

import SwiftUI
//import SwiftUIX

struct SettingView: View {
    
    @EnvironmentObject var diaryvm:DiaryViewMode
    @AppStorage("isICloud") var isICloud:Bool = true
    @State var hasScrolled = true
    
    var body: some View {
        NavigationView {
            List{
                Group{
                    
                    Section{
                        NavigationLink {
                            AppearanceView()
                        } label: {
                            Label("Appearance", systemImage: "paintpalette")
                        }
                        
                        Button {
                            diaryvm.exportAllToCSV()
                        } label: {
                            Label("Export Data", systemImage: "doc")
                        }

                        
                        
                        Toggle(isOn: $isICloud) {
                            Label("iCloud Sync", systemImage: "icloud")
                        }
                        
                    } header:{
                        Text("General")
                    }
                    
                    //TODO: - 内购
//                    Section("PREMIUM"){
//                        Label("Premium Features", systemImage: "crown")
//                    }
                    
                    
                    Section("OTHERS"){
                        Link(destination: URL(string: "mailto:wxm546@outlook.com")!, label: {Label("Contact", systemImage: "link")})
                        //TODO: - 分享和评论 内购
//                        Link(destination: URL(string: "http://itunes.apple.com/cn/app/id6443545292")!, label: {Label("Rate App", systemImage: "star")})
//                        //http://itunes.apple.com/cn/app/id6443545292
//                        //https://itunes.apple.com/cn/app/id6443545292
//                        Label("Share", systemImage: "square.and.arrow.up")
//                        Label("Buy me a Coffee", systemImage: "cup.and.saucer")
                    }
                }
            }//list
            .symbolVariant(.circle.fill)
            .tint(.primary)
            .listStyle(.plain)
            .headerProminence(.standard)
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
            
        }//nav
        .navigationViewStyle(StackNavigationViewStyle())
    }//body
}






struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}




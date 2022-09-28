//
//  SettingView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/16.
//

import SwiftUI
//import SwiftUIX

struct SettingView: View {
    
    @AppStorage("appTheme") var appTheme:ThemeType = .Automatic
    @AppStorage("heartColor") var appHeartColor:HeartColorType = .yellow
    @EnvironmentObject var diaryvm:DiaryViewMode
    
    @AppStorage("isICloud") var isICloud:Bool = true
    
    @State var hasScrolled = true
    
    var body: some View {
        NavigationView {
            List{
                    Section{
                        NavigationLink {
                            AppearanceView()
                        } label: {
                            Label("Appearance", systemImage: "paintpalette.fill")
                                .font(.headline)
                                .frame(height: 40)
                                
                        }
                        
                        Button {
                            diaryvm.exportAllToCSV()
                        } label: {
                            Label("Export Data", systemImage: "doc.circle.fill")
                                .font(.headline)
                                .frame(height: 40)
                        }
                        
                        Toggle(isOn: $isICloud) {
                            Label("iCloud Sync", systemImage: "icloud.circle.fill")
                                .font(.headline)
                                .frame(height: 40)
                        }.tint(appHeartColor.SwiftUiColor)
                        
                    } header:{
                        Text("GENERAL")
                    }
                    
                    //TODO: - 内购
//                    Section{
//                        Label("Premium Features", systemImage: "crown")
//                    } header:{
//                    Text("PREMIUM")
//                }
                    
                    
                    Section{
                        Link(destination: URL(string: "mailto:wxm546@outlook.com")!, label: {Label("Contact", systemImage: "link.circle.fill")})
                            .font(.headline)
                            .frame(height: 40)
                        //TODO: - 分享和评论 内购
//                        Link(destination: URL(string: "http://itunes.apple.com/cn/app/id6443545292")!, label: {Label("Rate App", systemImage: "star")})
//                        //http://itunes.apple.com/cn/app/id6443545292
//                        //https://itunes.apple.com/cn/app/id6443545292
//                        Label("Share", systemImage: "square.and.arrow.up")
//                        Label("Buy me a Coffee", systemImage: "cup.and.saucer")
                    } header:{
                        Text("OTHERS")
                    }
                
            }//list
            
            .tint(Color(.label))
            .labelStyle(.titleAndIcon)
            .listStyle(.plain)
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
            
        }//nav
        .navigationViewStyle(StackNavigationViewStyle())
    }//body
}






struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .preferredColorScheme(.dark)
    }
}




//
//  SettingView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/16.
//

import SwiftUI

struct SettingView: View {

    @AppStorage("appTheme") var appTheme:ThemeType = .Automatic
    @AppStorage("heartColor") var appHeartColor:HeartColorType = .yellow
    @EnvironmentObject var diaryvm:DiaryViewMode

    @AppStorage("isICloud") var isICloud:Bool = true
    
    @AppStorage("defaultTitle") var defaultTitle = "My daily mood"
    @AppStorage("defaultBody") var defaultBody = ""
    @State var editTitle:String = ""
    @State var editText:String = ""
    
    
    private var naviTitle = "Setting"
    
    var body: some View {
        NavigationView {
            List{
                    Section{
                        NavigationLink {
                            AppearanceView()
                        } label: {
                            Label("Appearance", systemImage: "paintpalette.fill")
                                .font(.subheadline)
                                .frame(height: 33)
                                
                        }
                        
                        Button {
                            diaryvm.exportAllToCSV()
                        } label: {
                            Label("Export Data", systemImage: "doc.circle.fill")
                                .font(.subheadline)
                                .frame(height: 33)
                        }
                       
                        //TODO: - icloud
//                        Toggle(isOn: $isICloud) {
//                            Label("iCloud Sync", systemImage: "icloud.circle.fill")
//                                .font(.subheadline)
//                                .frame(height: 33)
//                        }
//                        .tint(appHeartColor.SwiftUiColor)
                   
                        
                    } header:{
                        Text("GENERAL")
                    }
                    
                    //TODO: - 内购
//                    Section{
//                        Label("Premium Features", systemImage: "crown")
//                    } header:{
//                    Text("PREMIUM")
//                }
                
                
                //MARK: - defaultTitle
                Section {
                    NavigationLink {
                        DefaultDiaryView(editTitle: $editTitle, editText: $editText)
                    } label: {
                        Label("Default Diary", systemImage: "doc.text")
                            .font(.subheadline)
                            .frame(height: 33)
//                            .onTapGesture {
//                                
//                            }
                    }.onAppear {
                        if defaultTitle != "My daily mood" && defaultTitle != "" {
                            editTitle = defaultTitle
                        }
                        if defaultBody != "" {
                            editText = defaultBody
                        }
                    }
                    
                    
                    
                } header: {
                    Text("TEMPLATE")
                }

                    
                    Section{
                        Link(destination: URL(string: "mailto:wxm546@outlook.com")!, label: {Label("Contact", systemImage: "link.circle.fill")})
                            .font(.subheadline)
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
            .navigationTitle(naviTitle)
            .navigationBarTitleDisplayMode(.inline)
            
        }//nav
        .navigationViewStyle(StackNavigationViewStyle())
    }//body
}






struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
//            .preferredColorScheme(.dark)
    }
}




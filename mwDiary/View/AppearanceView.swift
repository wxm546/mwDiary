//
//  AppearanceView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/23.
//

import SwiftUI



struct AppearanceListCell: View {
    var title:String = "title"
    var description:String = "Description"
    var body: some View {
        VStack(alignment:.leading){
            Text("smallTitle").font(.headline)
            Text("Title style above every page").font(.footnote).foregroundColor(.gray)
        }
    }
}




struct AppearanceView: View {
    @EnvironmentObject var diaryvm:DiaryViewMode
    @AppStorage("smallTitle") var smallTitle:Bool = false
    @AppStorage("appTheme") var appTheme:String = "Automatic"
    @AppStorage("heartColor") var heartColor:String = "yellow"

    private let icons:[AppIcon] = [
        AppIcon(iconName: nil, logoName: "icon 1"),
        AppIcon(iconName: "AppIcon 2", logoName: "icon 2"),
        AppIcon(iconName: "AppIcon 3", logoName: "icon 3"),
        AppIcon(iconName: "AppIcon 4", logoName: "icon 4"),
        AppIcon(iconName: "AppIcon 5", logoName: "icon 5"),
    ]
    
    private let themes:[Themetest] = [
        Themetest(name: "Automatic", icon: "sparkles"),
        Themetest(name: "Light", icon: "sun.max"),
        Themetest(name: "Dark", icon: "moon")
    ]
    
    private let heartColors:[UIColor] = [.systemYellow,.systemRed,.systemBlue]
    
    var body: some View {
        NavigationView {
            List{
                //TODO: - change ColorTheme
                Section ("THEMES"){
                    VStack(alignment:.leading,spacing: 0){
                        ForEach(themes) { theme in
                            HStack{
                                Label(theme.name, systemImage: theme.icon)
                                    .font(.headline)
                                    .padding(.leading)
                                Spacer()
                                Image(systemName: "checkmark")
                                    .opacity(appTheme==theme.name ? 1 : 0)
                                    .padding(.trailing)
                            }
                            .frame(height: 50)
                            .background(Color(.systemBackground))
                            .overlay(content: {
                                Color.clear
                            })
//                            .cornerRadius(20)
                            .onTapGesture {
                                withAnimation(.easeOut) {
                                    appTheme = theme.name
                                }
                                
                                
                            }
                            
                        }
                    }
                    
                }
                
                //MARK: - change icon
                Section("APP ICON"){
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(icons){ icon in
                                Button {
                                    UIApplication.shared.setAlternateIconName(icon.iconName)
                                } label: {
                                    Image(icon.logoName)
                                        .resizable()
                                        .frame(width: 88, height: 88)
                                        .cornerRadius(20)
                                        .padding()
                                }
                            }
                        }
                    }
                }
                //MARK: - change favcolor
                Section("Heart Color"){
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(heartColors,id:\.self){ color in
                                Button {
                                
                                } label: {
                                    Image(systemName: "heart")
                                        .font(.title)
                                        .foregroundColor(Color(color))
                                        .symbolVariant(.fill)
                                        .frame(width: 44, height: 44)
                                        .cornerRadius(20)
                                        .padding()
                                }
                            }
                        }
                    }
                }
                
                //TODO: - change LAYOUT
                Section("LAYOUT"){
                    VStack(spacing:18){
                        DiaryCardLayOutView()
                        DiaryCardLayOutView()
                        DiaryCardLayOutView()
                    }
                }
                
                
                
                Section("MORE"){
                    //TODO: - change font
                    
                    //TODO: - new jour title
                    
                    //MARK: - change small title
                    Toggle(isOn: $smallTitle) {
                        AppearanceListCell(title: "Small Title", description: "Title style above every page")
                    }
                }
                
                
                
                
            }//list
//            .scrollIndicators(.hidden)
            //            .padding(.horizontal,50)
            //            .symbolVariant(.circle.fill)
            .tint(.primary)
            .listStyle(.plain)
            .headerProminence(.standard)
            
            .navigationTitle("Appearance")
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .bottom, content: {Color.clear.frame(height: 50)})
        }//nav
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct AppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceView()
            .environmentObject(DiaryViewMode())
    }
}




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
    
    @AppStorage("appTheme") var appTheme:ThemeType = .Automatic
    @AppStorage("heartColor") var appHeartColor:HeartColorType = .yellow
    @AppStorage("smallTitle") var smallTitle:Bool = false
    @AppStorage("cardLayout") var cardLayout:Int = 2
    @EnvironmentObject var diaryvm:DiaryViewMode
    
    private var navTitle = "Appearance"
    
    private let icons:[AppIcon] = [
        AppIcon(iconName: nil, logoName: "icon 1"),
        AppIcon(iconName: "AppIcon 2", logoName: "icon 2"),
        AppIcon(iconName: "AppIcon 3", logoName: "icon 3"),
        AppIcon(iconName: "AppIcon 4", logoName: "icon 4"),
        AppIcon(iconName: "AppIcon 5", logoName: "icon 5"),
    ]
    
    private let themes:[Theme] = [
        Theme(theme: .Automatic),
        Theme(theme: .Light),
        Theme(theme: .Dark),
        //        Theme(theme: .rainbow)
    ]
    
    @State var isplay = false
    private let heartColors:[HeartColor] = [HeartColor(color: .primary),
                                            HeartColor(color: .yellow),
                                            HeartColor(color: .red),
                                            HeartColor(color: .blue),
                                            HeartColor(color: .cyan)
    ]
    
    
    
    
    
    
    
    var body: some View {
        
        NavigationView {
            
            List{
                Group{
                    //MARK: - change ColorTheme
                    Section {
                        VStack(alignment:.leading,spacing: 0){
                            ForEach(themes) { theme in
                                HStack{
                                    Label(theme.name, systemImage: theme.icon)
                                        .labelStyle(.titleAndIcon)
                                        .font(.headline)
                                        .padding(.leading)
                                    Spacer()
                                    Image(systemName: "checkmark")
                                        .opacity(appTheme == theme.theme ? 1 : 0)
                                        .padding(.trailing)
                                }
                                .frame(height: 50)
                                //用于点击
                                .background(appTheme.backColor)
                                .onTapGesture {
                                    withAnimation(.easeOut) {
                                        appTheme = theme.theme
                                    }
                                }
                            }
                        }
                    } header: {
                        Text("THEMES")
                    }
                    //.listRowBackground(appTheme.backColor)
                    
                    //MARK: - change icon
                    Section{
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
                    } header: {
                        Text("APP ICON")
                    }
                    //.listRowBackground(appTheme.backColor)
                    
                    //MARK: - change favcolor
                    Section{
                        ScrollView(.horizontal){
                            HStack(spacing:0){
                                ForEach(heartColors){ item in
                                    Button {
                                        appHeartColor = item.color
                                    } label: {
                                        Image(systemName: "heart.fill")
                                            .font(.title)
                                            .foregroundColor(item.color.SwiftUiColor)
                                            .frame(width: 45, height: 45)
                                            .cornerRadius(20)
                                            .padding(.vertical)
                                            .padding(.horizontal,15)
                                            .overlay{
                                                if item.color == appHeartColor {
                                                    item.color.SwiftUiColor
                                                        .frame(height:5)
                                                        .frame(maxHeight:.infinity,alignment:.bottom)
                                                }
                                            }
                                    }
                                }
                            }
                        }
                    } header: {
                        Text("Favourite Color")
                    }
                    //                    .listRowBackground(appTheme.backColor)
                    
                }
                    
                Group{
                    
                    //MARK: - change LAYOUT
                    Section{
                        VStack(spacing:18){
                            ForEach(1...6, id: \.self) { i in
                                DiaryCardLayOutView(e_isFav:i == cardLayout ? true : false,layoutIndex:i)
                                    .onTapGesture {
                                        cardLayout = i
                                    }
                            }
                        }
                    } header: {
                        Text("LAYOUT")
                    }
                    //                    .listRowBackground(appTheme.backColor)
                    
                    Section{
                        //TODO: - change font
                        
                        
                        //MARK: - change small title
                        Toggle(isOn: $smallTitle) {
                            AppearanceListCell(title: "Small Title", description: "Title style above every page")
                        }
                        .tint(appHeartColor.SwiftUiColor)
                    } header: {
                        Text("MORE")
                    }
                    //                    .listRowBackground(appTheme.backColor)
                    VStack{}.frame(height:45)
                    //                        .listRowBackground(appTheme.backColor)
                }
            }//list
            .listStyle(.plain)
            .background(appTheme.backColor)
            
            .navigationTitle(navTitle)
            .navigationBarTitleDisplayMode(.inline)
        }//nav
        .navigationViewStyle(StackNavigationViewStyle())
    }
}




struct AppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceView()
            .environmentObject(DiaryViewMode())
        //            .preferredColorScheme(.dark)
    }
}


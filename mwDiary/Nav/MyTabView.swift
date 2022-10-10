//
//  MyTabView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/16.
//

import SwiftUI



// MARK: - MyTabView
struct MyTabView: View {
    
    @AppStorage("heartColor") var appHeartColor:HeartColorType = .yellow
    
    @Binding var selectTab:Tab
    @Binding var selectView:Tab
    
    
    var body: some View {
//        kakeTabBar
        quantumultTabBar
        
    }
    
//    quantumultTabItems
    var quantumultTabBar:some View{
        HStack(spacing: 0){
            
            ForEach(quantumultTabItems){ item in
                Button {
                    withAnimation (.easeInOut(duration: 0.21)){
                        selectTab = item.tab
                    }
                    selectView = item.tab
                } label: {
                    Image(systemName: item.icon)
                        .font(.title2)
                        .frame(width: 45,height: 45,alignment: .center)
                        .foregroundColor(selectTab == item.tab ? appHeartColor.SwiftUiColor : .gray)
                        .opacity(selectTab == item.tab ? 1 : 0.5)
                        .symbolVariant(selectTab == item.tab ? .fill : .none)
                        .padding(8)
                }
            }
            
        }
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(radius: 20)
        .padding()
        .frame(maxHeight: .infinity,alignment: .bottom)
        .ignoresSafeArea(.all)
    }
    
    
    var kakeTabBar:some View {
        HStack(spacing: 0){
            Spacer()
            ForEach(kakeTabItems){ item in
                Button (action: {
                    withAnimation (.easeInOut(duration: 0.21)){
                        selectTab = item.tab
                    }
                    selectView = item.tab
                } , label: {
                    HStack(spacing:8){
                        Image(systemName: item.icon)
                        //符号变体
                            .symbolVariant(.circle.fill)
                            .font(.title3)
                            .frame(width: 45,height: 25,alignment:.trailing)
                        if selectTab == item.tab{
                            Text(item.name)
                                .font(.footnote)
                                .lineLimit(1)
                        }
                    }
                    .padding(.trailing,25)
                    .background(content: {
                        Capsule().fill(Color(selectTab == item.tab ? .gray : .systemBackground).opacity(0.3))
                            .frame(height: 40)
                    })
                })
                .buttonStyle(BlankButtonStyle())
                .frame(height: 68,alignment: .top)
                .foregroundColor(selectTab==item.tab ? .primary : .secondary)
                .buttonStyle(.plain)
                Spacer()
            }//ForEach
        }//HStack
        .padding(.top,10)
        //背景板颜色
        .background(.background)
        //放置最底下
        .frame(maxHeight: .infinity,alignment: .bottom)
        .ignoresSafeArea(.all)
    }
    
}



// MARK: - 预览
struct MyTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView(selectTab: .constant(.diary),selectView: .constant(.diary))
    }
}

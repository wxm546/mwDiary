//
//  MyTabView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/16.
//

import SwiftUI



// MARK: - MyTabView
struct MyTabView: View {
    
//    @AppStorage("selectTab") var selectTab:Tab = .diary
//    @State var selectTab2:Tab = .diary
//    @AppStorage("selectView") var selectView:Tab = .diary
    
//    @Binding var selectView:Tab
    @AppStorage("selectView") var selectView:Tab = .setting
    @State var a:CGFloat = 0
    var body: some View {
        HStack(spacing: 0){
            Spacer()
            ForEach(tabItems){ item in
                
                Button (action: {
//                    withAnimation (.easeInOut(duration: 0.21)){
                        selectView = item.tab
//                    }
//                    selectTab = item.tab
                } , label: {
                    HStack(spacing:8){
                        Image(systemName: item.icon)
                        //符号变体
                            .symbolVariant(.circle.fill)
                            .font(.title3)
                            .frame(width: 45,height: 25,alignment:.trailing)
                        if selectView == item.tab{
                            Text(item.name)
                                .font(.footnote)
                                .lineLimit(1)
//                                .frame(maxWidth:selectView == item.tab ? .infinity:.none )
                        }
                    }
                    //                    .frame(maxWidth:.infinity,alignment:.leading)
                    .padding(.trailing,25)
                    .background(content: {
                        Capsule().fill(Color(selectView == item.tab ? .gray : .systemBackground).opacity(0.3))
                            .frame(height: 40)
                    })
                })
                
                
                .buttonStyle(MyTabButtonStyle())
                //button
                //      .padding(.top,14)
                //button在Hstack中位置
                .frame(height: 68,alignment: .top)
                .foregroundColor(selectView==item.tab ? .primary : .secondary)
                .buttonStyle(.plain)
                Spacer()
                
            }
            //ForEach
            
        }//HStack
        //        .background {
        //            GeometryReader { proxy in
        ////                Text("\(proxy.size.width)")
        //                a = proxy.size.width
        //            }
        //        }
        //.frame(height: 50)
        .padding(.top,10)
        //背景板颜色
        //.background(.ultraThinMaterial)
        .background(.background)
        //放置最底下
        .frame(maxHeight: .infinity,alignment: .bottom)
        .ignoresSafeArea()
        
    }
}



struct MyTabButtonStyle:ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}




// MARK: - 预览

//struct MyTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyTabView()
//    }
//}

//
//  ToastAlertView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/26.
//

import SwiftUI

struct ToastAlertView:View {
    var icon:String = "heart"
    var text:String = "Add to Favs"
    var body: some View{
        VStack(spacing:10){
            Image(systemName:icon)
                .font(.title)
            Text(text).font(.subheadline)
        }
        .foregroundColor(.black)
        .padding(.horizontal,60)
        .padding(.vertical,28)
        .background(Material.ultraThinMaterial)
        .cornerRadius(15)
    }
}


struct ToastAlertView_Previews: PreviewProvider {
    static var previews: some View {
        ToastAlertView()
    }
}

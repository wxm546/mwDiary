//
//  testView.swift
//  mwDiary
//
//  Created by wxm on 2022/9/27.
//

import SwiftUI

struct testView: View {
    @State var a:Int = 1
    var body: some View {
        VStack{
            MyLottieVIew(animationName: "hi", isPlaying: .constant(true))
                .frame(width: 100)
                .border(.red)
        }
    }
}


struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}

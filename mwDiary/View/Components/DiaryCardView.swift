//
//  NoteCard.swift
//  ProgressBar
//
//  Created by wxm on 2022/9/6.
//

import SwiftUI

struct DiaryCardView: View {
    
    @ObservedObject var diary:DiaryEntity
    
    
    
    var body: some View {
            cardView
//                .offset(x:offsetx)
//                .background(
//                    swipBackGround
//                )
//                .gesture(offsetSwipe)

    }
    
    
    var cardView : some View {
        HStack(spacing:10){
            caleView
            textView
        }
    }
    
    
    var caleView : some View {
        VStack(spacing: 0){
            Text(diary.create_date?.getDayInWeek() ?? "hello")
                .foregroundColor(Color(.systemBackground))
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top,6)
                .padding(.bottom,3)
            Text(
                dateFormatterMMdd.string(from: diary.create_date ?? Date())
            )
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity)
            .padding(.vertical,6)
            .background {Color(.systemBackground)}
            .overlay(
                RoundedRectangle(cornerRadius: 11)
                    .stroke(Color.primary,lineWidth: 3)
            )
            .cornerRadius(10)
        }
        .background(content: {
            Color.primary
        })
        .frame(width: 48)
        .cornerRadius(12)
    }
    
    
    var textView : some View {
        HStack(spacing:4){
            VStack(alignment:.leading, spacing:8){
                Text(diary.title ?? "i am title")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text(diary.body ?? "i am body")
                    .font(.footnote)
                    .lineLimit(1)
                    .padding(.bottom,3)
            }.frame(maxWidth: .infinity,alignment: .leading)
            
            VStack(alignment:.trailing, spacing:8){
                Image(systemName: "heart")
                    .font(.headline)
                    .symbolVariant(.fill)
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .foregroundColor(diary.is_fav ? Color(.systemYellow): .clear)
                Text(dateFormatterHHmm.string(from: diary.modified_date ?? Date()))
                    .font(.footnote)
                    .frame(maxWidth: .infinity,alignment: .trailing)
            }.frame(width: 48,alignment: .trailing)
        }
        .padding(10)
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .frame(maxWidth:.infinity , alignment: .leading)
        .shadow(color:.gray,radius: 2,x: 4,y:5)
        .overlay(
            RoundedRectangle(cornerRadius: 10,style: .continuous)
                .stroke(.primary,lineWidth: 1.5)
        )
    }
    
    
    
    
    
    
    //MARK: - custom swipe
//    @State var offsetx:CGFloat = 0
//    @GestureState var isDragging = false
//    var swipBackGround:some View{
//        ZStack{
//            HStack {
//                Spacer().frame(width: 300)
//                Color(.black)
//                    .cornerRadius(10)
//            }
//            HStack {
//                Spacer().frame(width: 100)
//                Color(hex: "454159" )
//                    .cornerRadius(10)
//                Spacer().frame(width: 50)
//            }
//
//            HStack {
//                Spacer()
//                Button {
//                    withAnimation {
//                        offsetx = 0
//                    }
//                } label: {
//                    Image(systemName: "suit.heart")
//                        .font(.headline)
//                        .foregroundColor(Color.white)
//                        .frame(width: 50)
//                }
//                Button {
//                        offsetx = 0
//
//
//                } label: {
//                    Image(systemName: "xmark")
//                        .font(.headline)
//                        .foregroundColor(Color.white)
//                        .frame(width: 50)
//                }
//            }
//            Text("嘿嘿～").foregroundColor(Color.white)
//        }
//    }
//    var offsetSwipe : some Gesture {
//        DragGesture()
//            .updating($isDragging, body: { value, state, _ in
//                state = true
//                if value.translation.width < 0
//                    && isDragging
//                    && -value.translation.width < 250
//                {
////                    DispatchQueue.main.async {
//                        offsetx  = value.translation.width
////                    }
//                }
//            })
//            .onEnded { value in
//                withAnimation {
//                    if -value.translation.width >= 90
//                    {
//                        offsetx = -110
//                    }else {
//                        self.offsetx = 0
//                    }
//                }
//            }
//    }

    
    

}
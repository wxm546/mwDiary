//
//  ShowLayoutView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/23.
//

import SwiftUI

struct DiaryCardLayOutView: View {
    //MARK: - Appearance
    @AppStorage("heartColor") var appHeartColor:HeartColorType = .yellow
    //    @ObservedObject var diary:DiaryEntity
    
    var e_create_date:Date = Date()
    var e_modified_date:Date = Date()
    var e_title:String = "i am title"
    var e_body:String = "i am body"
    var e_isFav:Bool = true
    

    var body: some View {
        cardView2
    }
    
    
    var cardView1 : some View {
        HStack(spacing:10){
            caleView1
            textView1
        }
    }
    var caleView1 : some View {
        VStack(spacing: 0){
            Text(e_create_date.getDayInWeek() )
                .foregroundColor(Color(.systemBackground))
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top,6)
                .padding(.bottom,3)
            Text(
                dateFormatterMMdd.string(from: e_create_date )
            )
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity)
            .padding(.vertical,6)
            .background (Color(.systemBackground))
            .overlay(
                RoundedRectangle(cornerRadius: 11)
                    .stroke(Color.primary,lineWidth: 3)
            )
            .cornerRadius(10)
        }
        .background(
            Color.primary
        )
        .frame(width: 48)
        .cornerRadius(12)
    }
    var textView1 : some View {
        HStack(spacing:4){
            VStack(alignment:.leading, spacing:8){
                Text(e_title )
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text(e_body )
                    .font(.footnote)
                    .lineLimit(1)
                    .padding(.bottom,3)
            }.frame(maxWidth: .infinity,alignment: .leading)
            
            VStack(alignment:.trailing, spacing:8){
                Image(systemName: "heart")
                    .font(.headline)
                    .symbolVariant(.fill)
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .foregroundColor(e_isFav ? appHeartColor.SwiftUiColor : .clear)
                Text(dateFormatterHHmm.string(from: e_modified_date ))
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
    
    
    
    var cardView2 : some View {
        HStack(spacing:10){
            caleView2
            textView2
        }
    }
    var caleView2 : some View {
        VStack(spacing: 0){
            Text(e_create_date.getDayInWeek() )
                .foregroundColor(Color(.systemBackground))
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top,6)
                .padding(.bottom,3)
            Text(
                dateFormatterMMdd.string(from: e_create_date )
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
    var textView2 : some View {
        HStack(spacing:4){
            VStack(alignment:.leading, spacing:8){
                Text(e_title )
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text(e_body )
                    .font(.footnote)
                    .lineLimit(1)
                    .padding(.bottom,3)
            }.frame(maxWidth: .infinity,alignment: .leading)
            
            VStack(alignment:.trailing, spacing:8){
                Image(systemName: "heart")
                    .font(.headline)
                    .symbolVariant(.fill)
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .foregroundColor(e_isFav ? appHeartColor.SwiftUiColor: .clear)
                Text(dateFormatterHHmm.string(from: e_modified_date ))
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
    
    
    
    
    
    
    
    
    

}


struct DiaryCardLayOutView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryCardLayOutView()
            .previewLayout(.sizeThatFits)
    }
}

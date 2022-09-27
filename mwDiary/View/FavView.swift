//
//  FavsView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/16.
//

import SwiftUI

struct FavView: View {
    
    //MARK: - State
    @State var editTitle = ""
    @State var editText = ""
    @State var showEditView = false
    @State var showDeleteAlert:Bool = false
    private var navTitle = dateFormatterMMMM.string(from: Date())
    @State var isShowFavToastAlert = false
    @State var isShowDeleteToastAlert = false
    //MARK: - Search
    @State var searchStr = ""
    //MARK: - ViewModel
    @EnvironmentObject var diaryvm:DiaryViewMode
    @State var selectEntity:DiaryEntity? = nil
    //MARK: - filteredDiary
    var filteredDiary: [DiaryEntity] {
        if searchStr.isEmpty {
            return diaryvm.savedEntities.filter{ $0.is_fav == true }
        } else {
            return diaryvm.savedEntities.filter { $0.is_fav == true && $0.title!.localizedCaseInsensitiveContains(searchStr) }
        }
    }
    
    
    var body: some View {
        ZStack{
            NavigationView {
                DiaryListView(editTitle: $editTitle,
                              editText: $editText,
                              showEditView: $showEditView,
                              showDeleteAlert: $showDeleteAlert,
                              selectEntity: $selectEntity,
                              isShowFavToastAlert: $isShowFavToastAlert,
                              isShowDeleteToastAlert: $isShowDeleteToastAlert,
                              filteredDiary: filteredDiary)
                //MARK: -搜索
                    .searchable(text: $searchStr)
                //TODO: - 搜索后保留结果 取消focus
                //                .onSubmit(of: .search) { print("hello") }
                //MARK: - listStyle NavTitle
                    .navigationTitle(navTitle)
            }//Nav
            .navigationViewStyle(StackNavigationViewStyle())
            
            //MARK: - toolBar
            Button {

            } label: {
                VStack{
                    Image(systemName: "heart.fill").font(filteredDiary==[] ? .title:.headline)
                }
            }
            .frame(width: 50, height: 50)
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment:filteredDiary==[] ? .center : .topTrailing)
            .padding(.trailing,10)
            .tint(.primary)
            
            //MARK: - 弹窗
            if isShowFavToastAlert {
                if selectEntity?.is_fav == true {
                    ToastAlertView(icon: "heart",text: "Add to Favs").zIndex(1)
                } else {
                    ToastAlertView(icon: "heart.slash",text: "Remove from Favs").zIndex(1)
                }
            }
            if isShowDeleteToastAlert {
                if selectEntity?.is_fav == true {
                    ToastAlertView(icon: "",text: "Diary deleted").zIndex(1)
                }
            }
        }
    }
}


struct FavsView_Previews: PreviewProvider {
    static var previews: some View {
        FavView()
            .environmentObject(DiaryViewMode())
    }
}



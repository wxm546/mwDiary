//
//  FavsView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/16.
//

import SwiftUI

struct FavView: View {
    //MARK: - Appearance
    @AppStorage("heartColor") var appHeartColor:HeartColorType = .yellow
    //MARK: - State
    @State var editTitle = ""
    @State var editText = ""
    @State var showEditView = false
    @State var showDeleteAlert:Bool = false
    private var navTitle = "Favourates"
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
    //MARK: - search
    @State var isSearchingValue = false
    //MARK: - lottie
    @State var isShowAnime = false
    
    
    var body: some View {
        ZStack{
            NavigationView {
                VStack{
                DiaryListView(editTitle: $editTitle,
                              editText: $editText,
                              showEditView: $showEditView,
                              showDeleteAlert: $showDeleteAlert,
                              selectEntity: $selectEntity,
                              isShowFavToastAlert: $isShowFavToastAlert,
                              isShowDeleteToastAlert: $isShowDeleteToastAlert,
                              filteredDiary: filteredDiary)
                .onPreferenceChange(IsSearchingPreferenceKey.self) { value in
                    withAnimation (.easeInOut){
                        self.isSearchingValue = value
                    }
                }
                Rectangle().foregroundColor(.clear).frame(height: 40)
            }
                //MARK: -搜索
                    .searchable(text: $searchStr,prompt: "")
                //TODO: - 搜索后保留结果 取消focus
                //                .onSubmit(of: .search) { print("hello") }
                //MARK: - listStyle NavTitle
                    .navigationTitle(navTitle)
            }//Nav
            .navigationViewStyle(StackNavigationViewStyle())
            
            //MARK: - toolBar
            if !isSearchingValue {
                Button {
                    isShowAnime = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3,execute: {
                        withAnimation (.easeInOut(duration: 0.2)){
                            isShowAnime = false
                        }
                    })
                } label: {
                    VStack{
                        Image(systemName: "heart.fill")
                            .font(filteredDiary==[] ? .title:.headline)
                    }
                }
                .frame(width: 50, height: 50)
                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment:filteredDiary==[] ? .center : .topTrailing)
                .padding(.trailing,10)
                .tint(appHeartColor.SwiftUiColor)
            }
            //MARK: - Lottie
            if isShowAnime {
                MyLottieVIew(animationName: "heart5", isPlaying: $isShowAnime)
                    .frame(width: 80,height: 80)
                    .offset(x:-5)
            }
            
            //MARK: - 弹窗
            if isShowFavToastAlert {
                if selectEntity?.is_fav == true {
                    ToastAlertView(icon: "heart",text: "Add to Favs").zIndex(1)
                } else {
                    ToastAlertView(icon: "heart.slash",text: "Remove from Favs").zIndex(1)
                }
            }
            
            if isShowDeleteToastAlert {
                    ToastAlertView(icon: "",text: "Diary deleted").zIndex(1)
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



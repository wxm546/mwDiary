//
//  DiaryListView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/23.
//

import SwiftUI


struct DiaryListView: View {
    
    @Environment(\.isSearching) var isSearching
    @AppStorage("smallTitle") var smallTitle:Bool = false
    @EnvironmentObject var diaryvm:DiaryViewMode
    @Binding var editTitle:String
    @Binding var editText:String
    @Binding var showEditView:Bool
    @Binding var showDeleteAlert:Bool
    @Binding var selectEntity:DiaryEntity?
    @Binding var isShowFavToastAlert:Bool
    @Binding var isShowDeleteToastAlert:Bool
    //    @State private var timer: Timer?
    
    var filteredDiary : [DiaryEntity]
    
    var body: some View{
        
        //        ScrollView{
        //        GeometryReader{ geo in
        List{
            //                Text("\(geo.size.height)-\(geo.size.width)-\(geo.safeAreaInsets.top)")
            //                Text("\(geo.frame)-\(geo.safeAreaInsets.bottom)")
            ForEach(filteredDiary) { entity in
                
                DiaryCardView(diary: entity)
                //                        Text("\(geo2.size.height)")
                
                //MARK: - 设置边距
                    .padding(.vertical,10)
                    .padding(.horizontal,18)
                //MARK: - 点击编辑
                    .onTapGesture {
                        showEditView = true
                        selectEntity = entity
                        editTitle = entity.title ?? ""
                        editText = entity.body ?? ""
                    }
                //MARK: - 滑动菜单
                    .swipeActions(edge: .trailing, allowsFullSwipe: false, content: {
                        
                        //MARK: "delete"
                        Button {
                            selectEntity = entity
                            showDeleteAlert.toggle()
                        } label: {
                            Image(systemName: "xmark").font(.title)
                        }
                        .tint(Color(.systemRed))
                        
                        //MARK: "Fav"
                        Button {
                            selectEntity = entity
                            diaryvm.favToggle(entity: entity)
                            withAnimation (.easeInOut(duration: 0.2)){
                                isShowFavToastAlert = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5,execute: {
                                withAnimation (.easeInOut(duration: 0.2)){
                                    self.isShowFavToastAlert = false
                                }
                            })
                            selectEntity = nil
                        } label: {
                            Image(systemName:entity.is_fav ? "heart.slash" : "heart.fill" ).font(.title)
                        }
                        .tint(Color(entity.is_fav ? .systemGray2 : .systemYellow))
                        
                    })
                    .swipeActions(edge: .leading, allowsFullSwipe: true, content: {
                        
                        //MARK: "Edit"
                        Button{
                            showEditView = true
                            selectEntity = entity
                            editTitle = entity.title ?? ""
                            editText = entity.body ?? ""
                        } label: {
                            Image(systemName: "square.and.pencil").font(.title)
                            
                        }
                        .tint(Color(.systemBlue))})
                
            }//foreach
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            //        }//list
            //MARK: - searchpreference
            
        }//scrollView
        
        //        .refresher(refreshView: EmojiRefreshView.init ) { done in
        //            print("hello")
        //            done()
        //        }
        //            .onSubmit(of: .search) { print("hello") }
        .listStyle(.plain)
        .preference(key: IsSearchingPreferenceKey.self, value: isSearching)
        //        .scrollIndicators(.automatic)
        .safeAreaInset(edge: .bottom, content: {Color.clear.frame(height: 50)})
        .navigationBarTitleDisplayMode(smallTitle ? .inline:.large)
        //MARK: - 删除提醒
        .confirmationDialog(Text("You are deleting this journal:\n\(selectEntity?.title ?? "no title")"), isPresented: $showDeleteAlert, titleVisibility: .visible, actions: {
            Button("delete",role: .destructive){
                withAnimation(.easeInOut(duration: 0.5)){
                    diaryvm.deleteDiaryWithEntity(entity: selectEntity!)}
                selectEntity = nil
                isShowDeleteToastAlert = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5,execute: {
                    withAnimation (.easeInOut(duration: 0.2)){
                        self.isShowDeleteToastAlert = false
                    }
                })
            }
        }, message: {Text("Are you sure?")})
        //MARK: - 编辑界面
        .sheet(isPresented: $showEditView,onDismiss: { selectEntity = nil }, content: {
            DiaryEditView(editTitle: $editTitle, editText: $editText, showEditView: $showEditView, selectEntity: $selectEntity)
        }).tint(.primary)
        //        }
        //geo
        
        
    }
}



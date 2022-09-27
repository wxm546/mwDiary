//
//  NotePage.swift
//  ProgressBar
//
//  Created by wxm on 2022/9/5.
//

import SwiftUI

//MARK: - DiaryView
struct DiaryView: View {
    
    //MARK: - State
    @State var editTitle = ""
    @State var editText = ""
    @State var showEditView = false
    @State var showDeleteAlert:Bool = false
    private var navTitle = dateFormatterMMMM.string(from: Date())
    @State var isShowFavToastAlert = false
    @State var isShowDeleteToastAlert = false
    //MARK: - ViewModel
    @EnvironmentObject var diaryvm:DiaryViewMode
    @State var selectEntity:DiaryEntity? = nil
    //MARK: - filteredDiary
    var filteredDiary: [DiaryEntity] {
        if navTitle.isEmpty {
            return diaryvm.savedEntities
        } else {
            return diaryvm.savedEntities.filter { dateFormatterMMMM.string(from: $0.create_date!) == navTitle }
        }
    }
    
    
    //MARK: - ViewBody
    var body: some View {
        ZStack{
            NavigationView{
                    DiaryListView(editTitle: $editTitle,
                                  editText: $editText,
                                  showEditView: $showEditView,
                                  showDeleteAlert: $showDeleteAlert,
                                  selectEntity: $selectEntity,
                                  isShowFavToastAlert: $isShowFavToastAlert,
                                  isShowDeleteToastAlert: $isShowDeleteToastAlert,
                                  filteredDiary: filteredDiary)
                    //                        .border(.blue)
                    
                    .navigationTitle(navTitle)
                    //MARK: - 下拉编辑
                    .refreshable {
                        editTitle = ""
                        editText = ""
                        showEditView.toggle()
                    }
            }//Nav
            //                .border(.red)
            .navigationViewStyle(StackNavigationViewStyle())
            //MARK: - toolBar
            Button {
                //TODO: - 储存默认值
                editTitle = ""
                editText = ""
                showEditView.toggle()
            } label: {
                Image(systemName: "pencil").font(.title)
            }
            .frame(width: 50, height: 50)
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment:filteredDiary==[] ? .center : .topTrailing)
            .padding(.trailing,10)
            .tint(.primary)
            
//            Text(dissssss ?? false ? "true" : "false")
//            Text("\(listrowheight)")
//                .offset(x:100)
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
        //ZStack
    }
    //View
}





//MARK: - 预览
struct NotePage_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView()
            .environmentObject(DiaryViewMode())
    }
}













//MARK: -sheetview backup
//var editView: some View{
//    VStack{
//        Group{
//            //MARK: - 输入框
//            MyTextFieldwithUIKIT(text: $editTitle, placeholder: defaultTitle, isFirstResponder: $beginEditTitle)
//                .frame(height: 56,alignment: .center)
//                .overlay( RoundedRectangle(cornerRadius: 10, style: .continuous)
//                    .stroke(.primary, lineWidth: 3)
//                )
//                .padding(.top,20)
//            TextEditor(text: $editText)
//                .autocorrectionDisabled(true)
//                .overlay( RoundedRectangle(cornerRadius: 10, style: .continuous)
//                    .stroke(.primary, lineWidth: 4)
//                )
//                .cornerRadius(10)
//            if selectEntity?.modified_date != selectEntity?.create_date {
//                Text("Modified "+dateFormatterMMMddHHmm.string(from: selectEntity?.modified_date ?? Date()))
//                    .font(.footnote)
//                    .frame(maxWidth: .infinity,alignment: .trailing)
//            }
//
//            Button {
//                //                    guard !editText.isEmpty else { return }
//                diaryvm.addDiary(titlestr: editTitle.isEmpty ? defaultTitle : editTitle, bodystr: editText.isEmpty ? "hello world!" : editText)
//                editTitle = ""
//                editText = ""
//                showEditView = false
//            } label: {
//                Text("save")
//            }
//            Button {
//                //                    guard !editText.isEmpty else { return }
//                diaryvm.updateDiary(titlestr: editTitle.isEmpty ? defaultTitle : editTitle, bodystr: editText.isEmpty ? "" : editText, entity: selectEntity)
//                editTitle = ""
//                editText = ""
//                showEditView = false
//            } label: {
//                Text("update")
//            }
//        }
//        Group{
//            Text("\(editTitle)")
//            Text("\(editText)")
//        }
//    }
//    .padding(.horizontal)
//}
//



//MARK: - icloud方法2  sspai
//struct CloudData {
//    static let shared = CloudData()
//    let containerCloud : NSPersistentCloudKitContainer
//    init(inMemory:Bool = false){
//        containerCloud = NSPersistentCloudKitContainer(name: "mmDiary")
//        if inMemory {
//            containerCloud.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//        }
//        containerCloud.loadPersistentStores {_,_ in }
//        containerCloud.loadPersistentStores(completionHandler: { _,_ in })
//    }
//
//}


//MARK: - 方法2 icloud vm
//    @Environment(\.managedObjectContext) var viewContext
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DiaryEntity.create_date, ascending: false)],animation: .easeInOut)
//    var myIcloudDiary: FetchedResults<DiaryEntity>
//    @StateObject var locationManager = location
//    func newDiary(title:String,body:String) {
//        let new = DiaryEntity(context: viewContext)
//        new.title = title
//        new.body = body
//        new.create_date = Date()
//        new.modified_date = Date()
//        new.is_fav = false
//        try? viewContext.save()
//    }
//    func updateDiary(title:String,body:String) {
//        let new = DiaryEntity(context: viewContext)
//        new.title = title
//        new.body = body
//        new.create_date = Date()
//        new.modified_date = Date()
//        new.is_fav = false
//        try? viewContext.save()
//    }



//MARK: - textfield 备份

//                TextField(text: $editTitle, label: {Text("My daily mood.")})
//                TextField("My daily mood.", text: $editTitle)
//                TextEditor(text: $editTitle)
//                    .autocorrectionDisabled(true)
//                    .font(.title)
//                    .padding(.top,8)
//                    .overlay( RoundedRectangle(cornerRadius: 10, style: .continuous)
//                        .stroke(.primary, lineWidth: 4)
//                    )
//                    .multilineTextAlignment(.center)
//                TextEditor(text: self.$editTitle)
//                    .foregroundColor(self.note == placeholderString ? .gray : .primary)
//                              .onTapGesture {
//                                if self.editTitle == placeholderString {
//                                  self.editTitle = ""
//                                }
//                              }
//                              .onSubmit {
//                                  if self.editTitle == "" {
//                                      self.editTitle = placeholderString
//                                  }
//                              }
//                              .multilineTextAlignment(.center)

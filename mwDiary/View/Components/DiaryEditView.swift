//
//  NoteEditView.swift
//  ProgressBar
//
//  Created by wxm on 2022/9/5.
//

import SwiftUI

struct DiaryEditView: View {
    
    @EnvironmentObject var diaryvm:DiaryViewMode
    
    @State private var beginEditTitle = false
    
    @Binding var editTitle:String
    @Binding var editText:String
    @Binding var showEditView:Bool
    
    @Binding var selectEntity:DiaryEntity?
    
    
    var body: some View{
        VStack{
            Group{
                //MARK: - 输入框
                MyTextFieldwithUIKIT(text: $editTitle, placeholder: defaultTitle, isFirstResponder: $beginEditTitle)
                    .frame(height: 56,alignment: .center)
                    .overlay( RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(.primary, lineWidth: 3)
                    )
                    .padding(.top,20)
                TextEditor(text: $editText)
                    .autocorrectionDisabled(true)
                    .overlay( RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(.primary, lineWidth: 4)
                    )
                    .cornerRadius(10)
                if selectEntity?.modified_date != selectEntity?.create_date {
                    Text("Modified "+dateFormatterMMMddHHmm.string(from: selectEntity?.modified_date ?? Date()))
                        .font(.footnote)
                        .frame(maxWidth: .infinity,alignment: .trailing)
                }
                
                Button {
                    //                    guard !editText.isEmpty else { return }
                    if selectEntity == nil {
                        diaryvm.addDiary(titlestr: editTitle.isEmpty ? defaultTitle : editTitle, bodystr: editText.isEmpty ? defaultBody : editText)
                    } else {
                        diaryvm.updateDiary(titlestr: editTitle.isEmpty ? defaultTitle : editTitle, bodystr: editText.isEmpty ? "" : editText, entity: selectEntity)
                    }
                    editTitle = ""
                    editText = ""
                    showEditView = false
                    selectEntity = nil
                } label: {
                    Text("save")
                }.buttonStyle(.bordered)
            }
//            MARK: - test
//            Group{
//                Text("\(editTitle)")
//                Text("\(editText)")
//            }
        }
        .padding(.horizontal)
    }
}




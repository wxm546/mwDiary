//
//  mwDiaryApp.swift
//  mwDiary
//
//  Created by wxm on 2022/9/27.
//

import SwiftUI

@main
struct mwDiaryApp: App {
    @StateObject var diaryvm = DiaryViewMode()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(diaryvm)
        }
    }
}


//    let persistenceController = PersistenceController.shared
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)

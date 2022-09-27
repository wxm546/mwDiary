//
//  mwDiaryApp.swift
//  mwDiary
//
//  Created by wxm on 2022/9/27.
//

import SwiftUI

@main
struct mwDiaryApp: App {
//    let persistenceController = PersistenceController.shared
    @StateObject var diaryvm = DiaryViewMode()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(diaryvm)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

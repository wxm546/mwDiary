//
//  DiaryViewModel.swift
//  mmDiary
//
//  Created by wxm on 2022/9/22.
//
//https://cloud.tencent.com/developer/ask/sof/926782
import Foundation
import CoreData
import SwiftUI

//MARK: - diaryViewModel
class DiaryViewMode:ObservableObject{
  
    
//    let container: NSPersistentContainer
    private static var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "mwDiary")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return Self.container.viewContext
    }
    
    @Published var savedEntities: [DiaryEntity] = []
    
    init(isTest:Bool = false) {
        //        container = NSPersistentContainer(name: "mmDiary")
        //        container.loadPersistentStores { (description, error) in
        //            if let error = error {print("error loading core data.\(error)")}
        
//        self.persistentcon
        //        }
        fetchDiary()
    }
    
    func fetchDiary() {
        let request = NSFetchRequest<DiaryEntity>(entityName: "DiaryEntity")
        do {savedEntities = try context.fetch(request)
        } catch let error {print("error fetch.\(error)")}
    }
    
    func saveData(){
        do{try context.save()
            fetchDiary()
        } catch let error {print("error saving\(error)")}
    }
    
    func addDiary(titlestr:String,bodystr:String){
        let newDiary = DiaryEntity(context: context)
        //        newDiary.id = UUID()
        newDiary.title = titlestr
        newDiary.body = bodystr
        newDiary.create_date = Date()
        newDiary.modified_date = newDiary.create_date
        newDiary.is_fav = false
        saveData()
    }
    
    func updateDiary(titlestr:String,bodystr:String,entity:DiaryEntity?) {
        let newTitle = titlestr
        let newBody = bodystr
        entity?.title = newTitle
        entity?.body = newBody
        entity?.modified_date = Date()
        saveData()
    }
    
    //    func submitDiary(titlestr:String,bodystr:String,entity:DiaryEntity){
    //        if entity != nil {
    //            updateDiary(titlestr:titlestr,bodystr:bodystr,entity:entity!)
    //        } else   {
    //            addDiary(titlestr:titlestr,bodystr:bodystr)
    //        }
    //    }
    
    
    func favToggle(entity:DiaryEntity){
        let currentIsfav = entity.is_fav
        entity.is_fav = !currentIsfav
        saveData()
    }
    
    func deleteDiaryWithIndexSet(indexSet:IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        context.delete(entity)
        saveData()
    }
    
    func deleteDiaryWithEntity(entity:DiaryEntity) {
        let en = entity
        context.delete(en)
        saveData()
    }
    
    
    //导出功能
    @State private var isShareSheetShowing = false
    func exportAllToCSV() {
        //csv抬头
        let fileName = "mwDiary - \(exportDateFormatteryyyyMMddHHmmss.string(from:Date())).csv"
        //设定地址 不用管
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        //csv表头
        var csvText = "create_date,modified_date,title,body,is_fav\n"
        //csv表内容
        for dia in self.savedEntities {
            csvText += "\(exportDateFormatteryyyyMMddHHmmss.string(from: dia.create_date!)),\(exportDateFormatteryyyyMMddHHmmss.string(from: dia.create_date!)),\(dia.title ?? "no title"),\(dia.body ?? "no body"),\(dia.is_fav)\n"
        }
        //写入文件
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        print(path ?? "not found")
        //弹出分享栏
        var filesToShare = [Any]()
        filesToShare.append(path!)
        let av = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
        UIApplication.shared.connectedScenes
                                .map({ $0 as? UIWindowScene })
                                .compactMap({ $0 })
                                .first?.windows.first!.rootViewController?.present(av, animated: true, completion: nil)
        isShareSheetShowing.toggle()
        
    }

    
}




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
    
    
    //TODO: - 
    @State private var isShareSheetShowing = false
    func exportAllToCSV() {
        
        let fileName = "mwDiary\(dateFormatterMMMddHHmm.string(from:Date())).csv"
        
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = "Date,Type\n"
        for dia in self.savedEntities {
            csvText += "\(dia.create_date ?? Date()),\(dia.modified_date ?? Date()),\(dia.title ?? "no title"),\(dia.body ?? "no body"),\(dia.is_fav)\n"
        }
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        print(path ?? "not found")
        var filesToShare = [Any]()
        filesToShare.append(path!)
        let av = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        isShareSheetShowing.toggle()
        
    }
    
    
    
    
    
    
    
}



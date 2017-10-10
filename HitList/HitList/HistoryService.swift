//
//  HistoryService.swift
//  HitList
//
//  Created by yiqiwang(王一棋) on 2017/10/10.
//  Copyright © 2017年 melody5417. All rights reserved.
//

import UIKit
import CoreData

class HistoryService: NSObject {

    // MARK: Properties
    fileprivate let modelName: String = "HitList"

    /**
     copy SQLite & SHM & WAL files to replace the origional data files
     */
    func createHistoryData() -> Bool {
        // Default directory where the CoreDataStack will store its files
        let directory = NSPersistentContainer.defaultDirectoryURL()
        let url = directory.appendingPathComponent(modelName + ".sqlite")

        // 2: Copying the SQLite file
        let seededDatabaseURL = Bundle.main.url(forResource: modelName, withExtension: "sqlite")!
        _ = try? FileManager.default.removeItem(at: url)
        do {
            try FileManager.default.copyItem(at: seededDatabaseURL, to: url)
        } catch let nserror as NSError {
            fatalError("Error: \(nserror.localizedDescription)")
        }

        // 3: Copying the SHM file
        let seededSHMURL = Bundle.main.url(forResource: modelName, withExtension: "sqlite-shm")!
        let shmURL = directory.appendingPathComponent(modelName + ".sqlite-shm")
        _ = try? FileManager.default.removeItem(at: shmURL)
        do {
            try FileManager.default.copyItem(at: seededSHMURL, to: shmURL)
        } catch let nserror as NSError {
            fatalError("Error: \(nserror.localizedDescription)")
        }

        // 4: Copying the WAL file
        let seededWALURL = Bundle.main.url(forResource: modelName, withExtension: "sqlite-wal")!
        let walURL = directory.appendingPathComponent(modelName + ".sqlite-wal")
        _ = try? FileManager.default.removeItem(at: walURL)
        do {
            try FileManager.default.copyItem(at: seededWALURL, to: walURL)
        } catch let nserror as NSError {
            fatalError("Error: \(nserror.localizedDescription)")
        }

        return true
    }
}

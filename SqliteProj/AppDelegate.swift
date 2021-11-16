//
//  AppDelegate.swift
//  SqliteProj
//
//  Created by KoKang Chu on 2019/7/18.
//  Copyright © 2019 KoKang Chu. All rights reserved.
//

import UIKit
import CoreLocation
import SQLite3


// Ques: Question
// Note: xxx Description

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var db: OpaquePointer?
    lazy var dst = NSHomeDirectory() + "/Documents/mydb.sqlite"    //Ques: why it uses lazy

    let lm = CLLocationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        lm.requestWhenInUseAuthorization()
        
        let fm = FileManager.default
        let src = Bundle.main.path(forResource: "mydb", ofType: "sqlite")
        
        // Note: only create a new .sqlite file when there is no mydb.sqlite in Documents folder
        if !fm.fileExists(atPath: dst) {
            try! fm.copyItem(atPath: src!, toPath: dst)         //Ques: why there is a try!
        }
        opendb()
        
        return true
    }
//test
    func opendb() {
        if sqlite3_open(dst, &db) == SQLITE_OK {
            print("資料庫開啟成功")
        } else {
            print("開啟資料庫失敗")
            db = nil
        }
    }

    func closedb() {
        if let db = db {
            sqlite3_close(db)
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


//
//  FlicksApp.swift
//  Flicks
//
//  Created by Brad B on 16/12/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI
import CoreData
import GoogleMobileAds

@main
struct Flicks: App {
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            
            let cache = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
            URLCache.shared = cache
            
            // Initialize the Mobile Ads SDK
            GADMobileAds.sharedInstance().start(completionHandler: nil)
            return true
        }
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
            
        }
    }
}

// Load core data model
var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "MovieWatchList")
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.loadPersistentStores { description, error in
        if let error = error {
            // Add your error UI here
        }
    }
    return container
}()

// Core data save
func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}


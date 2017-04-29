//
//  AppDelegate.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/17/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        
        let first = DayCompositeViewController()
        let nav1 = UINavigationController(rootViewController: first)
        
        let second = NotesSearchViewController()
        second.title = "Notes"
        let nav2 = UINavigationController(rootViewController: second)
        
        let tabs = UITabBarController()
        tabs.viewControllers = [nav1, nav2]
        
        tabs.tabBar.barStyle = .black
        tabs.tabBar.isTranslucent = false
        
        let task1: Task = Task(title: "test1", status: false, priority: 5, date: Date(), group: "School", notes: Note(text: "end of semester", date: Date()))
        let task2: Task = Task(title: "test2", status: false, priority: 5, date: Date(), group: "School", notes: Note(text: "end of semester", date: Date()))
        let task3: Task = Task(title: "test3", status: false, priority: 5, date: Date(), group: "School", notes: Note(text: "end of semester", date: Date()))
        
        UserInfo.Instance.addTask(task: task1)
        UserInfo.Instance.addTask(task: task2)
        UserInfo.Instance.addTask(task: task3)
        window?.rootViewController = tabs
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


//
//  AppDelegate.swift
//  HackerBooks
//
//  Created by Vicente Albert López on 2/2/17.
//  Copyright © 2017 Ariz Software, S.L. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var lib: Library?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //  Creamos la libreria pasándole la URL al JSON que tiene la información, aunque de momento trabajo con el JSON descargado.
        lib = Library(JSON: URL(fileURLWithPath: "https://t.co/K9ziV0z3SJ"))
        
        //  Creamos la tabla que representa nuestro library.
        let libtvc = LibraryTableView(library: lib!)
        
        //  Si estamos corriendo en un iPad...
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            //  Creamos el viewController que representa nuestro libro.
            //  Pero hay que pasarle un libro así que vamos a coger el primero que nos aporta lib
            let tag = lib?.tags()[0]
            let bk = lib?.books(forTagName: (tag?.nameTag)!, at: 0)
            //  Inicializamos el ViewController con el primer libro del primer tag disponible
            let bookvc = BookViewController.init(book: bk!)
            //  Lo metemos dentro de un Navigation viewController para poder hacerle un push
            let NavBookvc = UINavigationController.init(rootViewController: bookvc)
            //  Ahora creamos el splitVC que los va a contener a los dos VC's
            let splitVC = UISplitViewController()
            //  Metemos los controladores
            splitVC.viewControllers = [libtvc, NavBookvc]
            //  Se lo asignamos a la window principal
            window?.rootViewController = splitVC
        }
        //  Si estamos corriendo en un iPhone...
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
            //  Lo metemos dentro de un Navigation viewController para poder hacerle un push
            let NavLibtvc = UINavigationController.init(rootViewController: libtvc)
            //  Se lo asignamos a la window principal
            window?.rootViewController = NavLibtvc
        }
        
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


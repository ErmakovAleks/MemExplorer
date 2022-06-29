//
//  AppDelegate.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 17.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let innerProvider = URLSessionMemesRequester()
        let cache = CacheManager()
        let provider = DataProvider(innerProvider: innerProvider, cache: cache)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = MemesListViewController(provider: provider)
        
        return true
    }
    
}


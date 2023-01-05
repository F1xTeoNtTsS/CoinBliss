//
//  SceneDelegate.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 12.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var assembly: Assembly!
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        self.assembly = Assembly(window: window)
        self.assembly.mainRouter.run()
    }
}

//
//  RegisterFirebaseSDKApp.swift
//  RegisterFirebaseSDK
//
//  Created by Александр on 16.03.2026.
//

import SwiftUI
import FirebaseCore

@main
struct RegisterFirebaseSDKApp: App {
    init() { // Инициализация сервисов до построения UI. 1 раз при запуске приложения
        FirebaseApp.configure() // Читает plist, соединяется с Firebase, готовит SDK
    }
    
    var body: some Scene { // Описание интерфейса. Много раз при запуске и изменения состояния
        WindowGroup {
            ContentView()
        }
    }
}

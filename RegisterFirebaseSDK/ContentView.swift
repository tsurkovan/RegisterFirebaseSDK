//
//  ContentView.swift
//  RegisterFirebaseSDK
//
//  Created by Александр on 16.03.2026.
//

import SwiftUI
import FirebaseAnalytics

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text("Firebase подключен! ✅")
                .foregroundColor(.green)
        }
        .padding()
        .onAppear {
            // Проверка: логируем событие
            Analytics.logEvent("app_launched", parameters: nil) // Отправляет событие в Firebase Analytics для отслеживания поведения пользователей
            print("Firebase работает!")
        }
    }
}

#Preview {
    ContentView()
}

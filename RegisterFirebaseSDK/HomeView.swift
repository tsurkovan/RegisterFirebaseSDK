//
//  HomeView.swift
//  RegisterFirebaseSDK
//
//  Created by Александр on 24.03.2026.
//
// 📦 1. Импортируем фреймворк SwiftUI для создания интерфейса
import SwiftUI
import FirebaseAuth

// 🏗️ 2. Объявляем структуру HomeView, которая соответствует протоколу View
struct HomeView: View {
    
    // 🔗 3. Наблюдаемый объект: ViewModel для управления аутентификацией
    @Bindable var viewModel: RegisterViewModel
    // ⚡ При изменении данных в viewModel View автоматически обновится
    
    // 🎨 4. Тело представления: описывает, как экран выглядит
    var body: some View {
        
        // 🧭 5. Навигационный контейнер: добавляет навигационную шапку
        NavigationView {
            
            // 📐 6. Вертикальный стек: элементы располагаются сверху вниз
            VStack {
                
                // 👋 7. Приветственный текст: крупный заголовок
                Text("Добро пожаловать!")
                    
                    // 🔤 8. Шрифт: большой заголовок (largeTitle)
                    .font(.largeTitle)
                
                // 📧 9. Email пользователя: берётся из RegisterService
                Text(RegisterService.shared.currentUser?.email ?? "")
                    
                    // 🔤 10. Шрифт: заголовок (headline)
                    .font(.headline)
                    
                    // 🎨 11. Цвет текста: серый (второстепенная информация)
                    .foregroundColor(.gray)
                
                // 📏 12. Распорка: занимает всё свободное место, толкая контент вниз
                Spacer()
                
                // 🖱️ 13. Кнопка выхода: использует наш CustomButton
                CustomButton(title: "Выйти", action: {
                    
                    // 🚪 14. Действие: вызываем метод выхода из ViewModel
                    viewModel.signOut()
                })
                
                // 📏 15. Внешний отступ: 40pt вокруг кнопки
                .padding(40)
            }
            
            // 🏷️ 16. Заголовок навигации: текст в шапке экрана
            .navigationTitle("Главная")
            
            // 📐 17. Режим заголовка: компактный (inline) вместо большого
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


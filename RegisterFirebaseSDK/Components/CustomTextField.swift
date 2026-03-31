//
//  CustomTextField.swift
//  RegisterFirebaseSDK
//
//  Created by Александр on 24.03.2026.
//
// 📦 1. Импортируем фреймворк SwiftUI для создания интерфейса
import SwiftUI

// 🏗️ 2. Объявляем структуру CustomTextField, которая соответствует протоколу View
struct CustomTextField: View {
    
    // 🏷️ 3. Переменная только для чтения: текст-подсказка (например, "Введите email")
    let placeholder: String
    
    // 🔗 4. Двусторонняя связь: текст поля хранится во внешнем источнике (родительском View)
    @Binding var text: String
    
    // 🔒 5. Флаг безопасности: по умолчанию false (обычное текстовое поле)
    var isSecure: Bool = false
    
    // 🎨 6. Тело представления: описывает, как компонент выглядит на экране
    var body: some View {
        
        // 📐 7. Вертикальный стек: выравнивание по левому краю, отступ между элементами 8pt
        VStack(alignment: .leading, spacing: 8) {
            
            // 🔐 8. УСЛОВИЕ: Если режим безопасного ввода (пароль)...
            if isSecure {
                
                // 🙈 9. Поле SecureField: скрывает вводимые символы (точки/звёздочки)
                SecureField(placeholder, text: $text)
                    
                    // 📏 10. Внутренний отступ: увеличивает размер поля на 16pt со всех сторон
                    .padding(16)
                    
                    // 🎨 11. Фон: светло-серый цвет из системной палитры iOS
                    .background(Color(.systemGray6))
                    
                    // 🔲 12. Скругление: делает углы поля закруглёнными (радиус 12pt)
                    .cornerRadius(12)
                
            } else {
                // 🔓 13. ИНАЧЕ: Если режим обычного ввода (логин, имя, email)...
                
                // ✏️ 14. Поле TextField: показывает вводимый текст открыто
                TextField(placeholder, text: $text)
                    
                    // 📏 15. Внутренний отступ: аналогично SecureField (16pt)
                    .padding(16)
                    
                    // 🎨 16. Фон: аналогично SecureField (системный серый)
                    .background(Color(.systemGray6))
                    
                    // 🔲 17. Скругление: аналогично SecureField (12pt)
                    .cornerRadius(12)
            }
        }
    }
}

//
//  RegisterError.swift
//  RegisterFirebaseSDK
//
//  Created by Александр on 22.03.2026.
//
// ─────────────────────────────────────────────────────────────
// ФАЙЛ: RegisterError.swift
// НАЗНАЧЕНИЕ: Единый источник ошибок авторизации для всего приложения
// ─────────────────────────────────────────────────────────────

import Foundation
import FirebaseAuth

// ════════════════════════════════════════════════════════════
// MARK: - Типы ошибок авторизации
// ════════════════════════════════════════════════════════════

/// 🔹 Человекочитаемые ошибки для показа пользователю
/// 🔹 Соответствует протоколу LocalizedError для совместимости с SwiftUI
/// 🔹 enum: перечисление типов ошибок
enum AuthError: LocalizedError {
    
    // ── Варианты ошибок ─────────────────────────────────────
    case networkError                   // 🌐 Нет интернета
    case invalidEmail                   // 📧 Некорректный email
    case emailAlreadyInUse              // 📛 Email уже занят
    case weakPassword                   // 🔐 Слабый пароль
    case userNotFound                   // 👤 Пользователь не найден
    case wrongPassword                  // ❌ Неверный пароль
    case userDisabled                   // 🚫 Аккаунт заблокирован
    case tooManyRequests                // ⏳ Слишком много попыток
    case unknown(String)                // ❓ Любая другая ошибка
    
    // ── Текст ошибки для показа в UI ────────────────────────
    var errorDescription: String? {   // → 📝 Протокол требует
        switch self {   // → 🔄 Выбираем текст по типу ошибки
        case .networkError:
            return "Проверьте подключение к интернету"
        case .invalidEmail:
            return "Некорректный формат email"
        case .emailAlreadyInUse:
            return "Этот email уже зарегистрирован"
        case .weakPassword:
            return "Пароль должен содержать минимум 6 символов"
        case .userNotFound:
            return "Пользователь с таким email не найден"
        case .wrongPassword:
            return "Неверный пароль"
        case .userDisabled:
            return "Аккаунт заблокирован"
        case .tooManyRequests:
            return "Слишком много попыток. Попробуйте позже"
        case .unknown(let message):  // → ❓ Извлекаем сообщение ошибки
            return message    // → 📝 Возвращаем текст ошибки
        }
    }
    
    // ── Конвертер: ошибка Firebase → наша ошибка ────────────
    static func fromFirebase(_ error: Error) -> AuthError {
        // → 🔄 Принимает ошибку от Firebase, возвращает нашу
        let code = (error as NSError).code   // → 🔍 Получаем код ошибки
        
        switch code {   // → 🔄 Сравниваем с кодами Firebase
        case AuthErrorCode.networkError.rawValue:
            return .networkError
        case AuthErrorCode.invalidEmail.rawValue:
            return .invalidEmail
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            return .emailAlreadyInUse
        case AuthErrorCode.weakPassword.rawValue:
            return .weakPassword
        case AuthErrorCode.userNotFound.rawValue:
            return .userNotFound
        case AuthErrorCode.wrongPassword.rawValue:
            return .wrongPassword
        case AuthErrorCode.userDisabled.rawValue:
            return .userDisabled
        case AuthErrorCode.tooManyRequests.rawValue:
            return .tooManyRequests
        default:     // → ❓ Любой другой код
            return .unknown(error.localizedDescription)
            // → 📝 Сохраняем оригинальное сообщение для отладки
        }
    }
}

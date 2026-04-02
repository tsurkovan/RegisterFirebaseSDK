//
//  RegisterService.swift
//  RegisterFirebaseSDK
//
//  Created by Александр on 21.03.2026.
//
// ─────────────────────────────────────────────────────────────
// ФАЙЛ: RegisterService.swift
// НАЗНАЧЕНИЕ: Сервис для работы с Firebase Authentication
// ВЕРСИЯ: Простая (без протоколов и сложной архитектуры)
// ─────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────
// ИМПОРТ МОДУЛЕЙ
// ─────────────────────────────────────────────────────────────

import Foundation           // → 📦 Базовые типы: String, Error, Bool и др.
import FirebaseAuth         // → 🔐 Firebase SDK: Auth.auth(), User, методы авторизации
import FirebaseCore

// ─────────────────────────────────────────────────────────────
// СЕРВИС авторизации: Работа с Firebase Authentication
// ─────────────────────────────────────────────────────────────

// 🔹 @MainActor: все методы выполняются на главном потоке
// → 🎯 Безопасно для обновления UI из ViewModel
// → ⚡ Не нужно писать Task { @MainActor in ... }

// 🔹 class: ссылочный тип для сервиса
// → 📦 Singleton должен быть классом (не struct)

@MainActor
final class RegisterService {       // → 🔹 final: запрет наследования (оптимизация)
    
    // ════════════════════════════════════════════════════════
    // MARK: - Singleton: единственный экземпляр
    // ════════════════════════════════════════════════════════
    
    // 🔹 static let: свойство класса (один на всё приложение)
    // → 🌐 shared: глобальная точка доступа к сервису
    // → ⚡ Ленивая инициализация: создастся при первом обращении
    static let shared = RegisterService()
    
    // 🔹 private init(): запрет создания других экземпляров
    private init() {                // → 🔒 Нельзя сделать RegisterService() в другом файле
        // → 🎯 Гарантия: только один экземпляр на всё приложение
    }
    
    // ════════════════════════════════════════════════════════
    // MARK: - Свойства
    // ════════════════════════════════════════════════════════
        
    // 👤 1. Вычисляемое свойство: текущий авторизованный пользователь
    var currentUser: FirebaseAuth.User? {
        // → 🔄 Возвращаем пользователя напрямую из Firebase Auth
        // → 🎯 Всегда актуальные данные: Firebase сам управляет состоянием
        // → ⚡ Не нужно синхронизировать вручную после signIn/signUp/signOut
        // → 🔍 Тип FirebaseAuth.User (из SDK), а не кастомный модельный класс
        return Auth.auth().currentUser
    }
        
    // 📧 2. Удобный геттер только для email (опционально, для удобства в UI)
    var currentEmail: String? {
        // → 🔗 Делегируем получение email свойству currentUser
        // → 🎯 Безопасный доступ: если currentUser == nil, вернёт nil
        // → 💡 Удобно использовать в Text(...): RegisterService.shared.currentEmail ?? "Гость"
        return currentUser?.email
    }
        
    // 🆔 3. Удобный геттер для UID пользователя (опционально)
    var currentUID: String? {
        // → 🔑 Возвращает уникальный идентификатор пользователя в Firebase
        // → 🎯 Полезно для запросов к Firestore, Storage и другим сервисам
        return currentUser?.uid
    }
        
    // ════════════════════════════════════════════════════════
    // MARK: - Методы авторизации
    // ════════════════════════════════════════════════════════
    
    /// 🔐 Вход в аккаунт
    /// - Parameters:
    ///   - email: Email пользователя
    ///   - password: Пароль
    /// - Returns: Объект User с данными аккаунта
    /// - Throws: AuthError с понятным описанием
    func signIn(email: String, password: String) async throws {
        // → ⚡ async: ждём сетевой запрос
        // → 🔥 throws: может выбросить ошибку
        // → 🎯 Возвращает Void (ничего не возвращает)
        do {
            try await Auth.auth()
                .signIn(withEmail: email, password: password)
            // → try await: выполняем и ждём результат
            // → 🎯 Результат не сохраняем — он нам не нужен
        } catch {
            throw AuthError.fromFirebase(error) // ✅ Ссылка на AuthError из RegisterError.swift
            // → 🔄 Конвертируем ошибку Firebase в нашу
        }
    }
        
    /// 📝 Регистрация нового пользователя
    /// - Parameters:
    ///   - email: Email для нового аккаунта
    ///   - password: Пароль (мин. 6 символов)
    /// - Throws: AuthError с описанием проблемы
    func signUp(email: String, password: String) async throws {
        // → 🎯 Аналогично signIn(), но создаёт нового пользователя
        // → 🎯 Возвращает Void (ничего не возвращает)
        
        do {
            try await Auth.auth()
                .createUser(withEmail: email, password: password)
            // → try await: выполняем и ждём результат
            // → 🎯 Результат не сохраняем — он нам не нужен
        } catch {
            throw AuthError.fromFirebase(error)
            // → 🔄 Конвертируем ошибку Firebase в нашу
        }
    }
        
    /// 🚪 Выход из аккаунта
    /// - Throws: AuthError, если произошла ошибка
    func signOut() throws {             // → 🎯 Синхронный метод (быстрая операция)
        // → ⚡ Не требует async: выход выполняется локально
        
        do {
            try Auth.auth().signOut()   // → 🔑 Завершаем сессию Firebase
        } catch {
            throw AuthError.fromFirebase(error) // → 🔄 Конвертируем ошибку
        }
    }
 }

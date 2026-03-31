//
//  RegisterFirebaseSDKApp.swift
//  RegisterFirebaseSDK
//
//  Created by Александр on 16.03.2026.
//
//  RegisterFirebaseSDKApp.swift
// 1. Импорт фреймворков
import SwiftUI           // ✅ Основной UI-фреймворк Apple
import FirebaseCore       // ✅ Ядро Firebase (инициализация, конфигурация)

// 2. Атрибут точки входа
@main                     // 🎯 Указывает компилятору: "Это начало приложения"
struct RegisterFirebaseSDKApp: App {  // 📦 Структура, соответствующая протоколу App
    
    // 3. Подключение классического AppDelegate для Firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate // AppDelegate.self - Ссылка на ваш класс делегата, delegate - свойство, через которое доступен экземпляр
    //    └─ Адаптирует UIKit-делегат для SwiftUI жизненного цикла. Позволяет использовать классический `UIApplicationDelegate` (из UIKit) внутри современного SwiftUI-приложения. В App нет методов типа didFinishLaunchingWithOptions. SwiftUI сам управляет жизненным циклом.
    //    └─ Нужен для Firebase.initializeApp() в AppDelegate. Чтобы выполнять действия при запуске приложения (инициализация Firebase, настройка Push, аналитика), которые требуют доступа к жизненному циклу UIKit. Вместо nit() {   FirebaseApp.configure() }
    
    // 4. ViewModel: создаём как экземпляр RegisterViewModel
        private let viewModel = RegisterViewModel()  // ✅ Простое свойство для @Observable
    
    // 5. Описание интерфейса приложения
    var body: some Scene {          // 🎬 Возвращает сцену (окно) приложения
        WindowGroup {               // 🪟 Группа окон (для iPad/Mac поддерживает много окон)
              // 6. Условная навигация на основе состояния входа
            if viewModel.isLoggedIn {          // 🔐 Проверка: пользователь авторизован? Свойство класса RegisterViewModel
                HomeView(viewModel: viewModel) // ✅ Да → показать главный экран
            } else {
                // ⚠️ Передаём viewModel и сюда, если LoginView его использует!
                LoginView() // ❌ Нет → показать экран входа
            }
            // ⚠️ ВАЖНО: LoginView() не получает viewModel — проверьте, как он там используется!
        }
    }
}
// ─────────────────────────────────────────────────────────────
// MARK: - AppDelegate: класс для обработки событий жизненного цикла
// ─────────────────────────────────────────────────────────────

/// 🔹 class: объявление класса (ссылочный тип)
/// 🔹 AppDelegate: имя класса (конвенция Apple — так называют делегат приложения)
/// 🔹 : — оператор наследования и соответствия протоколам
/// 🔹 NSObject: базовый класс Objective-C (нужен для совместимости с UIKit)
/// 🔹 UIApplicationDelegate: протокол, который описывает методы реакции на события приложения
class AppDelegate: NSObject, UIApplicationDelegate {
    // → 🎯 Класс должен наследовать NSObject, чтобы работать с UIKit-событиями
    // → 📋 UIApplicationDelegate требует реализации определённых методов
    
    // ─────────────────────────────────────────────────────────
    /// 🔹 func: объявление метода (функции внутри класса)
    /// 🔹 application: имя метода (фиксированное, требует протокол)
    /// 🔹 (_ application: UIApplication): первый параметр
    ///     • _ — внешнее имя параметра скрыто (вызов: application(self, ...) без имени)
    ///     • application: внутреннее имя для использования внутри метода
    ///     • UIApplication: тип объекта, представляющего само приложение
    /// 🔹 didFinishLaunchingWithOptions: второй параметр (фиксированное имя)
    ///     • launchOptions: внутреннее имя параметра
    ///     • [UIApplication.LaunchOptionsKey: Any]?: тип значения
    ///         - [...] — словарь (Dictionary)
    ///         - UIApplication.LaunchOptionsKey: тип ключа (перечисление причин запуска)
    ///         - Any: тип значения (может быть чем угодно: String, URL, Data и т.д.)
    ///         - ?: опционал — словарь может отсутствовать (nil)
    ///     • = nil: значение по умолчанию, если параметр не передан
    /// 🔹 -> Bool: метод возвращает логическое значение (успех/неудача)
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // → 🎯 Метод вызывается ОДИН РАЗ при запуске приложения
        // → 📦 launchOptions содержит данные, если приложение запустили:
        //    • из уведомления, • по ссылке, • из виджета, • и т.д.
        
        // ─────────────────────────────────────────────────────
        /// 🔹 FirebaseApp: класс из FirebaseCore для управления экземпляром Firebase
        /// 🔹 .configure(): статический метод инициализации Firebase
        /// ✅ Обязательно вызывать ДО любого использования Firebase-сервисов
        FirebaseApp.configure()
        // → 🎯 Что делает:
        //    • Читает настройки из GoogleService-Info.plist
        //    • Инициализирует Auth, Firestore, Analytics и другие модули
        //    • Подготавливает сетевое соединение с серверами Firebase
        // → ⚠️ Если не вызвать — все методы Firebase будут падать с ошибкой
        
        // ─────────────────────────────────────────────────────
        /// 🔹 return: оператор возврата значения из метода
        /// 🔹 true: логическое значение «успех»
        /// ✅ Возврат true сообщает системе: «запуск завершён успешно, продолжай»
        return true
        // → 🎯 Если вернуть false — приложение завершит работу сразу после запуска
        // → 📋 В 99.9% случаев всегда возвращаем true
    }
}

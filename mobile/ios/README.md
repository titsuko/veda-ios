# Veda Application (iOS)

iOS-версия мобильного приложения Veda.

## Стек технологий
* **Language:** Swift
* **UI Framework:** SwiftUI
* **Dependency Management:** Xcode Native
* **Architecture:** MVVM + Service Layer

## Ключевые сервисы
* **SessionManager:** Управление состоянием авторизации и жизненным циклом сессии пользователя.
* **KeychainHelper:** Безопасное хранение токенов и чувствительных данных.
* **AccountService & SessionService:** Обработка бизнес-логики аккаунта и сетевых запросов.

## Основные компоненты (UI)
* Модульная система навигации.
* Кастомные компоненты: `AppButton`, `AppTextField`, `AppSearchBar`.
* Реализация размытия через `TransparentBlur`.

## Требования
* Xcode 15.0+
* iOS 17.0+
* Swift 5.9+
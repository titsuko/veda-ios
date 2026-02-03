# Veda Application (Android)

Android-версия мобильного приложения Veda, построенная на современном стеке разработки.

## Стек технологий
* **Language:** Kotlin
* **UI Framework:** Jetpack Compose
* **Architecture:** MVVM / Clean Architecture (Domain layer)
* **Navigation:** Jetpack Compose Navigation
* **Theme:** Material3 (VedaApplicationTheme)

## Структура проекта
* `ui/screen` — экраны приложения (Auth, Home, Login, Register)
* `ui/navigation` — конфигурация навигации и графы (AuthNavGraph, HomeNavGraph)
* `ui/component` — общие UI-компоненты (кнопки, текстовые поля)

## Как запустить
1. Убедитесь, что у вас установлен Android Studio (Ladybug или новее).
2. Настройте `local.properties`, указав путь к SDK.
3. Синхронизируйте проект с Gradle.
4. Запустите модуль `app` на эмуляторе или физическом устройстве.
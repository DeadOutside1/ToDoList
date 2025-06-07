# 📝 ToDo App (Spring Boot + JWT + JSP)

Простое веб-приложение для управления задачами (ToDo), с аутентификацией через JWT и JSP-интерфейсом.

---

## 🚀 Функциональность

- 🔐 Регистрация и вход с JWT токенами
- ✅ CRUD для задач (создание, просмотр, редактирование, удаление)
- 👤 Привязка задач к пользователю
- 🌐 JSP-страницы с Bootstrap-оформлением
- 🧠 REST API + защита через JWT
- 🔄 Обновление access token с помощью refresh token

---

## 🧰 Технологии

- Java 17+
- Spring Boot
- Spring Security (с JWT)
- JSP + JSTL + Bootstrap
- Maven
- H2 (встроенная БД, можно сменить на PostgreSQL)

---

## ⚙️ Установка и запуск проекта

### 1. Клонировать проект

```bash
git clone https://github.com/твоя-ссылка.git
cd ToDoApp

2. Собрать проект
mvn clean install

3. Запустить приложение
mvn spring-boot:run

Приложение будет доступно по адресу:
📍 http://localhost:8091/login

```
## 🧑‍💻 REST API
- POST /api/auth/authenticate
Content-Type: application/json

{
  "username": "admin",
  "password": "admin"
}

## ♻️ Обновление токена
- POST /api/auth/refresh-token
 Authorization: Bearer {refreshToken}

## 📋 Получить задачи
- GET /api/tasks
Authorization: Bearer {accessToken}

## 🗂️ Структура проекта
-src
- ├── controller
 ├── model
 ├── repo
 ├── security
 ├── service
 └── templates (JSP)

## 📌 Примечание
- ✅ Можно переключить на PostgreSQL, просто измени application.properties

- 🔐 JWT access token хранится в localStorage, можно подключить refresh token обновление


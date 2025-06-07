<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Вход</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .login-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .btn-login {
            width: 100%;
            padding: 10px;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2 class="text-center mb-4">Вход</h2>

    <%-- Сообщение об ошибке входа --%>
    <c:if test="${param.error != null}">
        <div class="alert alert-danger text-center">Неверное имя пользователя или пароль</div>
    </c:if>

    <%-- Сообщение об успешном выходе --%>
    <c:if test="${param.logout != null}">
        <div class="alert alert-success text-center">Вы вышли из системы</div>
    </c:if>

    <form method="post" action="/login">
        <div class="form-group">
            <label for="username" class="form-label">Имя пользователя:</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>

        <div class="form-group">
            <label for="password" class="form-label">Пароль:</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>

        <button type="submit" class="btn btn-primary btn-login">Войти</button>
    </form>

    <div class="text-center mt-3">
        <a href="/register" class="text-decoration-none">Нет аккаунта? Зарегистрироваться</a>
    </div>
</div>
</body>
</html>

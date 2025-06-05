<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Вход в ToDo</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .login-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 100%;
            max-width: 400px;
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .login-header h3 {
            color: #343a40;
            font-weight: 600;
        }
        .form-control {
            border-radius: 5px;
            padding: 12px 15px;
            margin-bottom: 15px;
        }
        .btn-login {
            background-color: #4e73df;
            border: none;
            border-radius: 5px;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-login:hover {
            background-color: #3a5ec0;
            transform: translateY(-1px);
        }
        .register-link {
            text-align: center;
            margin-top: 20px;
            color: #6c757d;
        }
        .register-link a {
            color: #4e73df;
            text-decoration: none;
            font-weight: 500;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="login-card">
    <div class="login-header">
        <h3>Добро пожаловать в ToDo</h3>
        <p class="text-muted">Пожалуйста, войдите в свой аккаунт</p>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show">
                ${errorMessage}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>
    <c:if test="${not empty logoutMessage}">
        <div class="alert alert-success alert-dismissible fade show">
                ${logoutMessage}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <form method="post" action="<c:url value='/login'/>">
        <div class="form-group">
            <label for="username">Логин</label>
            <input type="text" id="username" name="username" class="form-control" placeholder="Введите ваш логин" required autofocus>
        </div>
        <div class="form-group">
            <label for="password">Пароль</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="Введите ваш пароль" required>
        </div>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <button type="submit" class="btn btn-login btn-block">Войти</button>

        <div class="register-link">
            Нет аккаунта? <a href="<c:url value='/register'/>">Зарегистрироваться</a>
        </div>
    </form>
</div>

<script src="/js/jquery-3.5.1.slim.min.js"></script>
<script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>
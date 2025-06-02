<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Вход в ToDo</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .login-container {
            width: 100%;
            max-width: 400px;
            padding: 30px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="login-container">
        <h3 class="text-center mb-4">Вход в ToDo</h3>
        <form id="loginForm" method="post" action="/login">
            <div class="form-group">
                <label for="username">Логин</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Пароль</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Войти</button>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        <div id="response" class="mt-3 text-danger text-center"></div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

<script>
    $(document).ready(function() {
        $('#loginForm').on('submit', function(e) {
            e.preventDefault();

            const data = {
                username: $('#username').val(),
                password: $('#password').val()
            };

            $.ajax({
                type: "POST",
                url: "/api/auth/authenticate",
                contentType: "application/json",
                data: JSON.stringify(data),
                success: function(response) {
                    // response должен содержать JWT
                    localStorage.setItem('jwtToken', response.jwt); // сохрани токен в localStorage

                    toastr.success("Успешный вход!", "Добро пожаловать");
                    setTimeout(function() {
                        window.location.href = "/viewToDoList";
                    }, 1000);
                },
                error: function(xhr) {
                    if (xhr.status === 403 || xhr.status === 401) {
                        toastr.error("Неверный логин или пароль", "Ошибка входа");
                    } else {
                        toastr.error("Произошла ошибка", "Ошибка сервера");
                    }
                }
            });
        });

    });
</script>
</body>
</html>
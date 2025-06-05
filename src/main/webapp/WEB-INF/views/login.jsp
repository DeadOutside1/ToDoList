<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <form id="loginForm">
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
    <div id="response" class="mt-3 text-center"></div>
    <div class="text-center mt-3">
        <a href="/register" class="text-decoration-none">Нет аккаунта? Зарегистрироваться</a>
    </div>
</div>

<script>
    document.getElementById('loginForm').addEventListener('submit', async function (e) {
        e.preventDefault();
        const form = new FormData(this);
        const data = {
            username: form.get('username'),
            password: form.get('password')
        };

        const responseElement = document.getElementById('response');
        responseElement.textContent = "";
        responseElement.className = "mt-3 text-center";

        try {
            const res = await fetch('/api/auth/authenticate', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(data)
            });

            if (res.ok) {
                const tokens = await res.json(); // Ожидаем { accessToken, refreshToken }

                localStorage.setItem('accessToken', tokens.accessToken);
                localStorage.setItem('refreshToken', tokens.refreshToken);

                responseElement.textContent = "Успешный вход! Перенаправление...";
                responseElement.classList.add('text-success');

                setTimeout(() => {
                    window.location.href = '/viewToDoList'; // поменяй путь, если у тебя другой
                }, 1000);
            } else {
                const error = await res.text();
                responseElement.textContent = error || "Ошибка входа";
                responseElement.classList.add('text-danger');
            }
        } catch (error) {
            responseElement.textContent = "Ошибка соединения с сервером";
            responseElement.classList.add('text-danger');
        }
    });
</script>
</body>
</html>

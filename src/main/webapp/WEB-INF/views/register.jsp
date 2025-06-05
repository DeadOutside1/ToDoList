<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Регистрация</title>
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
        .register-container {
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
        .btn-register {
            width: 100%;
            padding: 10px;
        }
    </style>
</head>
<body>
<div class="register-container">
    <h2 class="text-center mb-4">Регистрация</h2>
    <form id="registerForm">
        <div class="form-group">
            <label for="username" class="form-label">Имя пользователя:</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password" class="form-label">Пароль:</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <button type="submit" class="btn btn-primary btn-register">Зарегистрироваться</button>
    </form>
    <div id="response" class="mt-3 text-center"></div>
    <div class="text-center mt-3">
        <a href="/login" class="text-decoration-none">Уже есть аккаунт? Войти</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('registerForm').addEventListener('submit', async function (e) {
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
            // Регистрация
            const registerRes = await fetch('/api/auth/register', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(data)
            });

            if (!registerRes.ok) {
                const error = await registerRes.text();
                responseElement.textContent = error || "Ошибка регистрации";
                responseElement.classList.add('text-danger');
                return;
            }

            // Если регистрация прошла — авторизация
            const loginRes = await fetch('/api/auth/authenticate', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(data)
            });

            if (!loginRes.ok) {
                responseElement.textContent = "Регистрация успешна, но вход не удался.";
                responseElement.classList.add('text-warning');
                return;
            }

            const tokens = await loginRes.json();

            // Сохраняем токены
            localStorage.setItem("accessToken", tokens.accessToken);
            localStorage.setItem("refreshToken", tokens.refreshToken);

            responseElement.textContent = "Регистрация и вход успешны!";
            responseElement.classList.add('text-success');

            // Перенаправление на список задач
            setTimeout(() => {
                window.location.href = "/viewToDoList";
            }, 1000);

        } catch (error) {
            responseElement.textContent = "Ошибка соединения с сервером";
            responseElement.classList.add('text-danger');
        }
    });
</script>

</body>
</html>
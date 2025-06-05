<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ToDo Item List</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body>
<div class="container mt-3">
    <div class="d-flex justify-content-between">
        <div class="text-primary font-weight-bold">
            Hello, ${username}
            <button id="refreshTokenBtn" class="btn btn-sm btn-outline-secondary ml-2">Refresh Token</button>
        </div>
        <div class="mt-2">
            <strong>Access Token:</strong>
            <div id="accessTokenDisplay" style="word-break: break-all;"></div>
            <strong>Refresh Token:</strong>
            <div id="refreshTokenDisplay" style="word-break: break-all;"></div>
        </div>
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button type="submit" class="btn btn-outline-danger">Logout</button>
        </form>
    </div>
</div>

<div class="container mt-5">
    <h1 class="mb-4">ToDo Item List</h1>
    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
        <tr>
            <th>Id</th>
            <th>Title</th>
            <th>Date</th>
            <th>Status</th>
            <th>Created</th>
            <th>Updated</th>
            <th>Mark Completed</th>
            <th>Edit</th>
            <th>Delete</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="todo" items="${list}">
            <tr>
                <td>${todo.id}</td>
                <td>${todo.title}</td>
                <td>${todo.date}</td>
                <td>${todo.status}</td>
                <td>${todo.date}</td>
                <td>${todo.updatedAt}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/updateToDoStatus/${todo.id}" class="btn btn-success btn-sm">
                        Mark Complete
                    </a>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/editToDoItem/${todo.id}" class="btn btn-primary btn-sm">
                        Edit
                    </a>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/deleteToDoItem/${todo.id}" class="btn btn-danger btn-sm">
                        Delete
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="text-right">
        <a href="/addToDoItem" class="btn btn-outline-primary">Add New ToDo Item</a>
    </div>
</div>

<!-- Скрипт отображения и обновления токенов -->
<script>
    window.onload = function () {
        const accessTokenDisplay = document.getElementById("accessTokenDisplay");
        const refreshTokenDisplay = document.getElementById("refreshTokenDisplay");
        const refreshButton = document.getElementById("refreshTokenBtn");

        const accessToken = localStorage.getItem("accessToken");
        const refreshToken = localStorage.getItem("refreshToken");

        // Отобразим текущие токены
        accessTokenDisplay.textContent = accessToken || "—";
        refreshTokenDisplay.textContent = refreshToken || "—";

        // Обработка кнопки обновления токена
        refreshButton.addEventListener("click", async () => {
            if (!refreshToken) {
                alert("Refresh token не найден.");
                return;
            }

            try {
                const res = await fetch("/api/auth/refresh-token", {
                    method: "POST",
                    headers: {
                        "Authorization": "Bearer " + refreshToken
                    }
                });

                if (res.ok) {
                    const json = await res.json();
                    localStorage.setItem("accessToken", json.accessToken);
                    accessTokenDisplay.textContent = json.accessToken;
                    alert("Access token обновлён!");
                } else {
                    alert("Не удалось обновить токен. Возможно, он истёк.");
                }
            } catch (err) {
                alert("Ошибка при обновлении токена.");
            }
        });
    };
</script>
</body>
</html>

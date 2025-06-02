<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>View ToDo Item List</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body>

<div class="container">
    <h1 class="p-3">ToDo Item List</h1>

    <table id="todoTable" class="table table-bordered">
        <thead>
        <tr>
            <th>Id</th>
            <th>Title</th>
            <th>Date</th>
            <th>Status</th>
            <th>Mark Completed</th>
            <th>Edit</th>
            <th>Delete</th>
        </tr>
        </thead>
        <tbody>
        <!-- Задачи будут подставлены сюда JS -->
        </tbody>
    </table>

    <button type="button" class="btn btn-primary btn-block">
        <a href="/addToDoItem" style="color: white; text-decoration: none;">Add New ToDo Item</a>
    </button>
</div>

<script>
    const token = localStorage.getItem("jwtToken");
    if (!token) {
        // Нет токена — перекидываем на логин
        window.location.href = "/login";
    } else {
        fetch("/api/tasks", {
            headers: {
                "Authorization": "Bearer " + token
            }
        })
            .then(response => {
                if (response.status === 401) {
                    // Неавторизован — удаляем токен и кидаем на логин
                    localStorage.removeItem("jwtToken");
                    window.location.href = "/login";
                }
                return response.json();
            })
            .then(tasks => {
                const tbody = document.querySelector("#todoTable tbody");
                if (tasks.length === 0) {
                    tbody.innerHTML = "<tr><td colspan='7'>Список задач пуст.</td></tr>";
                    return;
                }
                tbody.innerHTML = tasks.map(todo => `
                <tr>
                    <td>${todo.id}</td>
                    <td>${todo.title}</td>
                    <td>${todo.date}</td>
                    <td>${todo.status}</td>
                    <td><button class="btn btn-success"><a href="/updateToDoStatus/${todo.id}" style="color:white;text-decoration:none;">Mark Complete</a></button></td>
                    <td><button class="btn btn-primary"><a href="/editToDoItem/${todo.id}" style="color:white;text-decoration:none;">Edit</a></button></td>
                    <td><button class="btn btn-danger"><a href="/deleteToDoItem/${todo.id}" style="color:white;text-decoration:none;">Delete</a></button></td>
                </tr>
            `).join('');
            })
            .catch(() => {
                // При ошибке редиректим на логин
                window.location.href = "/login";
            });
    }
</script>

</body>
</html>

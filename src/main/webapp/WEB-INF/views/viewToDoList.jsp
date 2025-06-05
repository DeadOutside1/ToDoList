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

</body>
</html>

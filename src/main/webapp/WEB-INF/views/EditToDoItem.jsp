<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Item</title>

    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <script
            src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script
            src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script
            src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

    <style>
        a {
            color: white;
        }
        a:hover {
            color: white;
            text-decoration: none;
        }
        .form-group {
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>

<div class="container">
    <h1 class="p-3">Edit Item</h1>

    <form:form action="/editSaveToDoItem" method="post" modelAttribute="todo">
        <form:hidden path="id"/>

        <div class="form-group row">
            <label class="col-md-3 col-form-label" for="title">Title</label>
            <div class="col-md-6">
                <form:input path="title" id="title"
                            class="form-control" required="true" />
            </div>
        </div>

        <div class="form-group row">
            <label class="col-md-3 col-form-label" for="date">Date</label>
            <div class="col-md-6">
                <form:input type="date" path="date" id="date"
                            class="form-control" readonly="true" />
            </div>
        </div>

        <div class="form-group row">
            <label class="col-md-3 col-form-label" for="status">Status</label>
            <div class="col-md-6">
                <form:select path="status" id="status" class="form-control">
                    <form:option value="Incomplete">Incomplete</form:option>
                    <form:option value="In Progress">In Progress</form:option>
                    <form:option value="Completed">Completed</form:option>
                </form:select>
            </div>
        </div>

        <div class="form-group row">
            <div class="col-md-6 offset-md-3">
                <button type="submit" class="btn btn-success">Save</button>
                <a href="/viewToDoList" class="btn btn-secondary ml-2">Cancel</a>
            </div>
        </div>
    </form:form>
</div>

<script>
    window.onload = function() {
        var msg = "${message}";
        console.log(msg);

        if (msg === "Edit Failure") {
            toastr.error("Something went wrong with the edit.");
        } else if (msg === "Edit Success") {
            toastr.success("Item updated successfully!");
        }

        toastr.options = {
            "closeButton": true,
            "debug": false,
            "newestOnTop": false,
            "progressBar": true,
            "positionClass": "toast-top-right",
            "preventDuplicates": false,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };
    };
</script>

</body>
</html>
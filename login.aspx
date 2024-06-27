<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WebApplication2.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard | Login</title> 
    <link rel="stylesheet" href="css/libs/bootstrap.min.css" />
    <link rel="stylesheet" href="css/libs/font-awesome.min.css" /> 
    <script src="js/libs/bootstrap.bundle.min.js"></script> 
    <script type="text/javascript" src="js/libs/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/libs/toastify.min.css" />
    <script type="text/javascript" src="js/libs/toastify-js.js"></script> 

</head>
<body class="bg-light">

    <script type="text/javascript">   
        //Called this method on any button click  event for Testing
        function AdminLogin() {
            if ($("#username").val() == "") {
                toast("Username is required.")
            } else if ($("#password").val() == "") {
                toast("Password is required.")
            } else {
                $.ajax({
                    type: "POST",
                    url: "login.aspx/LoginMe",
                    data: `{ username: '${$("#username").val()}', password: '${$("#password").val()}' }`,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: "true",
                    cache: "false",
                    success: (res) => {
                        console.log(res)
                        if (res.d) {
                            toast("Success")
                            localStorage.setItem('admin', $("#username").val())
                            location.href = "index.aspx"
                        } else {
                            toast("Something went wrong")
                        }
                    },
                    Error: function (x, e) {
                        toast(e);
                    }
                });
            }
        }

    </script>
    <form id="form1" runat="server">
        <div class="container mt-5 ">

            <img src="image/login.png" style="height:70vh; position: fixed; display: grid; place-items: center; z-index: -1;bottom:100px;" />

            <img src="image/logo.png" alt="error" height="45" class="m-auto d-block mb-3" />

            <h3 class="text-center">Admin Login</h3>
            <br />

            <div class="bg-white p-3 m-auto shadow pb-4" style="width:450px;border-radius:5px;">
                <div class="m-auto" style="width: 350px;">
                    <div class="mt-3">
                        <label for="USERNAME" class="form-label">
                            <b>User Name :</b>
                        </label>
                        <input id="username" class="form-control" />
                    </div>
                    <div class="mt-3">
                        <label for="PASSWORD" class="form-label">
                            <b>Password :</b>
                        </label>
                        <input id="password" class="form-control" type="password" />
                    </div>
                    <br />

                    <button type="button" class="btn btn-primary d-block m-auto" onclick="AdminLogin()">Login</button> <br />

                    <p style="text-align:center;">
                        <a href="/station/index.aspx">Station</a> &nbsp; • &nbsp;
                        <a href="/andon/index.aspx">Andon</a> &nbsp; • &nbsp;
                        <a href="/station/print.aspx">Print QR</a> 
                    </p>

                </div>
            </div>
        </div>
    </form>

    <script>

        if (localStorage.getItem("admin") != null) {
            location.href = "index.aspx"
        }

        const toast = txt =>

            Toastify({
                text: txt,
                duration: 3000,
                gravity: "bottom",
                position: "right",
                style: {
                    background: 'gray'
                }
            }).showToast();

    </script>
</body>
</html>

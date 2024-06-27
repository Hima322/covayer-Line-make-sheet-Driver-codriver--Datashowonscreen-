<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="WebApplication2.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="css/libs/bootstrap.min.css" />
    <link rel="stylesheet" href="css/libs/font-awesome.min.css" />
    <script src="js/libs/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="js/libs/jquery.min.js"></script>

    <style>
        button.first-active:first-child {
            color: white;
            background: #6c757d;
        }

        button.first-active {
            background: #f8f9fa;
        }

            button.first-active:hover {
                background: #d3d4d5;
            }
        /* width */
        ::-webkit-scrollbar {
            width: 10px;
        }

        /* Handle */
        ::-webkit-scrollbar-thumb {
            background: lightgray;
            border-radius: 10px;
        }
    </style>
    <script>
        //handle delete btn click function 
        const handleDelete = id => {
            var sure = confirm("Are you sure want to delete?")
            if (sure) {
                $.ajax({
                    type: "POST",
                    url: "index.aspx/HandleDelete",
                    data: `{ id: '${id}' }`,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: "true",
                    cache: "false",
                    success: (res) => {
                        console.log(res)
                        if (res.d) {
                            window.location.reload()
                            toast("Success")
                        } else {
                            toast("Something went wrong")
                        }
                    },
                    Error: function (x, e) {
                        console.log(e);
                    }
                })
            }
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <% if (CurrentError != "")
                { %>
            <div id="toast" class="toast <%=CurrentError == "" ? "" : "show" %> bg-white" style="position: fixed; top: 20px; right: 20px; z-index: 999;">
                <div class="d-flex p-2 bg-secondary toast-body text-white">
                    <big class="me-auto ps-2"><%=CurrentError %></big>
                    <button type="button" class="btn-close text-white" data-bs-dismiss="toast"></button>
                </div>
            </div>
            <% } %>


            <%--navbar header--%>
            <div class="navbar navbar-light d-flex px-5" style="background: lightgray;">
                <!--header logo-->
                <img src="image/logo.png" alt="error" height="45" />

                <!--header menu-->
                <div class="d-flex gap-2">
                    <a class="btn btn-light" href="/monitor/index.aspx" target="blank" style="text-decoration: none; color: black;">Monitor &amp; Control</a>

                    <button class="btn btn-light" type="button" data-bs-toggle="offcanvas" data-bs-target="#demo">
                        Menu
                        <img src="image/icon/quote.svg" height="20" />
                    </button>

                    <div class="offcanvas offcanvas-end" id="demo">
                        <div class="offcanvas-header">
                            &nbsp;
                            <button class="btn btn-outline-danger" type="button" data-bs-toggle="offcanvas" data-bs-target="#demo">
                                Close
                                <img src="image/icon/x.svg" />
                            </button>
                        </div>
                        <div class="offcanvas-body px-5 text-center">
                            <button class="btn btn-outline-secondary mb-3" type="button" onclick="location.href = '/order/index.aspx'">Production</button>
                            &nbsp;
                                <button class="btn btn-outline-secondary mb-3" type="button" onclick="location.href = '/station/print.aspx'">Print Qr</button>
                            <br />
                            <button class="btn btn-outline-secondary mb-3" type="button" onclick="location.href = '/user/entry.aspx'">Entry</button>
                            &nbsp;
                                <button class="btn btn-outline-secondary mb-3" type="button" onclick="location.href = '/report/index.aspx'">Report</button>
                            &nbsp;
                                <button class="btn btn-outline-secondary mb-3" type="button" onclick="location.href = '/user/index.aspx'">User</button>&nbsp;
                                <button class="btn btn-outline-secondary mb-3" type="button" onclick="location.href = '/station/task.aspx'">Task</button>
                            <br /> 
                                <button class="btn btn-outline-secondary mb-3" type="button" onclick="location.href = '/qrlabel/index.aspx'">QR Label</button> &nbsp; 
                                <button class="btn btn-outline-secondary mb-3" type="button" onclick="location.href = '/user/info.aspx'">Station User Info</button> <br />

                                <%--<button class="btn btn-outline-secondary mb-3" type="button" onclick="location.href = '/other/off.aspx'">Network</button><br />--%>
                            
                            <button class="btn btn-danger mb-3 shadow" type="button" onclick="localStorage.removeItem('admin') || location.reload()">Logout</button>
                        </div>
                        <div class="offcanvas-footer">
                            <p class="text-center">
                                &copy; Pioneer Machine & Automation Pvt Ltd
                                <script>document.write(new Date().getFullYear())</script>
                                .
                            </p>
                        </div>
                    </div>

                </div>
            </div>


            <%--body part code--%>
            <div class="container-fluid px-5 mt-3">

                <%--model name lists--%>
                <div class="d-flex justify-content-between align-items-center">
                    <div>

                        <%foreach (var model in ModelList)
                            { %>
                        <button type="button" onclick="location.replace('index.aspx?model=<%=model.ModelName %>')" class="btn <%=Request.Params.Get("model") == null ? "first-active" : Request.Params.Get("model") == model.ModelName ? "btn-secondary" : "btn-light" %>"><%= model.ModelName %></button>
                        <% } %>

                        <!-- Button to Open the Modal -->

                        <% if (ModelList.Count != 0)
                            { %>
                        <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#myModal">
                            Add Model
                        </button>
                        <% } %>
                    </div>

                    <%--this is variant form button--%>
                    <% if (ModelList.Count != 0)
                        { %>
                    <div class="d-flex justify-content-around align-items-center">
                        <input id="search_box" type="text" placeholder="Search.." class="form-control" />
                        &ensp;&ensp;
                            <button style="width: 170px;" class="btn btn-secondary" type="button" onclick="location.href = 'variant/add.aspx?model=<%=SelectedModel %>'">Add Variant</button>
                    </div>
                    <% } %>
                </div>


                <%--search js--%>
                <script>
                    $(document).ready(function () {
                        $("#search_box").on("keyup", function () {
                            var value = $(this).val().toLowerCase().trim();
                            $("#filter_data tr").filter(function () {
                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                            });
                        });
                    });
                </script>


                <%--model details table--%>
                <table class="table text-center table-hover mt-3">

                    <%if (VariantList.Count != 0)
                        { %>
                    <thead class="table-secondary">
                        <tr>
                            <th>Variant</th>
                            <th>C5S_7F</th>
                            <th>Seat</th>
                            <th>CustPartNumber</th>
                            <th>FG_Part No.</th>
                            <th>Features</th>
                            <th>Part Name</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <%} %>

                    <tbody id="filter_data">
                        <% foreach (var variant in VariantList)
                            {  %>
                        <tr>
                            <td><%=variant.Variant %></td>
                            <td><%=variant.C5S_7F %></td>
                            <td><%=variant.Seat %></td>
                            <td><%=variant.CustPartNumber %></td>
                            <td><%=variant.FG_PartNumber %></td>
                            <td><%=variant.Features %></td>
                            <td title="<%=variant.PartName %>" data-bs-toggle="tooltip"><%=variant.PartName.Length > 30 ? variant.PartName.Substring(0,20) + "..." : variant.PartName %></td>
                            <td>
                                <div class="btn-group">
                                    <button type="button"
                                        class="btn btn-secondary btn-sm"
                                        onclick="location.href = 'bom/index.aspx?model=<%=variant.Model %>&variant=<%=variant.Variant %>&fg=<%=variant.FG_PartNumber %>&side=<%=variant.Seat %>'">
                                        <img src="image/icon/eye.svg" height="15" />
                                    </button>

                                    <button
                                        type="button"
                                        class="btn btn-primary btn-sm"
                                        onclick="location.href = '/variant/edit.aspx?id=<%=variant.ID %>'">
                                        <img src="image/icon/pencil.svg" height="15" />
                                    </button>

                                    <button
                                        onclick="handleDelete(<%=variant.ID %>)"
                                        type="button"
                                        class="btn btn-danger btn-sm">
                                        <img src="image/icon/trash.svg" height="17" />
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <% } %>

                        <%if (VariantList.Count == 0)
                            { %>
                        <tr>
                            <td colspan="8">
                                <img style="height: 300px; margin: 50px auto;" src="image/empty.png" alt="error" />
                            </td>
                        </tr>
                        <%} %>
                    </tbody>
                </table>
                <br />
            </div>


            <!--Code for Add new Modal popup -->
            <div class="modal fade" id="myModal">
                <div class="modal-dialog" style="width: 400px !important;">
                    <div class="modal-content pb-2">

                        <!-- Modal body -->
                        <div class="modal-body form-container">
                            <%--show error during add model--%>
                            <div id="show_error"></div>
                            <!--model add form-->
                            <div class="d-flex justify-content-center gap-3 mb-2">
                                <div>
                                    <label for="model" class="form-label"><b>Model name:</b></label>
                                    <input id="model_name_input" class="form-control" />
                                </div>
                                <div>
                                    <label for="model" class="form-label"><b>Customer name:</b></label>
                                    <input id="customer_name_input" class="form-control" />
                                </div>
                            </div>
                            <div class="mb-3 ">
                                <label for="partnumber" class="form-label"><b>Part number :</b></label>
                                <input id="part_number_input" class="form-control" />
                            </div>
                            <button type="button" data-bs-dismiss="modal" class="btn btn-danger">Cancel</button>&nbsp;
                                <button onclick="handleAddModel()" class="btn btn-primary" type="button">Submit</button>
                        </div>

                        <script>
                            const handleAddModel = () => {
                                var model_name_input = $("#model_name_input").val()
                                var customer_name_input = $("#customer_name_input").val()
                                var part_number_input = $("#part_number_input").val()
                                if (model_name_input == "") {
                                    $("#show_error").html(`<div class="alert alert-danger">Model name is required.</div>`)
                                } else if (customer_name_input == "") {
                                    $("#show_error").html(`<div class="alert alert-danger">Customer name is required.</div>`)
                                } else if (part_number_input == "") {
                                    $("#show_error").html(`<div class="alert alert-danger">Part number is required.</div>`)
                                } else {
                                    $.ajax({
                                        type: "POST",
                                        url: "index.aspx/ADD_MODEL",
                                        data: `{ model: '${model_name_input}',customer :'${customer_name_input}',partnumber:'${part_number_input}' }`,
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        async: "true",
                                        cache: "false",
                                        success: (res) => {
                                            if (res.d) {
                                                window.location.reload()
                                            } else {
                                                alert("Somthing went wrong.")
                                            }
                                        },
                                        Error: function (x, e) {
                                            console.log(e);
                                        }
                                    })
                                }
                            }
                        </script>

                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>

        // code for check authentication
        if (localStorage.getItem("admin") == null) {
            location.href = "/login.aspx"
        }

        // Initialize tooltips in bootstraph
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        })

        //code for popover 
        var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
        var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
            return new bootstrap.Popover(popoverTriggerEl)
        })

        //code for toast auto close  
        if (document.getElementById("toast").classList.value.split(" ").includes("show")) {
            setTimeout(function () {
                document.getElementById("toast").classList.remove("show")
                    <%CurrentError = "";%>
            }, 3000)
        }



    </script>
</body>
</html>


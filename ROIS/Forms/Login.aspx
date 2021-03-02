<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ROIS.Forms.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ROIS | Login</title>
    <meta name="description" content="Latest updates and statistic charts"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no"/>
    <script src="../scripts/webfont.js"></script>
    <script>
        WebFont.load({
            google: { "families": ["Poppins:300,400,500,600,700", "Roboto:300,400,500,600,700"] },
            active: function () {
                sessionStorage.fonts = true;
            }
        });
    </script>
    <!--end::Web font -->
    <script src="../scripts/jquery-3.3.1.js"></script>
    <!--begin:: Global Mandatory Vendors -->
    <link href="../vendors/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" type="text/css" />
    <!--end:: Global Mandatory Vendors -->

    <!--begin:: Global Optional Vendors -->
    <link href="../vendors/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
    <link href="../vendors/vendors/flaticon/css/flaticon.css" rel="stylesheet" type="text/css" />
    <link href="../vendors/vendors/metronic/css/styles.css" rel="stylesheet" type="text/css" />
    <link href="../vendors/vendors/fontawesome5/css/all.min.css" rel="stylesheet" type="text/css" />

    <!--end:: Global Optional Vendors -->


    <!--begin::Global Theme Styles -->
    <link href="../vendors/assets/vendors/base/vendors.bundle.css" rel="stylesheet" />
    <link href="../vendors/assets/demo/default/base/style.bundle.css" rel="stylesheet" />

    <!--RTL version:<link href="../vendors/assets/demo/base/style.bundle.rtl.css" rel="stylesheet" type="text/css" />-->

    <!--end::Global Theme Styles -->
    <link rel="shortcut icon" href="../vendors/assets/demo/media/img/logo/favicon.ico" />


</head>

<!-- begin::Body -->
<body class="m--skin- m-header--fixed m-header--fixed-mobile m-aside-left--enabled m-aside-left--skin-dark m-aside-left--fixed m-aside-left--offcanvas m-footer--push m-aside--offcanvas-default">

    <!-- begin:: Page -->
    <div class="m-grid m-grid--hor m-grid--root m-page">
        <div class="m-grid__item m-grid__item--fluid m-grid m-grid--hor m-login m-login--signin m-login--2 m-login-2--skin-2" id="m_login" style="background-image: url(../vendors/assets/app/media/img//bg/bg-3.jpg);">
            <div class="m-grid__item m-grid__item--fluid	m-login__wrapper">
                <div class="m-login__container">
                    <div class="m-login__logo">
                        <a href="#">
                            <!--<img src="../vendors/assets/app/media/img/logos/HS Logo.png" height="80%" width="80%"/>-->
                        </a>
                    </div>
                    <div class="m-login__signin">
                        <div class="m-login__head">
                            <h3 class="m-login__title">Receiving and Outgoing Inventory System</h3>
                        </div>
                        <form runat="server" id="form1" class="m-login__form m-form">

                            <div class="form-group m-form__group">
                                <input class="form-control m-input m--align-center" type="text" placeholder="Enter Username" name="empid" autocomplete="off" id="empid" runat="server" />
                                <input class="form-control m-input m--align-center" type="password" placeholder="Enter you password" name="txtPassword" autocomplete="off" id="txtPassword" runat="server" />
                                
                            </div>
                            <br /> 
                           <div class="form-group-lg m--align-center">
                               <select class="form-control m-input m--align-center" id="selectLocation"></select>
                               <br />
                               <button type="button" class="btn btn-focus m-btn m-btn--pill m--align-center m-btn--custom m-btn--air m-login__btn m-login__btn--primary " id="btnSubmit">
                                    <span>Log in</span>
                               </button>
                           </div>
                        
                            <!-- begin::Body -->
                            <div class="m-grid__item m-grid__item--fluid m-grid m-grid--ver-desktop m-grid--desktop m-body">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input class="form-control" id="ip" name="ip" type="text" hidden="hidden" />


    <!-- end:: Page -->

    <!--begin:: Global Mandatory Vendors -->
    <script src="../vendors/jquery/dist/jquery.js" type="text/javascript"></script>
    <%--<script src="../vendors/popper.js/dist/umd/popper.js" type="text/javascript"></scripadt>--%>
    <script src="../vendors/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="../vendors/js-cookie/src/js.cookie.js" type="text/javascript"></script>
    <script src="../vendors/moment/min/moment.min.js" type="text/javascript"></script>
    <%--<script src="../vendors/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>--%>
    <script src="../vendors/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
    <%--<script src="../vendors/wnumb/wNumb.js" type="text/javascript"></script>--%>
    <!--end:: Global Mandatory Vendors -->


    <!--begin:: Global Optional Vendors -->
    <script src="../vendors/jquery-validation/dist/jquery.validate.js" type="text/javascript"></script>
    <script src="../vendors/jquery-validation/dist/additional-methods.js" type="text/javascript"></script>
    <script src="../vendors/autosize/dist/autosize.js" type="text/javascript"></script>
    <script src="../vendors/assets/vendors/base/vendors.bundle.js"></script>
    <script src="../vendors/assets/demo/default/base/scripts.bundle.js"></script>
    <!--end:: Global Optional Vendors -->



    <!--begin::Global Theme Bundle -->
    <script src="../vendors/assets/demo/base/scripts.bundle.js" type="text/javascript"></script>
    <script src="../vendors/assets/demo/custom/components/base/sweetalert2.js"></script>

    <!--end::Global Theme Bundle -->

    <!--begin::Page Scripts -->
    <script src="../vendors/assets/snippets/custom/pages/user/login.js" type="text/javascript"></script>

    <!--end::Page Scripts -->

    <script>
        $(document).ready(function () {
            getLocation();
            checkIfUserLoggedIn();

            function checklogin(username, password, userlocation) {
                if (username != '' && password != '') {
                    $.ajax({
                        url: 'ROISWebService.asmx/UserAuthentication',
                        method: 'post',
                        contentType: "application/json; charset=utf-8",
                        dataType: 'json',
                        data: JSON.stringify({ username: username, userPass: password, userLocation: userlocation }),
                        success: function (data) {
                            let parseId = data[0].AuthResult;
                            let userLocId = $('#selectLocation').val();

                            if (parseId != 0) {
                                sessionStorage.setItem("username", $('#empid').val())
                                localStorage.setItem("sessionUsername", $('#empid').val());
                                sessionStorage.setItem("userId", parseId);
                                sessionStorage.setItem("userLocationId", userLocId);
                                sessionStorage.setItem("userLocDesc", userlocation);
                                sessionStorage.setItem("userPassword", password);
                                $(location).attr('href', 'Home.aspx');
                            }
                            else {
                                swal("Login Failed!", "Kindly try again!", "error");
                            }

                        },
                        Error: function (data) {
                            swal("Login Failed!", "Kindly try again!", "error");
                        }
                    });
                }
                else {
                    swal("Login Failed!", "Please provide username and password!", "error");
                }
            }

            $('#btnSubmit').click(function () {
                checklogin($('#empid').val(), $('#txtPassword').val(), $('#selectLocation option:selected').text())
            });


            $('#txtPassword').keyup(function (event) {
                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13') {
                    checklogin($('#empid').val(), $('#txtPassword').val(), $('#selectLocation option:selected').text())
                }
            });


            $('#empid').keyup(function (event) {
                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13') {
                    checklogin($('#empid').val(), $('#txtPassword').val(), $('#selectLocation option:selected').text())
                }
            });
        });

        function checkIfUserLoggedIn() {
            let existingUser = localStorage.getItem("sessionUsername");

            if (existingUser) {
                $(location).attr('href', 'Home.aspx');
            }

            return;
        }

        function getLocation() {
            let i = 0;
            let sel = document.getElementById("selectLocation");

            let request = new XMLHttpRequest();
            request.open('POST', 'ROISWebService.asmx/GetLoginSelectData');
            request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

            request.onload = function () {
                if (this.status >= 200 && this.status < 400) {
                    let location = JSON.parse(this.responseText);

                    for (i in location) {
                        let opt = document.createElement("option");
                        opt.appendChild(document.createTextNode(location[i].locationDesc));
                        opt.value = location[i].locationId;
                        sel.appendChild(opt);
                    }
                }
                else {

                }
            };

            request.onerror = function () {

            };

            request.send();
        }
    </script>
</body>
</html>


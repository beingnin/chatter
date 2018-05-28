﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="WebApplication2.App.Account.SignIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign In</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="images/icons/favicon.ico" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="css/util.css" />
    <link rel="stylesheet" type="text/css" href="css/main.css" />
</head>
<body>

    <div class="limiter">
        <div class="container-login100">
            <div class="wrap-login100">
                <div class="login100-pic js-tilt" data-tilt>
                    <img src="images/img-01.png" alt="IMG" />
                </div>

                <form id="frmLogin" runat="server" class="login100-form validate-form">
                    <span class="login100-form-title">Member Login
                    </span>

                    <div class="wrap-input100 validate-input" data-validate="Valid email is required: ex@abc.xyz">
                        <asp:TextBox runat="server" ID="txtEmailSI" placeholder="Email" class="input100" />
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                            <i class="fa fa-envelope" aria-hidden="true"></i>
                        </span>
                    </div>

                    <div class="wrap-input100 validate-input" data-validate="Password is required">
                        <%--<input class="input100" type="password" name="pass" placeholder="Password" />--%>
                        <asp:TextBox runat="server" ID="txtPasswordSI" placeholder="Password" class="input100" />
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                            <i class="fa fa-lock" aria-hidden="true"></i>
                        </span>
                    </div>

                    <div class="container-login100-form-btn">
                        <asp:Button ID="btnLogin" CssClass="login100-form-btn" runat="server" Text="Login" OnClick="btnLogin_Click" />
                    </div>

                    <div class="text-center p-t-12">
                        <span class="txt1">Forgot
                        </span>
                        <a class="txt2" href="#">Username / Password?
                        </a>
                    </div>

                    <div class="text-center p-t-136">
                        <a class="txt2" id="btnSignUp" href="#">Not yet joined? Register
							<i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
                        </a>
                    </div>
                </form>


                <%--//Register--%>
                <div id="frmRegister" style="display: none" runat="server" class="login100-form ">
                    <span class="login100-form-title">Create Account
                    </span>

                    <div class="wrap-input100" data-validate="Valid email is required: ex@abc.xyz">
                        <input class="input100" type="text" id="txtEmailSu" name="email" placeholder="Email" />
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                            <i class="fa fa-envelope" aria-hidden="true"></i>
                        </span>
                    </div>

                    <div class="wrap-input100" data-validate="Password is required">
                        <input class="input100" type="password" id="txtPassword1SU" name="pass" placeholder="Password" />
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                            <i class="fa fa-lock" aria-hidden="true"></i>
                        </span>
                    </div>
                    <div class="wrap-input100" data-validate="Password is required">
                        <input class="input100" type="password" id="txtPassword2SU" name="pass" placeholder="Confirm Password" />
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                            <i class="fa fa-lock" aria-hidden="true"></i>
                        </span>
                    </div>

                    <div class="container-login100-form-btn">
                        <button type="button" id="btnRegister" class="login100-form-btn">
                           <i class="fa fa-user-circle"></i>&nbsp;Register
                        </button>
                    </div>

                    <%--                    <div class="text-center p-t-12">
                        <span class="txt1">Forgot
                        </span>
                        <a class="txt2" href="#">Username / Password?
                        </a>
                    </div>--%>

                    <div class="text-center p-t-136">
                        <a class="txt2" id="btnSignIn" href="#">Already have an account? Sign In
							<i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>




    <!--===============================================================================================-->
    <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
    <!--===============================================================================================-->
    <script src="vendor/bootstrap/js/popper.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <!--===============================================================================================-->
    <script src="vendor/select2/select2.min.js"></script>
    <!--===============================================================================================-->
    <script src="vendor/tilt/tilt.jquery.min.js"></script>
    <script>
        $('.js-tilt').tilt({
            scale: 1.1
        });

        $('#btnSignUp').click(function () {
            $('#frmLogin').fadeOut(100, function () {
                $('#frmRegister').fadeIn(100);

            });
        });

        $('#btnSignIn').click(function () {
            $('#frmRegister').fadeOut(100, function () {
                $('#frmLogin').fadeIn(100);

            });
        });

        $('#btnRegister').click(function () {
            
            var user = {};
            user.Email = $('#txtEmailSu').val();
            user.Password = $('#txtPassword2SU').val();
            user.FirstName = 'Nithin';
            $.ajax({
                url: '/api/account/register',
                method: 'POST',
                dataType: 'JSON',
                data:JSON.stringify(user),
                contentType: 'application/json;charset=utf-8',
                beforeSend:function(){
                    $('#btnRegister').children('i').removeClass('fa-user-circle').addClass('fa-spinner fa-spin');
                },
                complete: function () {
                    $('#btnRegister').children('i').removeClass('fa-spinner fa-spin').addClass('fa-user-circle');
                },
                success: function (data) {
                    console.log(data);
                    if (data.Success) {
                        alert('Success');
                    } else {
                        alert('Failed');
                    }

                }

            });
        });

    </script>
    <!--===============================================================================================-->
    <script src="js/main.js"></script>

</body>
</html>
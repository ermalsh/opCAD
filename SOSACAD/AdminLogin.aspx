<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="SoSACAD.AdminLogin"  ValidateRequest="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>SOSA CAD - Computer-aided Dispatch System | Dashboard</title>
    <!-- Favicon-->

<link rel="icon" type="image/png" sizes="96x96" href="assets/images/favicon-96x96.png">

    <!-- Custom Css -->
    <link href="assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="assets/css/main.css" rel="stylesheet">
    <link href="assets/css/authentication.css" rel="stylesheet">

    <!-- adminX You can choose a theme from css/themes instead of get all themes -->
    <link href="assets/css/themes/all-themes.css" rel="stylesheet" />
</head>
    <body class="theme-blue" id="authentication">
        <div class="authentication">
            <div class="container-fluid">
                <div class="row clearfix">
                    <div class="col-xl-9 col-lg-8 col-md-12 p-l-0">
                              <div class="l-detail">
                                      <ul class="list-unstyled l-menu">
                                        <li><a href="#" style="color: #fff; font-weight:900; text-shadow: 3px 3px 3px #333;">Discord</a></li>
                                        <li><a href="#" style="color: #fff; font-weight:900; text-shadow: 3px 3px 3px #333;">Forums</a></li>
                                        <li><a href="#" style="color: #fff; font-weight:900; text-shadow: 3px 3px 3px #333;">Rules</a></li>
                                    </ul>
                                </div>
                    </div>
                    <div class="col-xl-3 col-lg-4 col-md-12 p-r-0">
                        <div class="card position">
                            <h4 class="l-login" style="color: #B1B1B1;">Choose a Login Option below</h4>
                            <asp:Label ID="Label1" runat="server" class="text-danger"></asp:Label>
                            <form runat="server" class="col-md-12" id="sign_in">
                                <div class="panel-group full-body" id="accordion" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-col-grey">
                                        <div class="panel-heading" role="tab" id="headingOne_15">
                                            <h4 class="panel-title"><a data-toggle="collapse" class="collapseBtn" data-parent="#accordion" href="#collapseOne_15">CAD Super Admin Login </a></h4>
                                        </div>
                                        <div id="collapseOne_15" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne_15">
                                            <div class="panel-body">
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <asp:TextBox runat="server" ID="superAdminID" type="text" class="form-control text-white"></asp:TextBox>
                                                        <label class="form-label" style="color: #B1B1B1;">Super Admin ID</label>
                                                    </div>
                                                </div>
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <asp:TextBox runat="server" ID="superAdminPW" type="password" class="form-control text-white"></asp:TextBox>
                                                        <label class="form-label" style="color: #B1B1B1;">Password</label>
                                                    </div>
                                                </div>
                                                <asp:Button ID="Button2" runat="server" UseSubmitBehavior="false" class="btn btn-raised waves-effect" Style="background-color: #333; color: #B1B1B1;" Text="Log In" OnClick="Submit_SA"></asp:Button>
                                                <div class="text-left font-13">For security purposes, your IP Address is logged.</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Jquery Core Js -->
        <script src="assets/bundles/libscripts.bundle.js"></script>
        <!-- Lib Scripts Plugin Js ( jquery.v3.2.1, Bootstrap4 js) -->
        <script src="assets/bundles/vendorscripts.bundle.js"></script>
        <!-- Lib Scripts Plugin Js -->



        <script src="assets/bundles/mainscripts.bundle.js"></script>
        <!-- Custom Js -->
        <script>
            $(document).ready(function () {
                $('.collapseBtn').click(function (e) {
                    $('.collapse').collapse('hide');
                });
            });

            $("form").on("submit", function (event) {
                $(this).serialize();
            });
        </script>
    </body>
</html>

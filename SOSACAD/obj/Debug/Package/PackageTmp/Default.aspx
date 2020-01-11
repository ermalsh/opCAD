<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SoSACAD.Login" EnableEventValidation="true"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>SoSA CAD - Computer-aided Dispatch System | Dashboard</title>
    <!-- Favicon-->
    <link rel="icon" href="favicon.ico" type="image/x-icon">
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
                                <div class="panel-group full-body" id="accordion_13" role="tablist" aria-multiselectable="true">

                                    <div class="panel panel-col-grey">
                                        <div class="panel-heading" role="tab" id="headingOne_13">
                                            <h4 class="panel-title"><a role="button" data-toggle="collapse" data-parent="#accordion_13" href="#collapseOne_13" aria-expanded="true" aria-controls="collapseOne_13">CAD Login </a></h4>
                                        </div>

                                        <div id="collapseOne_13" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne_13">
                                            <div class="panel-body">
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <label class="form-label" style="color: #B1B1B1;">Unit ID</label>
                                                        <asp:TextBox runat="server" ID="unitID" type="text" class="input-block-level form-control text-white"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <label class="form-label" style="color: #B1B1B1;">Password</label>
                                                        <asp:TextBox runat="server" ID="unitPW" type="password" class="input-block-level form-control text-white"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <asp:Button ID="Button1" runat="server" UseSubmitBehavior="false" class="btn btn-raised waves-effect" Style="background-color: #333; color: #B1B1B1;" Text="Log In" OnClick="Submit"></asp:Button>
                                                <div class="text-left"><a href="" style="color: #B1B1B1;">Forgot Password?</a> </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="panel-group full-body" id="accordion_15" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-col-grey">
                                        <div class="panel-heading" role="tab" id="headingOne_15">
                                            <h4 class="panel-title"><a role="button" data-toggle="collapse" data-parent="#accordion_15" href="#collapseOne_15" aria-expanded="true" aria-controls="collapseOne_15">CAD Dispatcher Login </a></h4>
                                        </div>
                                        <div id="collapseOne_15" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne_15">
                                            <div class="panel-body">
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <asp:TextBox runat="server" ID="superID" type="text" class="form-control text-white"></asp:TextBox>
                                                        <label class="form-label" style="color: #B1B1B1;">Unit ID</label>
                                                    </div>
                                                </div>
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <asp:TextBox runat="server" ID="superPW" type="password" class="form-control text-white"></asp:TextBox>
                                                        <label class="form-label" style="color: #B1B1B1;">Password</label>
                                                    </div>
                                                </div>
                                                <asp:Button ID="Button2" runat="server" UseSubmitBehavior="false" class="btn btn-raised waves-effect" Style="background-color: #333; color: #B1B1B1;" Text="Log In" OnClick="Submit_SV"></asp:Button>
                                                <div class="text-left"><a href="" style="color: #B1B1B1;">Forgot Password?</a> </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <hr />

                                <h4 class="l-login" style="color: #B1B1B1;">Civilian Login and Registration</h4>
                                <div class="panel-group full-body" id="accordion_12" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-col-grey">
                                        <div class="panel-heading" role="tab" id="headingOne_12">
                                            <h4 class="panel-title"><a role="button" data-toggle="collapse" data-parent="#accordion_12" href="#collapseOne_12" aria-expanded="true" aria-controls="collapseOne_12">Civilian Login </a></h4>
                                        </div>
                                        <div id="collapseOne_12" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne_12">
                                            <div class="panel-body">
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <label class="form-label" style="color: #B1B1B1;">Username</label>
                                                        <asp:TextBox runat="server" ID="civUser" type="text" class="input-block-level form-control text-white"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <label class="form-label" style="color: #B1B1B1;">Password</label>
                                                        <asp:TextBox runat="server" ID="civPassword" type="password" class="input-block-level form-control text-white"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <asp:Button ID="Button3" runat="server" UseSubmitBehavior="false" class="btn btn-raised waves-effect" Style="background-color: #333; color: #B1B1B1;" Text="Log In" OnClick="SubmitCiv"></asp:Button>
                                                <div class="text-left"><a href="" style="color: #B1B1B1;">Forgot Password?</a> </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-group full-body" id="accordion_11" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-col-grey">
                                        <div class="panel-heading" role="tab" id="headingOne_11">
                                            <h4 class="panel-title"><a role="button" data-toggle="collapse" data-parent="#accordion_11" href="#collapseOne_11" aria-expanded="true" aria-controls="collapseOne_11">Civilian Registration </a></h4>
                                        </div>
                                        <div id="collapseOne_11" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne_11">
                                            <div class="panel-body">
                                                   <div class="panel-body">
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <label class="form-label" style="color: #B1B1B1;">Name</label>
                                                        <asp:TextBox runat="server" ID="civNewName" type="text" class="input-block-level form-control text-white"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <label class="form-label" style="color: #B1B1B1;">Username</label>
                                                        <asp:TextBox runat="server" ID="civNewUsername" type="text" class="input-block-level form-control text-white"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <label class="form-label" style="color: #B1B1B1;">Email</label>
                                                        <asp:TextBox runat="server" ID="civNewEmail" type="email" class="input-block-level form-control text-white"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <label class="form-label" style="color: #B1B1B1;">Password</label>
                                                        <asp:TextBox runat="server" ID="civNewPassword" type="password" class="input-block-level form-control text-white"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <asp:Button ID="Button4" runat="server" UseSubmitBehavior="false" class="btn btn-raised waves-effect" Style="background-color: #333; color: #B1B1B1;" Text="Sign Up" OnClick="Register_Click"></asp:Button>
                                                <div class="text-left"><a href="" style="color: #B1B1B1;">Forgot Password?</a> </div>
                                            </div>
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
        <script>$("form").on("submit", function (event) {
                $(this).serialize();
            });
        </script>
    </body>
</html>

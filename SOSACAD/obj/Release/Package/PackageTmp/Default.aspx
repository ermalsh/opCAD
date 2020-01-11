<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SoSACAD.Login" EnableEventValidation="true" ValidateRequest="true" %>

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
                            <li><a href="https://discord.gg/zHdnVs" style="color: #B1B1B1; font-weight: 900; text-shadow: 3px 3px 3px #333;">Discord</a></li>
                            <li><a href="https://forum.sosarp.net/" style="color: #B1B1B1; font-weight: 900; text-shadow: 3px 3px 3px #333;">Forums</a></li>
                            <li><a href="https://forum.sosarp.net/topic/175/rules-and-regulations-sosa-network-state-of-san-andreas-rpc-2018" style="color: #B1B1B1; font-weight: 900; text-shadow: 3px 3px 3px #333;">Rules</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-xl-3 col-lg-4 col-md-12 p-r-0" style="box-shadow: 0 12px 12px 0 rgba(0, 0, 0, 5), 0 12px 30px 0 rgba(0, 0, 0, 5);">
                    <div class="card position" style="background: rgba(51, 51, 51, .80);">
                        <span class="l-login font-20" style="color: #B1B1B1;">Choose a Login Option below</span>
                        <hr />
                        <asp:Label ID="Label1" runat="server" class="text-danger"></asp:Label>
                        <form runat="server" class="col-md-12" id="sign_in" role="form" data-toggle="validator">
                            <div class="panel-group full-body" id="accordion" role="tablist" aria-multiselectable="true">

                                <asp:Panel ID="leoPanel" runat="server" DefaultButton="LoginLEO">
                                    <div class="panel panel-col-grey">
                                        <div class="panel-heading" role="tab" id="headingOne_13">
                                            <h4 class="panel-title"><a data-toggle="collapse" class="collapseBtn" data-parent="#accordion" href="#collapseOne_13">CAD Login</a></h4>
                                        </div>
                                        <asp:Label ID="Label2" runat="server" class="text-danger"></asp:Label>
                                        <div id="collapseOne_13" class="panel-collapse collapse show" role="tabpanel" aria-labelledby="headingOne_13">
                                            <div class="panel-body">
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <label for="leousername" style="color: #B1B1B1;">Unit ID</label>
                                                        <input id="unitID" name="leousername" title="Letters, Numbers, Period (if necessary) and Space (if necessary) Only. e.g. David R." pattern="[a-zA-Z0-9\s\.\-\|]{1,15}" type="text" class="input-block-level form-control text-white" onChange="check_leo(this.value);"  />
                                                    </div>
                                                </div>
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <label for="leopassword" style="color: #B1B1B1;">Password</label>
                                                        <input id="unitPW" name="leopassword" type="password" class="input-block-level form-control text-white"  />
                                                    </div>
                                                </div>
                                                <div class="text-right">
                                                    <asp:CheckBox ID="GoDispatch" runat="server" Text="Active Dispatch" />
                                                </div>
                                                <asp:Button ID="LoginLEO" disabled="true" name="loginLEO" runat="server" UseSubmitBehavior="true" type="button" class="btn btn-raised waves-effect" Style="background-color: #333; color: #B1B1B1;" OnClick="LeoLoginInit" Text="LOGIN" />
                                            </div>
                                        </div>
                                    </div>
                                </asp:Panel>

                                <asp:Panel ID="civPanel" runat="server" DefaultButton="LoginCIV">
                                    <div class="panel panel-col-grey">
                                        <div class="panel-heading" role="tab" id="headingOne_12">
                                            <h4 class="panel-title"><a data-toggle="collapse" class="collapseBtn" data-parent="#accordion" href="#collapseOne_12">CAD Civilian Login</a></h4>
                                        </div>
                                        <div id="collapseOne_12" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne_12">
                                            <div class="panel-body">
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <label for="civusername" style="color: #B1B1B1;">Username</label>
                                                        <input ID="civUser" name="civusername" title="Letters, Numbers, Period (if necessary) and Space (if necessary) Only. e.g. David R." pattern="[a-zA-Z0-9\s\.]{1,15}" type="text" class="input-block-level form-control text-white" onChange="check_civ(this.value);"/>
                                                    </div>
                                                </div>
                                                <div class="form-group form-float">
                                                    <div class="form-line">
                                                        <label for="civpassword" style="color: #B1B1B1;">Password</label>
                                                        <input ID="civPassword" name="civpassword" type="password" class="input-block-level form-control text-white" "/>
                                                    </div>
                                                </div>
                                                <asp:Button ID="LoginCIV" disabled="true" name="LoginCIV" runat="server" UseSubmitBehavior="true" type="button" class="btn btn-raised waves-effect" Style="background-color: #333; color: #B1B1B1;" Text="Login" OnClick="CivLoginInit"></asp:Button>
                                                <!-- <div class="text-left"><a href="" style="color: #B1B1B1;">Forgot Password?</a> </div>-->
                                            </div>
                                        </div>
                                    </div>
                                </asp:Panel>
                                <hr />

                                <asp:Panel ID="civRegPanel" runat="server" DefaultButton="RegisterCiv">
                                    <div class="panel panel-col-grey">
                                        <div class="panel-heading" role="tab" id="headingOne_11">
                                            <h4 class="panel-title"><a data-toggle="collapse" class="collapseBtn" data-parent="#accordion" href="#collapseOne_11">Civilian Registration </a></h4>
                                        </div>
                                        <div id="collapseOne_11" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne_11">
                                            <div class="panel-body">
                                                <div class="panel-body">
                                                    <div class="form-group form-float">
                                                        <div class="form-line">
                                                            <label class="form-label" style="color: #B1B1B1;">First Name (ex: David)</label>
                                                            <input id="civNewName" name="civNewName" type="text" title="Letters and Space (if necessary) Only. e.g. David" pattern="[a-zA-Z\s]{1,20}" class="input-block-level form-control text-white" onChange="check_regciv(this.value);"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-group form-float">
                                                        <div class="form-line">
                                                            <label class="form-label" style="color: #B1B1B1;">Username (ex: David R. or David)</label>
                                                            <input id="civNewUsername" name="civNewUsername" type="text" title="Letters, Numbers, Period (if necessary) and Space (if necessary) Only. e.g. David R." pattern="[a-zA-Z0-9\s\.]{1,20}" class="input-block-level form-control text-white"  />
                                                        </div>
                                                    </div>
                                                    <div class="form-group form-float">
                                                        <div class="form-line">
                                                            <label class="form-label" style="color: #B1B1B1;">Email</label>
                                                            <input id="civNewEmail" name="civNewEmail" type="email" class="input-block-level form-control text-white"  />
                                                        </div>
                                                    </div>
                                                    <div class="form-group form-float">
                                                        <div class="form-line">
                                                            <label class="form-label" style="color: #B1B1B1;">Password</label>
                                                            <input id="civNewPassword" name="civNewPassword" type="password" class="input-block-level form-control text-white"  />
                                                        </div>
                                                    </div>
                                                    <asp:Button ID="RegisterCiv" disabled="true" runat="server" UseSubmitBehavior="true" class="btn btn-raised waves-effect" Style="background-color: #333; color: #B1B1B1;" Text="Register" OnClick="CivRegisterInit"></asp:Button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </asp:Panel>
                            </div>
                        </form>
                        <span class="font-11" style="color: #B1B1B1;">Note: Some features are only supported on Google Chrome & Steam Browser
                        </span>
                        <span style="color: #B1B1B1; position: absolute; bottom: 0; right: 0; text-align: right;">Beta Version 1.1.80<br />
                            API Version 0.1.28
                                       <br />
                            Developed by Eri S.
                        </span>
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
            function check_leo(username) {
                if (username == "") {
                    $("#LoginLEO").prop("disabled", true);
                } else {
                    $("#LoginLEO").prop("disabled", false);
                }
            }
            function check_civ(username) {
                if (username == "") {
                    $("#LoginCIV").prop("disabled", true);
                } else {
                    $("#LoginCIV").prop("disabled", false);
                }
            }
            function check_regciv(username) {
                if (username == "") {
                    $("#RegisterCiv").prop("disabled", true);
                } else {
                    $("#RegisterCiv").prop("disabled", false);
                }
            }
            $("form").on("submit", function (event) {
                $(this).serialize();
            });
        </script>
        <!-- Global site tag (gtag.js) - Google Analytics -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-114836240-1"></script>
        <script>
            window.dataLayer = window.dataLayer || [];
            function gtag() { dataLayer.push(arguments); }
            gtag('js', new Date());

            gtag('config', 'UA-114836240-1');
        </script>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LEORegister.aspx.cs" Inherits="SoSACAD.LEORegister" %>

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
                            <li><a href="#" style="color: #fff; font-weight: 900; text-shadow: 3px 3px 3px #333;">Discord</a></li>
                            <li><a href="#" style="color: #fff; font-weight: 900; text-shadow: 3px 3px 3px #333;">Forums</a></li>
                            <li><a href="#" style="color: #fff; font-weight: 900; text-shadow: 3px 3px 3px #333;">Rules</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-xl-3 col-lg-4 col-md-12 p-r-0">
                    <div class="card position">
                        <h4 class="l-login" style="color: #B1B1B1;">Choose a Login Option below</h4>
                        <form runat="server" class="col-md-12" id="sign_in">
                            <div class="panel-group full-body" id="accordion_13" role="tablist" aria-multiselectable="true">

                                <div class="panel panel-col-grey">
                                    <div class="panel-heading" role="tab" id="headingOne_13">
                                        <h4 class="panel-title"><a role="button" data-toggle="collapse" data-parent="#accordion_13" href="#collapseOne_13" aria-expanded="true" aria-controls="collapseOne_13">LEO Registration </a></h4>
                                    </div>

                                    <div id="collapseOne_13" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne_13">
                                        <div class="panel-body">
                                            <span>Please fill out all of the required fields:</span>
                                            <hr />
                                            <div class="form-group">
                                                <div class="form-line">
                                                    <asp:TextBox runat="server" ID="unitName" type="text" class="form-control text-white" placeholder="Name"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-line">
                                                    <asp:TextBox runat="server" ID="unitID" type="text" class="form-control text-white" placeholder="Unit ID (Login Username)"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-line">
                                                    <asp:TextBox runat="server" ID="unitPW" type="password" class="form-control text-white" placeholder="Password"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-line">
                                                    <asp:TextBox runat="server" ID="unitEmail" type="email" class="form-control text-white" placeholder="Email Address"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-line">
                                                    <asp:TextBox runat="server" ID="unitNumber" type="text" class="form-control text-white" placeholder="Unit Primary Identifier (ex: B-255)"></asp:TextBox>
                                                </div>
                                                <asp:Button ID="addOne" class="btn btn-raised waves-effect" Style="background-color: #333; color: #B1B1B1;" OnClientClick="return false;">Add Another Identifier</asp:Button>
                                            </div>
                                            <div id="additionalID1" class="form-group">
                                                <div class="form-line">
                                                    <asp:TextBox runat="server" ID="unitDivision" type="text" class="form-control text-white" placeholder="Additional Identifier #1"></asp:TextBox>
                                                </div>
                                                <asp:Button ID="addTwo" class="btn btn-raised waves-effect" Style="background-color: #333; color: #B1B1B1;" OnClientClick="return false;">Add Another Identifier</asp:Button>
                                            </div>
                                            <div id="additionalID2" class="form-group">
                                                <div class="form-line">
                                                    <asp:TextBox runat="server" ID="unitDivision2" type="text" class="form-control text-white" placeholder="Additional Identifier #2"></asp:TextBox>
                                                </div>
                                                <asp:Button ID="addThree" class="btn btn-raised waves-effect" Style="background-color: #333; color: #B1B1B1;" OnClientClick="return false;">Add Another Identifier</asp:Button>
                                            </div>
                                            <div id="additionalID3" class="form-group">
                                                <div class="form-line">
                                                    <asp:TextBox runat="server" ID="unitDivision3" type="text" class="form-control text-white" placeholder="Additional Identifier #3"></asp:TextBox>
                                                </div>
                                                <asp:Button ID="addFour" class="btn btn-raised waves-effect" Style="background-color: #333; color: #B1B1B1;" OnClientClick="return false;">Add Another Identifier</asp:Button>
                                            </div>
                                            <div id="additionalID4" class="form-group">
                                                <div class="form-line">
                                                    <asp:TextBox runat="server" ID="unitDivision4" type="text" class="form-control text-white" placeholder="Additional Identifier #4"></asp:TextBox>
                                                </div>
                                                <asp:Button ID="addFive" class="btn btn-raised waves-effect" Style="background-color: #333; color: #B1B1B1;" OnClientClick="return false;">Add Another Identifier</asp:Button>
                                            </div>
                                            <div id="additionalID5" class="form-group">
                                                <div class="form-line">
                                                    <asp:TextBox runat="server" ID="unitDivision5" type="text" class="form-control text-white" placeholder="Additional Identifier #5"></asp:TextBox>
                                                </div>
                                            </div>
                                            <hr />
                                            <asp:Button ID="Button2" runat="server" class="btn btn-raised waves-effect" Style="background-color: #333; color: #B1B1B1;" Text="Register" OnClick="Register_Click"></asp:Button>
                                            <div class="text-left"><a href="" style="color: #B1B1B1;">Forgot Password?</a> </div>
                                        </div>
                                    </div>
                                </div>
                                <asp:Label ID="Label1" runat="server" class="text-danger"></asp:Label>
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
        $(document).ready(function () {
            $("#additionalID1").hide();
            $("#additionalID2").hide();
            $("#additionalID3").hide();
            $("#additionalID4").hide();
            $("#additionalID5").hide();
        });

        $("#addOne").click(function () {
            $("#addOne").hide();
            $("#additionalID1").show();
        });

        $("#addTwo").click(function () {
            $("#addTwo").hide();
            $("#additionalID2").show();
        });

        $("#addThree").click(function () {
            $("#addThree").hide();
            $("#additionalID3").show();
        });

        $("#addFour").click(function () {
            $("#addFour").hide();
            $("#additionalID4").show();
        });

        $("#addFive").click(function () {
            $("#addFive").hide();
            $("#additionalID5").show();
        });

    </script>
</body>
</html>

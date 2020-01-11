<%@ Page Title="SOSARP" Language="C#" MasterPageFile="~/CivCAD.Master" AutoEventWireup="true" CodeBehind="CivCAD.aspx.cs" Inherits="SoSACAD.CivCAD" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="cadMain" class="content" style="margin: 25px 15px 15px 265px; background-color: #333;">
        <div class="container-fluid  col-offset-6 centered">
            <div class="row clearfix col-lg-12">
                <div class="col-lg-2">
                    <div class="card bg-grey">
                        <h6 class="text-white p-1 font-12 text-center">
                            <img src="assets/images/portraitid.png" class="embed-responsive" />
                            <span class="civFullname d-block"></span>
                            <span class="civLicense d-block"></span>
                        </h6>
                        <div class="col-lg-12">
                            <button class="btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="createCivilian(); return false;">
                                CREATE A CIVILIAN
                            </button>
                        </div>
                        <div class="col-lg-12">
                            <button class="btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="switchCivilian(); return false;">
                                SWITCH CIVILIANS
                            </button>
                        </div>
                        <div class="col-lg-12">
                            <button class="btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="registerVehicle(); return false;">
                                REGISTER VEHICLE
                            </button>
                        </div>
                        <div class="col-lg-12">
                            <button class="btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="return false;">
                                CREATE A TICKET
                            </button>
                        </div>
                        <div class="col-lg-12">
                            <button class="btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="return false;">
                                COURT CASES
                            </button>
                        </div>
                    </div>
                </div>

                <div id="dmvData" class="col-lg-10">
                    <div class="card bg-grey">
                        <div class="col-lg-12">
                            <div class="col-lg-12">
                                <h6 class="text-white p-1 font-16">Department of Motor Vehicle Information</h6>
                                <hr />
                            </div>

                            <div class="col-lg-12">
                                <div class="col-lg-4">
                                    <h6 class="col-lg-4 text-white p-1 font-12 d-block">
                                        <span class="font-underline d-block">First Name </span>
                                        <span class="civFirstName font-12"></span>
                                    </h6>
                                    <h6 class="col-lg-4 text-white p-1 font-12 d-block">
                                        <span class="font-underline d-block">Last Name </span>
                                        <span class="civLastName d-inline-block"></span>
                                    </h6>
                                    <h6 class="col-lg-4 text-white p-1 font-12 d-block">
                                        <span class="font-underline d-block">Date of Birth </span>
                                        <span class="civDOB d-inline-block"></span>
                                    </h6>
                                </div>
                                <div class="col-lg-4">
                                    <h6 class="col-lg-4 text-white p-1 font-12 d-block">
                                        <span class="font-underline d-block">License </span>
                                        <span class="civLicense font-12"></span>
                                    </h6>
                                    <h6 class="col-lg-4 text-white p-1 font-12 d-block">
                                        <span class="font-underline d-block">State </span>
                                        <span class="civState d-inline-block"></span>
                                    </h6>
                                    <h6 class="col-lg-4 text-white p-1 font-12 d-block">
                                        <span class="font-underline d-block">Address </span>
                                        <span class="civAddress d-inline-block"></span>
                                    </h6>
                                </div>
                                <div class="col-lg-4">
                                    <h6 class="col-lg-6 text-white p-1 font-12 d-block">
                                        <span class="font-underline d-block">License Status </span>
                                        <span class="licenseStatus font-12 text-success"></span>
                                    </h6>
                                    <h6 class="col-lg-6 text-white p-1 font-12 d-block">
                                        <span class="font-underline d-block">License Expiration </span>
                                        <span class="licenseExp font-12"></span>
                                    </h6>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row clearfix">
                        <div class="col-lg-6 col-md-8 col-sm-12 ">
                            <div class="card widget-reports bg-grey">
                                <div class="header bg-grey">
                                    <h2>Registered Vehicles</h2>
                                </div>
                                <div class="body bg-grey">
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Plate</th>
                                                    <th>Make</th>
                                                    <th>Model</th>
                                                    <th>Color</th>
                                                    <th>Registration</th>
                                                    <th>Insurance</th>
                                                </tr>
                                            </thead>
                                            <tbody id="myCivVehicles">
                                              
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-8 col-sm-12">
                            <div class="card widget-reports bg-grey">
                                <div class="header bg-grey">
                                    <h2>Tickets and Warnings</h2>
                                </div>
                                <div class="body bg-grey">
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Date</th>
                                                    <th>Location</th>
                                                    <th>Charge</th>
                                                    <th>Fine</th>
                                                    <th>Details</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>432</td>
                                                    <td>06/01/2018</td>
                                                    <td>Davis Avenue</td>
                                                    <td>Speeding</td>
                                                    <td>$450</td>
                                                    <td>Speeding 70 in a 30</td>
                                                </tr>
                                                <tr>
                                                    <td>265</td>
                                                    <td>04/12/2017</td>
                                                    <td>US ROUTE 68</td>
                                                    <td>Warning</td>
                                                    <td>$0</td>
                                                    <td>Illegal U-Turn</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="createACivilian" class="animated slideInDown card bg-grey col-lg-10" style="display: none;">
                    <div class="col-lg-12 text-white">
                        <h6 class="text-white p-1 font-16">Civilian Creation Console</h6>
                        <hr />
                    </div>
                    <div class="row clearfix">
                        <div class="header bg-grey">
                            <h2>Basic Information</h2>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-3">
                                <h5>First Name</h5>
                                <input type="text" class="civCreateFirstName input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Ronnie">
                            </div>
                            <div class="col-lg-3">
                                <h5>Last Name</h5>
                                <input type="text" class="civCreateLastName input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Brazzers">
                            </div>
                            <div class="col-lg-3">
                                <h5>DOB (dd/mm/yyyy)</h5>
                                <input type="text" class="civCreateDOB input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="25/10/1990">
                            </div>
                            <div class="col-lg-3">
                                <h5>Address</h5>
                                <input type="text" class="civCreateAddress input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="716, ROUTE 68, Harmony">
                            </div>
                        </div>
                    </div>


                    <div class="row clearfix">
                        <div class="header bg-grey">
                            <h2>Character Attributes</h2>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-3">
                                <h5>Gender</h5>
                                <input type="text" class="civCreateGender input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Male/Female">
                            </div>
                            <div class="col-lg-3">
                                <h5>Hair</h5>
                                <input type="text" class="civCreateHair input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Black">
                            </div>
                            <div class="col-lg-3">
                                <h5>Ethnicity</h5>
                                <input type="text" class="civCreateEthnicity input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Asian">
                            </div>
                            <div class="col-lg-3">
                                <h5>Weight (lbs)</h5>
                                <input type="text" class="civCreateWeight input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Ex: 250">
                            </div>
                        </div>
                    </div>


                    <div class="row clearfix">
                        <div class="header bg-grey">
                            <h2>DMV Registration</h2>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-3">
                                <h5>License Number (Auto-Generated)</h5>
                                <input type="text" class="civCreateLicenseNumber input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-3">
                                <h5>License State</h5>
                                <input type="text" class="civCreateLicenseState input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="New York">
                            </div>
                            <div class="col-lg-3">
                                <h5>License Expiration (Auto-Generated)</h5>
                                <input type="text" class="civCreateLicenseExp input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-3">
                                <h5>Sign (Full Name)</h5>
                                <input type="text" class="input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Ronnie Brazzers">
                            </div>
                        </div>
                    </div>

                    <hr />

                    <div class="row clearfix">
                        <div class="col-lg-3"></div>
                        <div class="col-lg-3">
                            <button id="cancelCreateBtn" class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="returnToMenu(); return false;">
                                CANCEL
                            </button>
                        </div>
                        <div class="col-lg-3">
                            <button id="createCharacterBtn" class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="createCivilianComplete('<%=Session["User"]%>'); return false;">
                                CREATE
                            </button>
                        </div>
                        <div class="col-lg-3"></div>
                    </div>
                </div>

                <div id="switchCivilian" class="animated slideInDown card bg-grey col-lg-10" style="display: none;">
                    <div class="row clearfix">
                        <div class="col-lg-12 text-white">
                            <h6 class="text-white p-1 font-16">Civilian Selection</h6>
                            <hr />
                            <div id="switchCivilianBtns"></div>
                        </div>
                    </div>
                    <hr />
                    <div class="row clearfix">
                        <div class="col-lg-4"></div>
                        <div class="col-lg-4">
                            <button class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="returnToMenu(); return false;">
                                CANCEL
                            </button>
                        </div>
                        <div class="col-lg-4"></div>
                    </div>
                </div>

                <div id="registerVehicles" class="animated slideInDown card bg-grey col-lg-10" style="display: none;">
                    <div class="col-lg-12 text-white">
                        <h6 class="text-white p-1 font-16">Register a Vehicle</h6>
                        <hr />
                    </div>
                    <div class="col-lg-12">
                        <div class="row clearfix">
                            <div class="header bg-grey">
                                <h2>DMV Vehicle Registration Form</h2>
                            </div>
                            <div class="col-lg-12">
                                <div class="col-lg-2">
                                    <h5>Vehicle Model</h5>
                                    <input type="text" class="vehCreateModel input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="DeClasse">
                                </div>
                                <div class="col-lg-2">
                                    <h5>Vehicle Make</h5>
                                    <input type="text" class="vehCreateMake input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Granger">
                                </div>
                                <div class="col-lg-2">
                                    <h5>Vehicle Color</h5>
                                    <input type="text" class="vehCreateColor input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Pink">
                                </div>
                                <div class="col-lg-3">
                                    <h5>Custom License Plate</h5>
                                    <input type="text" class="vehCreatePlate input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="E4TSH1T">
                                </div>
                                  <div class="col-lg-3">
                                    <h5>Vehicle Owner</h5>
                                    <input type="text" class="vehCreateOwner input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-3"></div>
                            <div class="col-lg-3">
                                <button class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="returnToMenu(); return false;">
                                    CANCEL
                                </button>
                            </div>
                            <div class="col-lg-3">
                                <button class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="registerVehicleComplete(currentCivilianSelected); return false;">
                                    REGISTER
                                </button>
                            </div>
                            <div class="col-lg-3"></div>
                        </div>
                    </div>
                </div>
        </div>
    </section>

    <script>
        var SessionID = '<%=Session["User"]%>';
        window.setInterval(function () {
            loadCivilianData(SessionID);
        }, 5000);
    </script>
</asp:Content>

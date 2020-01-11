<%@ Page Title="SOSARP" Language="C#" MasterPageFile="~/CAD.Master" AutoEventWireup="true" CodeBehind="CAD.aspx.cs" Inherits="SoSACAD.CAD1" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <audio id="mySoundClip" style="display:none;">
<source src="assets/media/alert.ogg" hidden="true" autostart="false" loop="false" class="mySoundClip" type="audio/ogg">
<source src="assets/media/alert.mp3" hidden="true" autostart="false" loop="false" class="mySoundClip" type="audio/mpeg">
</audio>
    !-- main content -->
    <section id="cadMain" class="content" style="margin: 25px 15px 15px 265px; background-color: #333;">
        <div class="container-fluid  col-offset-6 centered">

            <!-- SELECT DIVISION -->
            <div id="selectDivision" class="col-lg-12 row clearfix">
                <div class="col-lg-12">
                    <h3 style="color: #fff" class="text-center">SELECT A DIVISION</h3>
                </div>

                <div class="col-lg-2">
                    <button id="saspDivision" class="toggleDivision btn btn-raised bg-grey btn-block btn-lg waves-effect" onclick="return false;">
                        <img src="assets/images/SASP.png" height="90">
                    </button>
                </div>
                <div class="col-lg-2">
                    <button id="swatDivision" class="toggleDivision btn btn-raised bg-grey btn-block btn-lg waves-effect" onclick="return false;">
                        <img src="assets/images/SOSASWAT.png" height="90">
                    </button>
                </div>
                <div class="col-lg-2">
                    <button id="bcsoDivision" class="toggleDivision btn btn-raised bg-grey btn-block btn-lg waves-effect" onclick="return false;">
                        <img src="assets/images/BCSO.png" height="90">
                    </button>
                </div>
                <div class="col-lg-2">
                    <button id="lspdDivision" class="toggleDivision btn btn-raised bg-grey btn-block btn-lg waves-effect" onclick="return false;">
                        <img src="assets/images/SOSALSPD.png" height="90">
                    </button>
                </div>
                <div class="col-lg-2">
                    <button id="emsDivision" class="toggleDivision btn btn-raised bg-grey btn-block btn-lg waves-effect" onclick="return false;">
                        <img src="assets/images/SOSAEMS.png" height="90">
                    </button>
                </div>
                <div class="col-lg-2">
                    <button id="fireDivision" class="toggleDivision btn btn-raised bg-grey btn-block btn-lg waves-effect" onclick="return false;">
                        <img src="assets/images/SOSAFD.png" height="90">
                    </button>
                </div>
            </div>


            <!-- SELECT SERVER -->
            <div class="col-lg-12 row clearfix">
                <div id="selectServer" class="col-lg-6">
                    <h3 class="text-center" style="color: #fff">SELECT A SERVER</h3>
                    <div class="col-lg-3">
                        <button id="server1" class="toggleServer btn btn-raised bg-grey btn-block waves-effect btn-lg" style="color: #B1B1B1;" onclick="return false;">
                            SERVER 1
                        </button>
                    </div>
                    <div class="col-lg-3">
                        <button id="server2" class="toggleServer btn btn-raised bg-grey btn-block waves-effect btn-lg" style="color: #B1B1B1;" onclick="return false;">
                            SERVER 2
                        </button>
                    </div>
                    <div class="col-lg-3">
                        <button id="server3" class="toggleServer btn btn-raised bg-grey btn-block waves-effect btn-lg" style="color: #B1B1B1;" onclick="return false;">
                            SERVER 3
                        </button>
                    </div>
                    <div class="col-lg-3">
                        <button id="serverTest" class="toggleServer btn btn-raised bg-grey btn-block waves-effect btn-lg" style="color: #B1B1B1;" onclick="return false;">
                            TEST
                        </button>
                    </div>
                </div>

                <!-- SELECT IDENTIFIER -->
                <div id="selectIdentifier" class="col-lg-6">
                    <h3 style="color: #fff" class="text-center">IDENTIFIER</h3>
                    <div id="Identifier" class="col-lg-4">
                        <button id="Identifier1Btn" class="toggleIdentifier bg-grey btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="setIdentifier($(this).text(),'<%=Session["User"]%>'); return false;"></button>
                    </div>
                    <div id="Identifier2" class="col-lg-4" style="visibility: hidden;">
                        <button id="Identifier2Btn" class="toggleIdentifier bg-grey btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="setIdentifier($(this).text(),'<%=Session["User"]%>'); return false;"></button>
                    </div>
                    <div id="Identifier3" class="col-lg-4" style="visibility: hidden;">
                        <button id="Identifier3Btn" class="toggleIdentifier bg-grey btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="setIdentifier($(this).text(),'<%=Session["User"]%>'); return false;"></button>
                    </div>
                    <div id="Identifier4" class="col-lg-4" style="visibility: hidden;">
                        <button id="Identifier4Btn" class="toggleIdentifier bg-grey btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="setIdentifier($(this).text(),'<%=Session["User"]%>'); return false;"></button>
                    </div>
                    <div id="Identifier5" class="col-lg-4" style="visibility: hidden;">
                        <button id="Identifier5Btn" class="toggleIdentifier bg-grey btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="setIdentifier($(this).text(),'<%=Session["User"]%>'); return false;"></button>
                    </div>
                </div>
            </div>
            <hr />

            <div id="startPatrol" class="col-lg-12 row clearfix">
                <div class="col-lg-5">
                </div>
                <div class="col-lg-2">
                    <button id="startPatrolBtn" class="btn btn-raised bg-grey btn-block waves-effect btn-lg" style="color: #B1B1B1;" onclick="this.disabled=true; startPatrol('<%=Session["User"]%>');">
                        START PATROL
                    </button>
                </div>
            </div>

        </div>
    </section>

    <section id="patrolMain" class="content animated bounceInDown" style="margin: 25px 15px 15px 265px; background-color: #333; display: none;">

        <div class="container-fluid">
            <div class="row clearfix">
                <div class="col-lg-2"></div>
                <div class="col-lg-8">
                    <h3 style="color: #fff" class="text-center">PATROL MENU</h3>

                    <div class="col-lg-2">
                        <button id="10Codes" class="bg-grey btn btn-lg btn-raised waves-effect btn-block" style="color: #B1B1B1;" onclick="open10Codes(); return false;">
                            10 CODES LIST
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button id="patrolMapBtn" class="bg-grey btn btn-lg btn-raised waves-effect btn-block" style="color: #B1B1B1;" onclick="openPatrolMap(); return false;">
                            PATROL MAP
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button id="penalCodes" class="bg-grey btn btn-lg btn-raised waves-effect btn-block" style="color: #B1B1B1;" onclick="openPenalCodes(); return false;">
                            PENAL CODES
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button id="notepad" class="bg-grey btn btn-lg btn-raised waves-effect btn-block" style="color: #B1B1B1;" onclick="openNotepad(); return false;">
                            NOTEPAD
                        </button>
                    </div>
                    <div class="col-lg-4">
                        <button class="bg-grey btn btn-lg btn-raised waves-effect btn-block" style="color: #B1B1B1;" onclick="logOff(); return false;">
                            LOG OFF TO DASHBOARD
                        </button>
                    </div>
                </div>
                <div class="col-lg-2"></div>
            </div>
            <hr />
            <!--10 CODES-->
            <div class="row clearfix">
                <div class="col-lg-6">
                    <div id="unitConsole" class="row clearfix card bg-grey animated fadeIn">
                        <div class="header bg-grey">
                            <h2>UNIT CONSOLE - <span id="currentPatrolStatus"></span></h2>
                        </div>
                        <div class="body">
                            <h4 style="color: #B1B1B1;"><span id="UnitNumber"></span>&nbsp;<span id="UnitName"></span>&nbsp;|&nbsp;<span id="CurrentStatus"></span></h4>
                            <div class="row clearfix">
                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                    <button id="105button" type="button" class="toggleStatus btn btn-raised bg-grey-btn btn-block btn-lg waves-effect" onclick="updateStatus105('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-5</span></button>
                                </div>
                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                    <button id="106button" type="button" class="toggleStatus btn btn-raised bg-grey-btn btn-block btn-lg waves-effect" onclick="updateStatus106('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-6</span></button>
                                </div>
                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                    <button id="107button" type="button" class="toggleStatus btn btn-raised bg-grey-btn btn-block btn-lg waves-effect" onclick="updateStatus107('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-7</span></button>
                                </div>
                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                    <button id="108button" type="button" class="toggleStatus btn btn-raised bg-grey-btn btn-block btn-lg waves-effect" onclick="updateStatus108('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-8</span></button>
                                </div>
                            </div>
                            <div class="row clearfix">
                                <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                                    <button id="1041button" type="button" class="toggleStatus btn btn-raised bg-grey-btn btn-block btn-lg waves-effect" onclick="updateStatus1041('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-41</span></button>
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                                    <button id="1042button" type="button" class="toggleStatus btn btn-raised bg-grey-btn btn-block btn-lg waves-effect" onclick="updateStatus1042('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-42</span></button>
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                                    <button id="1023button" type="button" class="toggleStatus btn btn-raised bg-grey-btn btn-block btn-lg waves-effect" onclick="updateStatus1023('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-23</span></button>
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                                    <button id="1097button" type="button" class="toggleStatus btn btn-raised bg-grey-btn btn-block btn-lg waves-effect" onclick="updateStatus1097('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-97</span></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-12 col-sm-12">
                    <div id="activeCalls" class="row clearfix card bg-grey animated fadeIn">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="card bg-grey">
                                <div class="header bg-grey">
                                    <h2>MY CALLS</h2>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-condensed">
                                        <thead>
                                            <tr>
                                                <th style="color: #B1B1B1;">ID #</th>
                                                <th style="color: #B1B1B1;">Caller</th>
                                                <th style="color: #B1B1B1;">Location</th>
                                                <th style="color: #B1B1B1;">Date & Time</th>
                                                <th style="color: #B1B1B1;">Description</th>
                                                <th style="color: #B1B1B1;">Officer</th>
                                                <th style="color: #B1B1B1;">Status</th>
                                            </tr>
                                        </thead>
                                        <tbody id="ActiveCallsData">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row clearfix">
                    <div class="col-lg-6">
                        <div id="civilianLookup" class="row clearfix card bg-grey animated fadeIn">
                            <div class="header bg-grey">
                                <h2>NCIC Lookup</h2>
                            </div>
                            <div class="row clearfix">
                                <div class="col-lg-6">
                                    <div class="m-l-20">
                                        <label for="nameLookup">Name</label>
                                        <input id="nameLookup" type="text" class="input-block-level form-control bg-grey2 text-center" style="color: #B1B1B1; min-width: 100%!important;">
                                        <button type="button" class="pull-right btn btn-raised bg-grey-btn btn-sm waves-effect text-white" onclick="searchCiv($('#nameLookup').val());">Search</button>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="m-r-20">
                                        <label for="plateLookup">License Plate Number</label>
                                        <input id="plateLookup" type="text" class="input-block-level form-control bg-grey2 text-center" style="color: #B1B1B1; min-width: 100%!important;">
                                        <button type="button" class="pull-right btn btn-raised bg-grey-btn btn-sm waves-effect text-white" onclick="searchVeh($('#plateLookup').val());">Search</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr />
                    </div>
                </div>
            </div>
            <div id="civDetails" style="display: none;">
                <div class="row clearfix m-t-10 p-r-10">
                    <div id="btnsCivDetails" class="col-lg-3 m-t-10">
                        <button type="button" class="btn btn-raised bg-grey btn-block btn-lg waves-effect" style="color: #B1B1B1;">CREATE WARRANT</button>
                        <button type="button" class="btn btn-raised bg-grey btn-block btn-lg waves-effect" style="color: #B1B1B1;">ARREST REPORT</button>
                        <button type="button" class="btn btn-raised bg-grey btn-block btn-lg waves-effect" style="color: #B1B1B1;">WRITE CITATION</button>
                        <button type="button" class="btn btn-raised bg-grey btn-block btn-lg waves-effect" style="color: #B1B1B1;">ISSUE WARNING</button>
                    </div>

                    <div class="col-lg-9 bg-grey">
                        <h2 class="font-18 text-center">DETAILS</h2>
                        <div class="col-lg-6 font-14" style="color: #B1B1B1!important;">
                            <span class="d-block">FIRST NAME: <span class="firstName upper"></span></span>
                            <span class="d-block">LAST NAME: <span class="lastName upper"></span></span>
                            <span class="d-block">DOB: <span class="dob upper"></span></span>
                            <span class="d-block">ADDRESS: <span class="address upper"></span></span>


                            <h2 class="font-18">PHOTO</h2>
                            <div class="col-lg-6 font-14 bg-white">
                                <img src="assets/images/portraitid.png" class="embed-responsive" />
                            </div>
                        </div>
                        <div class="col-lg-6 font-14" style="color: #B1B1B1!important;">

                            <span class="d-block">GENDER: <span class="gender upper"></span></span>
                            <span class="d-block">HAIR: <span class="hair upper"></span></span>
                            <span class="d-block">ETHNICITY: <span class="ethnicity upper"></span></span>
                            <span class="d-block">WEIGHT (lbs): <span class="weight upper"></span></span>

                            <h2 class="font-18">LICENSE STATUS</h2>
                            <div class="col-lg-12 font-14" style="color: #B1B1B1!important;">
                                <span id="licenseStatus" class="d-block font-20 m-b-5"><span class="licenseStatus upper"></span></span>
                                <span class="d-block">EXPIRATION: <span class="licenseExp upper"></span></span>
                                <span class="d-block">STATE: <span class="licenseState upper"></span></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row clearfix m-t-10 p-r-10 p-l-10">
                    <div class="col-lg-12 bg-grey scrollbar style-1">
                        <h2 class="font-18">WARRANTS</h2>
                        <div class="table-responsive force-overflow">
                            <table class="table table-condensed">
                                <thead>
                                    <tr>
                                        <th style="color: #B1B1B1;">ID</th>
                                        <th style="color: #B1B1B1;">Issued</th>
                                        <th style="color: #B1B1B1;">Charges</th>
                                        <th style="color: #B1B1B1;">Status</th>
                                        <th style="color: #B1B1B1;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class='priorWarrants'>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-lg-12 bg-grey scrollbar style-1">
                        <h2 class="font-18">TRAFFIC PRIORS</h2>
                        <div class="table-responsive force-overflow">
                            <table class="table table-condensed">
                                <thead>
                                    <tr>
                                        <th style="color: #B1B1B1;">ID</th>
                                        <th style="color: #B1B1B1;">Citation</th>
                                        <th style="color: #B1B1B1;">Location</th>
                                        <th style="color: #B1B1B1;">Officer</th>
                                        <th style="color: #B1B1B1;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class='priorTraffic'>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-lg-12 bg-grey scrollbar style-1">
                        <h2 class="font-18">ARREST PRIORS</h2>
                        <div class="table-responsive force-overflow">
                            <table class="table table-condensed">
                                <thead>
                                    <tr>
                                        <th style="color: #B1B1B1;">ID</th>
                                        <th style="color: #B1B1B1;">Details</th>
                                        <th style="color: #B1B1B1;">Charges</th>
                                        <th style="color: #B1B1B1;">Officer</th>
                                        <th style="color: #B1B1B1;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class='priorArrests'>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>


        <div id="warrantForm" style="display: none;">
            <div class="row cleafix col-lg-12">
                <div class="col-lg-12">
                    <h4>STATE OF SAN ANDREAS
                        <br />
                        WARRANT FORM</h4>
                    <div class="row clearfix">
                        <div class="col-lg-4">
                            <h5>Full Name</h5>
                            <input type="text" class="fullName input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                         <div class="col-lg-4">
                            <h5>License Number</h5>
                            <input type="text" class="licenseNumber input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                         <div class="col-lg-4">
                            <h5>License State</h5>
                            <input type="text" class="licenseState input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                    </div>
                     <div class="row clearfix">
                        <div class="col-lg-4">
                            <h5>Warrant Issued</h5>
                            <input type="text" class="warrantDateIssued input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                         <div class="col-lg-4">
                            <h5>Department</h5>
                            <input type="text" class="warrantDepartment input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                        </div>
                         <div class="col-lg-4">
                            <h5>Officer (ex: B-204)</h5>
                            <input type="text" class="warrantOfficer input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                        </div>
                    </div>
                     <div class="row clearfix">
                        <div class="col-lg-12">
                            <h5>Charges</h5>
                            <textarea rows="10" class="warrantCharges input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;"></textarea>
                        </div>
                    </div>

                </div>
            </div>
        </div>

         <div id="arrestForm" style="display: none;">
            <div class="row cleafix col-lg-12">
                <div class="col-lg-12">
                    <h4>STATE OF SAN ANDREAS
                        <br />
                        ARREST FORM</h4>
                    <div class="row clearfix">
                        <div class="col-lg-4">
                            <h5>Full Name</h5>
                            <input type="text" class="fullName input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                         <div class="col-lg-4">
                            <h5>License Number</h5>
                            <input type="text" class="licenseNumber input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                         <div class="col-lg-4">
                            <h5>License State</h5>
                            <input type="text" class="licenseState input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                    </div>
                     <div class="row clearfix">
                        <div class="col-lg-4">
                            <h5>Arrested On</h5>
                            <input type="text" class="arrestDateIssued input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                         <div class="col-lg-4">
                            <h5>Location</h5>
                            <input type="text" class="arrestLocation input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                        </div>
                         <div class="col-lg-4">
                            <h5>Officer (ex: B-204)</h5>
                            <input type="text" class="arrestOfficer input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                        </div>
                    </div>
                     <div class="row clearfix">
                        <div class="col-lg-12">
                            <h5>Arrest Details</h5>
                            <textarea rows="5" class="arrestDetails input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;"></textarea>
                        </div>
                    </div>
                     <div class="row clearfix">
                        <div class="col-lg-12">
                            <h5>Charges</h5>
                            <textarea rows="5" class="arrestCharges input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;"></textarea>
                        </div>
                    </div>
                    <div class="row clearfix">
                        <div class="col-lg-4"></div>
                        <div class="col-lg-4">
                            <h5>Fine Total</h5>
                            <input type="text" class="arrestFines input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                        </div>
                         <div class="col-lg-4">
                            <h5>Jail Time
                            </h5>
                            <input type="text" class="arrestJailTime input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                        </div>
                    </div>
                </div>
            </div>
        </div>

           <div id="ticketForm" style="display: none;">
            <div class="row cleafix col-lg-12">
                <div class="col-lg-12">
                    <h4>STATE OF SAN ANDREAS
                        <br />
                        CITATION FORM</h4>
                    <div class="row clearfix">
                        <div class="col-lg-4">
                            <h5>Full Name</h5>
                            <input type="text" class="fullName input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                         <div class="col-lg-4">
                            <h5>License Number</h5>
                            <input type="text" class="licenseNumber input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                         <div class="col-lg-4">
                            <h5>License State</h5>
                            <input type="text" class="licenseState input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                    </div>
                     <div class="row clearfix">
                        <div class="col-lg-4">
                            <h5>Date</h5>
                            <input type="text" class="ticketDateIssued input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                         <div class="col-lg-4">
                            <h5>Location</h5>
                            <input type="text" class="ticketLocation input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                        </div>
                         <div class="col-lg-4">
                            <h5>Officer (ex: B-204)</h5>
                            <input type="text" class="ticketOfficer input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                        </div>
                    </div>
                     <div class="row clearfix">
                        <div class="col-lg-12">
                            <h5>Ticket Details</h5>
                            <textarea rows="5" class="ticketDetails input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;"></textarea>
                        </div>
                    </div>
                     <div class="row clearfix">
                        <div class="col-lg-12">
                            <h5>Charges</h5>
                            <textarea rows="5" class="ticketCharges input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;"></textarea>
                        </div>
                    </div>
                    <div class="row clearfix">
                        <div class="col-lg-4"></div>
                        <div class="col-lg-4"></div>
                        <div class="col-lg-4">
                            <h5>Fine Total</h5>
                            <input type="text" class="ticketFines input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                        </div>
                    </div>
                </div>
            </div>
        </div>

            <div id="warningForm" style="display: none;">
            <div class="row cleafix col-lg-12">
                <div class="col-lg-12">
                    <h4>STATE OF SAN ANDREAS
                        <br />
                        WARNING FORM</h4>
                    <div class="row clearfix">
                        <div class="col-lg-4">
                            <h5>Full Name</h5>
                            <input type="text" class="fullName input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                         <div class="col-lg-4">
                            <h5>License Number</h5>
                            <input type="text" class="licenseNumber input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                         <div class="col-lg-4">
                            <h5>License State</h5>
                            <input type="text" class="licenseState input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                    </div>
                     <div class="row clearfix">
                        <div class="col-lg-4">
                            <h5>Date</h5>
                            <input type="text" class="warningDateIssued input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                        </div>
                         <div class="col-lg-4">
                            <h5>Location</h5>
                            <input type="text" class="warningLocation input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                        </div>
                         <div class="col-lg-4">
                            <h5>Officer (ex: B-204)</h5>
                            <input type="text" class="warningOfficer input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                        </div>
                    </div>
                     <div class="row clearfix">
                        <div class="col-lg-12">
                            <h5>Ticket Details</h5>
                            <textarea rows="5" class="warningDetails input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script>
        var SessionID = '<%=Session["User"]%>';
        var OnPatrol = '<%=Session["OnPatrol"]%>';

        window.setInterval(function () {
            loadUnitData(SessionID);
        }, 5000);
    </script>
</asp:Content>

<%@ Page Title="SOSARP" Language="C#" MasterPageFile="~/CAD.Master" AutoEventWireup="true" CodeBehind="CAD.aspx.cs" Inherits="SoSACAD.CAD1" ValidateRequest="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <audio id="mySoundClip" style="display: none;">
        <source src="assets/media/alert.ogg" class="mySoundClip" type="audio/ogg">
        <source src="assets/media/alert.mp3" class="mySoundClip" type="audio/mpeg">
    </audio>
    <audio id="mySoundClip2" style="display: none;">
        <source src="assets/media/police1099tone.mp3" class="mySoundClip2" type="audio/mpeg">
    </audio>

    <section id="cadMain" class="content" style="margin: -8px 15px 15px 265px; background-color: #333;">
        <div class="container-fluid">
            <!-- LEADER BOARDS -->
            <div class="col-lg-12">
                <h3 style="color: #fff" class="text-center">SOSA CAD LEADERBOARDS (BETA)</h3>
            </div>
           
            <div class="clearfix col-sm-12 col-md-6 col-lg-3">
                <div class="card info-box-3 bg-grey">
                    <div id="slide1" class="carousel slide updates-feed" data-interval="3500" data-ride="carousel">
                        <div id="arrestsLeaders" class="carousel-inner" role="listbox">
                            <div class="item row text-center ">
                                <div class="col-sm-12"><i class="zmdi zmdi-star font-30"></i></div>
                                <div class="col-sm-12">
                                    <p class="font-20"><span class="h6 font-20">TOP 10 ARRESTS MADE</span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix col-sm-12 col-md-6 col-lg-3">
                <div class="card info-box-3 bg-grey">
                    <div id="slide2" class="carousel slide updates-feed" data-interval="3500" data-ride="carousel">
                        <div id="ticketsLeaders" class="carousel-inner" role="listbox">
                            <div class="item row text-center active">
                                <div class="col-sm-12"><i class="zmdi zmdi-star font-30"></i></div>
                                <div class="col-sm-12">
                                    <p class="font-20"><span class="h6 font-20">TOP 10 CITATIONS ISSUED</span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix col-sm-12 col-md-6 col-lg-3">
                <div class="card info-box-3 bg-grey">
                    <div id="slide3" class="carousel slide updates-feed" data-interval="3500" data-ride="carousel">
                        <div id="warrantsLeaders" class="carousel-inner" role="listbox">
                            <div class="item row text-center active">
                                <div class="col-sm-12"><i class="zmdi zmdi-star font-30"></i></div>
                                <div class="col-sm-12">
                                    <p class="font-20"><span class="h6 font-20">TOP 10 WARRANTS ISSUED</span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix col-sm-12 col-md-6 col-lg-3">
                <div class="card info-box-3 bg-grey">
                    <div id="slide4" class="carousel slide updates-feed" data-interval="3500" data-ride="carousel">
                        <div id="callsLeaders" class="carousel-inner" role="listbox">
                            <div class="item row text-center active">
                                <div class="col-sm-12"><i class="zmdi zmdi-star font-30"></i></div>
                                <div class="col-sm-12">
                                    <p class="font-20"><span class="h6 font-20">TOP 10 CALLS RESPONDED</span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- SELECT DIVISION -->
            <div id="selectDivision" class="col-lg-12 row clearfix">
                <div class="col-lg-12">
                    <h3 style="color: #fff" class="text-center">SELECT A DIVISION</h3>
                </div>

                <div class="col-sm-3 col-md-5 col-lg-2">
                    <button id="SAHPDivision" class="toggleDivision btn btn-raised bg-grey btn-block btn-lg waves-effect" onclick="SAHPClicked('<%=Session["User"]%>'); return false;">
                        <img src="assets/images/SAHP.png" height="90">
                    </button>
                </div>
                <div class="col-sm-3 col-md-5 col-lg-2">
                    <button id="swatDivision" class="toggleDivision btn btn-raised bg-grey btn-block btn-lg waves-effect" onclick="swatClicked('<%=Session["User"]%>'); return false;">
                        <img src="assets/images/SOSASWAT.png" height="90">
                    </button>
                </div>
                <div class="col-sm-3 col-md-5 col-lg-2">
                    <button id="bcsoDivision" class="toggleDivision btn btn-raised bg-grey btn-block btn-lg waves-effect" onclick="bcsoClicked('<%=Session["User"]%>'); return false;">
                        <img src="assets/images/BCSO.png" height="90">
                    </button>
                </div>
                <div class="col-sm-3 col-md-5 col-lg-2">
                    <button id="lspdDivision" class="toggleDivision btn btn-raised bg-grey btn-block btn-lg waves-effect" onclick="lspdClicked('<%=Session["User"]%>'); return false;">
                        <img src="assets/images/SOSALSPD.png" height="90">
                    </button>
                </div>
                <div class="col-sm-3 col-md-5 col-lg-2">
                    <button id="emsDivision" class="toggleDivision btn btn-raised bg-grey btn-block btn-lg waves-effect" onclick="emsClicked('<%=Session["User"]%>'); return false;">
                        <img src="assets/images/SOSAEMS.png" height="90">
                    </button>
                </div>
                <div class="col-sm-3 col-md-5 col-lg-2">
                    <button id="fireDivision" class="toggleDivision btn btn-raised bg-grey btn-block btn-lg waves-effect" onclick="safdClicked('<%=Session["User"]%>'); return false;">
                        <img src="assets/images/SOSAFD.png" height="90">
                    </button>
                </div>
            </div>


            <!-- SELECT SERVER -->
            <div class="col-lg-12 row clearfix">
                <div id="selectServer" class="col-lg-6">
                    <h3 class="text-center" style="color: #fff">SELECT A SERVER</h3>
                    <div class="col-lg-4">
                        <button id="server1" class="toggleServer btn btn-raised bg-grey btn-block waves-effect btn-lg" style="color: #B1B1B1;" onclick="return false;">
                            S1 Public
                        </button>
                    </div>
                    <div class="col-lg-4">
                        <button id="server2" class="toggleServer btn btn-raised bg-grey btn-block waves-effect btn-lg" style="color: #B1B1B1;" onclick="return false;">
                            S2 Whitelist
                        </button>
                    </div>
                    <div class="col-lg-4">
                        <button id="server3" class="toggleServer btn btn-raised bg-grey btn-block waves-effect btn-lg" style="color: #B1B1B1;" onclick="return false;">
                            TESTING
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



    <section id="patrolMain" class="content animated bounceInDown" style="margin-top: -8px; background-color: #333; display: none;">
        <!--Voice Menu-->
        <div id="voipPanel" class="panel-group">
            <div class="panel panel-col-grey">

                <div id="collapse1" class="panel-collapse collapse">
                    <div class="panel-body font-14">
                        <h6 class="text-white">Voice Status: <span id="currentStatusRTO" class="text-success">Umuted</span></h6>
                        <hr />
                        <div class="col-lg-12 make-center">
                            <div class="card row clearfix bg-grey2 col-lg-12">
                                <br />
                                <span class="">Channel Info & Units</span>
                                <hr />
                                <span class="text-warning d-block">You can Mute/Unmute the RTO by CTRL+M</span><br />
                                <div id="audios-container"></div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel-heading">
                    <h6 class="panel-title">
                        <a data-toggle="collapse" href="#collapse1">Mobile Radio System <i class="material-icons pull-right font-30">perm_phone_msg</i></a>
                    </h6>
                </div>
            </div>
        </div>
        <!--End voice menu -->

        <div class="container-fluid">
            <div class="row clearfix">
                <div class="col-lg-12">
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
                        <button id="penalCodesCheat" class="bg-grey btn btn-lg btn-raised waves-effect btn-block" style="color: #B1B1B1;" onclick="openPenalCodesCheat(); return false;">
                            CHEAT SHEET
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button id="notepad" class="bg-grey btn btn-lg btn-raised waves-effect btn-block" style="color: #B1B1B1;" onclick="openNotepad(); return false;">
                            NOTEPAD
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button class="bg-grey btn btn-lg btn-raised waves-effect btn-block" style="color: #B1B1B1;" onclick="logOff(); return false;">
                            CLOCK OUT
                        </button>
                    </div>
                </div>
            </div>
            <hr />
            <!--10 CODES-->
            <div class="row clearfix">
                <div class="col-lg-6">
                    <div id="unitConsole" class="row clearfix card bg-grey">
                        <div class="header bg-grey">
                            <h2>
                                <span id="UnitNumber"></span>&nbsp;<span id="UnitName"></span>&nbsp;|&nbsp;<span id="CurrentStatus"></span> - <span id="currentPatrolStatus"></span></h2>
                            <br />
                            <div class="pull-right">
                                <span id="1019button" class="bg-grey2 label label-default m-b-5" style="color: #B1B1B1; cursor: pointer;" onclick="updateStatus1019('<%=Session["User"]%>'); return false;">10-19</span>
                                <span id="1012button" class="bg-grey2 label label-default m-b-5" style="color: #B1B1B1; cursor: pointer;" onclick="updateStatus1012('<%=Session["User"]%>'); return false;">10-12</span>
                                <span id="1011button" class="bg-grey2 label label-default m-b-5" style="color: #B1B1B1; cursor: pointer;" onclick="updateStatus1011('<%=Session["User"]%>'); return false;">10-11</span>
                                <span id="signal11" class="bg-grey2 label label-default m-b-5" style="color: #B1B1B1; cursor: pointer;" onclick="updateStatusSignal11('<%=Session["User"]%>'); return false;">SIGNAL 11</span>
                                <span id="codezero" class="bg-grey2 label label-default m-b-5" style="color: #B1B1B1; cursor: pointer;" onclick="updateStatusCodeZero('<%=Session["User"]%>'); return false;">Code Zero</span>
                                <span id="clearcodes" class="bg-grey2 label label-default m-b-5" style="color: #B1B1B1; cursor: pointer;" onclick="updateStatus108('<%=Session["User"]%>'); return false;">Clear</span>
                            </div>
                        </div>

                        <div class="body">

                            <div class="row clearfix">
                                <div class="col-xs-6 col-sm-6 col-md-3 col-lg-3">
                                    <button id="105button" type="button" class="toggleStatus btn btn-raised bg-grey-btn btn-block btn-lg waves-effect" onclick="updateStatus105('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-5</span></button>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-3 col-lg-3">
                                    <button id="106button" type="button" class="toggleStatus btn btn-raised bg-grey-btn btn-block btn-lg waves-effect" onclick="updateStatus106('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-6</span></button>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-3 col-lg-3">
                                    <button id="107button" type="button" class="toggleStatus btn btn-raised bg-grey-btn btn-block btn-lg waves-effect" onclick="updateStatus107('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-7</span></button>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-3 col-lg-3">
                                    <button id="108button" type="button" class="toggleStatus btn btn-raised bg-grey-btn btn-block btn-lg waves-effect" onclick="updateStatus108('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-8</span></button>
                                </div>
                            </div>
                            <div class="row clearfix">

                                <div class="col-xs-6 col-sm-6 col-md-4 col-lg-4">
                                    <button id="1015button" type="button" class="toggleStatus btn btn-raised bg-grey-btn btn-block btn-lg waves-effect" onclick="updateStatus1015('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-15</span></button>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-4 col-lg-4">
                                    <button id="1023button" type="button" class="toggleStatus btn btn-raised bg-grey-btn btn-block btn-lg waves-effect" onclick="updateStatus1023('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-23</span></button>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-4 col-lg-4">
                                    <button id="1097button" type="button" class="toggleStatus btn btn-raised bg-grey-btn btn-block btn-lg waves-effect" onclick="updateStatus1097('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-97</span></button>
                                </div>

                            </div>
                            <div class="row clearfix">
                                <div class="col-xs-6 col-sm-6 col-md-3 col-lg-6">
                                    <button id="1041button" type="button" class="toggleStatus btn btn-raised bg-grey2 btn-block btn-lg waves-effect" onclick="updateStatus1041('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-41</span></button>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-3 col-lg-6">
                                    <button id="1042button" type="button" class="toggleStatus btn btn-raised bg-darkred btn-block btn-lg waves-effect" onclick="updateStatus1042('<%=Session["User"]%>');"><span class="text-white text-lg-center">10-42</span></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div id="civilianLookup" class="row clearfix card bg-grey">
                        <div class="header bg-grey">
                            <h2>NCIC Lookup</h2>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-6 p-3">

                                <label for="nameLookup">Name</label>
                                <input id="nameLookup" type="text" class="input-block-level form-control bg-grey2 text-center" style="color: #B1B1B1; min-width: 100%!important;">
                                <button type="button" class="pull-right btn btn-raised bg-grey-btn btn-sm waves-effect text-white" onclick="searchCiv($('#nameLookup').val());">Search</button>
                            </div>
                            <div class="col-lg-6 p-3">
                                <label for="plateLookup">License Plate Number</label>
                                <input id="plateLookup" type="text" class="input-block-level form-control bg-grey2 text-center" style="color: #B1B1B1; min-width: 100%!important;">
                                <button type="button" class="pull-right btn btn-raised bg-grey-btn btn-sm waves-effect text-white" onclick="searchVeh($('#plateLookup').val());">Search</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row clearfix card bg-grey ">
                <div id="activeCalls">
                    <div class="col-lg-12">
                        <div class="header bg-grey">
                            <h2>MY CALLS & BOLOS</h2>
                            <span id="toggleBolosBtn" class="col-lg-2 bg-grey2 label pull-right m-r-10" style="color: #B1B1B1; cursor: pointer;" onclick="toggleBolos();  return false;">Toggle Bolos
                            </span>
                        </div>
                        <hr />
                        <div id="boloVehicleCallsCard" class="col-lg-6 col-lg-6 col-sm-6">
                            <div class="card info-box-4 bg-grey2 ">
                                <div class="body text-white scrollbarActiveCAD style-1">
                                    <h6 class="text-center">Vehicle Bolos</h6>
                                    <div id="boloVehicleCalls">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="boloCallsCard" class="col-lg-6 col-lg-6 col-sm-6">
                            <div class="card info-box-4 bg-grey2 ">
                                <div class="body text-white scrollbarActiveCAD style-1">
                                    <h6 class="text-center">Person Bolos</h6>
                                    <div id="boloCalls">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="ActiveCallsDataCard" class="col-lg-6 col-lg-6 col-sm-6">
                            <div class="card info-box-4 bg-grey2">
                                <div class="body text-white scrollbarActiveCAD style-1">
                                    <h6 class="text-center">Active Calls</h6>
                                    <div id="ActiveCallsData">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="historyCallsDataCard" class="col-lg-6 col-lg-6 col-sm-6">
                            <div class="card info-box-4 bg-grey2 ">
                                <div class="body text-white scrollbarActiveCAD style-1">
                                    <h6 class="text-center">Call History</h6>
                                    <div id="historyCallsData">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
                    <h2 class="font-24">PHOTO ID</h2>
                    <div class="col-lg-6 font-14" style="color: #B1B1B1!important;">
                        <div class="col-lg-12 font-14 idContainer">
                            <img src="assets/images/ID.png" class="embed-responsive" style="border-radius: 15px;" />
                            <span class="firstName idFirstName upper"></span>
                            <span class="lastName idLastName upper"></span>
                            <span class="dob idDOB upper"></span>
                            <span class="address idAddress upper"></span>
                            <span class="gender idGender upper"></span>
                            <span class="hair idHair upper"></span>
                            <span class="weight idWeight upper"></span>
                            <span class="ethnicity idEthnicity upper"></span>
                            <span class="licenseNumberID idLicenseNumber upper"></span>
                            <span class="licenseExp idExpiration upper"></span>
                            <img src="assets/images/portraitid.png" class="photoID idPhoto licenseImage embed-responsive" />
                        </div>
                    </div>
                    <div class="col-lg-6 font-14" style="color: #B1B1B1!important;">
                        <h2 class="font-18">LICENSE STATUS</h2>
                        <div class="font-14" style="color: #B1B1B1!important;">
                            <span id="licenseStatus" class="d-block font-20 m-b-5"><span class="licenseStatus upper"></span></span>
                            <span class="d-block"><span class="text-white">STATE:</span> <span class="licenseState upper"></span></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row clearfix m-t-10 p-r-10 p-l-10">
                <div class="col-lg-12 bg-grey scrollbar style-1" style="width: 100%;">
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
            </div>
            <div class="row clearfix m-t-10 p-r-10 p-l-10">

                <div class="col-lg-12 bg-grey scrollbar style-1" style="width: 100%;">
                    <h2 class="font-18">TRAFFIC PRIORS</h2>
                    <div class="table-responsive force-overflow">
                        <table class="table table-condensed">
                            <thead>
                                <tr>
                                    <th style="color: #B1B1B1;">ID</th>
                                    <th style="color: #B1B1B1;">Details</th>
                                    <th style="color: #B1B1B1;">Citation</th>
                                    <th style="color: #B1B1B1;">Officer</th>
                                    <th style="color: #B1B1B1;">Actions</th>
                                </tr>
                            </thead>
                            <tbody class='priorTraffic'>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row clearfix m-t-10 p-r-10 p-l-10">

                <div class="col-lg-12 bg-grey scrollbar style-1" style="width: 100%;">
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

            <div id="vehDetails" style="display: none;">
                <div class="row clearfix m-t-10 p-r-10">
                    <div id="btnsVehDetails" class="col-lg-5 m-t-10">
                        <div class="plateContainer">
                            <img class="col-lg-12 embed-responsive" src="assets/images/plate.png" style="width: 100%;">
                            <div class="licensePlateExpiration plateTopLeft"></div>
                            <div class="licensePlateNumber plateCentered"></div>
                        </div>
                    </div>
                    <div class="col-lg-7 bg-grey">
                        <h2 class="font-24">VEHICLE DETAILS</h2>
                        <div class="col-lg-6 font-14" style="color: #B1B1B1!important;">
                            <span class="d-block"><span class="text-white">REGISTRATION:</span> <span class="licensePlateExpiration upper"></span></span>
                            <span class="d-block"><span class="text-white">INSURANCE:</span> <span class="insuranceStatus upper"></span></span>
                            <span class="d-block"><span class="text-white">STOLEN:</span> <span class="stolenStatus upper"></span></span>
                            <span class="d-block"><span class="text-white">PLATE:</span> <span class="licensePlateNumber upper"></span></span>
                        </div>
                        <div class="col-lg-6 font-14" style="color: #B1B1B1!important;">
                            <span class="d-block"><span class="text-white">MODEL:</span> <span class="vehModel upper"></span></span>
                            <span class="d-block"><span class="text-white">MAKE:</span> <span class="vehMake upper"></span></span>
                            <span class="d-block"><span class="text-white">COLOR:</span> <span class="vehColor upper"></span></span>
                            <span class="d-block"><span class="text-white">OWNER:</span> <span class="vehOwner upper"></span></span>
                        </div>
                    </div>
                </div>
            </div>


            <form data-toggle="validator" role="form" id="warrantForm" style="display: none;">
                <div class="row cleafix col-lg-12">
                    <div class="col-lg-12">
                        <h4>STATE OF SAN ANDREAS
                        <br />
                            WARRANT FORM</h4>
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Full Name*</h5>
                                <input type="text" name="fullName" class="fullName input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>License Number*</h5>
                                <input type="text" name="licenseNumber" class="licenseNumber input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>License State*</h5>
                                <input type="text" name="licenseState" class="licenseState input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Warrant Issued*</h5>
                                <input type="text" name="warrantDateIssued" class="warrantDateIssued input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>Department*</h5>
                                <input required type="text" name="warrantDepartment" aria-describedby="warrantDepartmentHelpInline" class="warrantDepartment input-block-level form-control bg-grey2 text-center" title="Four Letter Department Code" pattern="[A-Za-z]{4}" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                <small id="warrantDepartmentHelpInline" class="text-muted">Four Letters Only</small>
                            </div>
                            <div class="col-lg-4">
                                <h5>Officer (ex: B-204)*</h5>
                                <input required type="text" name="warrantOfficer" class="warrantOfficer input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-12">
                                <h5>Charges*</h5>
                                <textarea required rows="10" name="warrantCharges" class="warrantCharges input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;"></textarea>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <button id="createWarrantBtn" type="submit" class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-md" style="color: #fff;" onclick="return false;">
                                SIGN AND FILE
                            </button>
                        </div>
                    </div>
                </div>
            </form>

            <form data-toggle="validator" role="form" id="arrestForm" style="display: none;">
                <div class="row cleafix col-lg-12">
                    <div class="col-lg-12">
                        <h4>STATE OF SAN ANDREAS
                        <br />
                            ARREST FORM</h4>
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Full Name*</h5>
                                <input type="text" name="fullName" class="fullName input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>License Number*</h5>
                                <input type="text" name="licenseNumber" class="licenseNumber input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>License State*</h5>
                                <input type="text" name="licenseState" class="licenseState input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Arrested On*</h5>
                                <input type="text" name="arrestDateIssued" class="arrestDateIssued input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>Location*</h5>
                                <input required type="text" name="arrestLocation" class="arrestLocation input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                            </div>
                            <div class="col-lg-4">
                                <h5>Officer (ex: B-204)*</h5>
                                <input required type="text" name="arrestOfficer" class="arrestOfficer input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-12">
                                <h5>Arrest Details*</h5>
                                <textarea required rows="5" name="arrestDetails" class="arrestDetails input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;"></textarea>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-12">
                                <h5>Charges*</h5>
                                <textarea required rows="5" name="arrestCharges" class="arrestCharges input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;"></textarea>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-4"></div>
                            <div class="col-lg-4">
                                <h5>Fine Total*</h5>
                                <input required type="text" name="arrestFines" class="arrestFines input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                            </div>
                            <div class="col-lg-4">
                                <h5>Jail Time*</h5>
                                <input required type="text" name="arrestJailtime" class="arrestJailtime input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                            </div>
                        </div>
                        <div class="row clearfix">
                            <button id="createArrestBtn" type="submit" class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-md" style="color: #fff;" onclick="return false;">
                                SIGN AND BOOK
                            </button>
                        </div>
                    </div>
                </div>
            </form>

            <form data-toggle="validator" role="form" id="ticketForm" style="display: none;">
                <div class="row cleafix col-lg-12">
                    <div class="col-lg-12">
                        <h4>STATE OF SAN ANDREAS
                        <br />
                            CITATION FORM</h4>
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Full Name*</h5>
                                <input type="text" name="fullName" class="fullName input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>License Number*</h5>
                                <input type="text" name="licenseNumber" class="licenseNumber input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>License State*</h5>
                                <input type="text" name="licenseState" class="licenseState input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Date*</h5>
                                <input type="text" name="ticketDateIssued" class="ticketDateIssued input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>Location*</h5>
                                <input required type="text" name="ticketLocation" class="ticketLocation input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                            </div>
                            <div class="col-lg-4">
                                <h5>Officer (ex: B-204)*</h5>
                                <input required type="text" name="ticketOfficer" class="ticketOfficer input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-12">
                                <h5>Ticket Details*</h5>
                                <textarea required rows="5" name="ticketDetails" class="ticketDetails input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;"></textarea>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-12">
                                <h5>Charges*</h5>
                                <textarea required rows="5" name="ticketCharges" class="ticketCharges input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;"></textarea>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-4"></div>
                            <div class="col-lg-4"></div>
                            <div class="col-lg-4">
                                <h5>Fine Total*</h5>
                                <input required type="text" name="ticketFines" class="ticketFines input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                            </div>
                        </div>
                        <div class="row clearfix">
                            <button id="createTicketBtn" type="submit" class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-md" style="color: #fff;" onclick="return false;">
                                SIGN AND PRINT
                            </button>
                        </div>
                    </div>
                </div>
            </form>

            <form data-toggle="validator" role="form" id="warningForm" style="display: none;">
                <div class="row cleafix col-lg-12">
                    <div class="col-lg-12">
                        <h4>STATE OF SAN ANDREAS
                        <br />
                            WARNING FORM</h4>
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Full Name*</h5>
                                <input type="text" name="fullName" class="fullName input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>License Number*</h5>
                                <input type="text" name="licenseNumber" class="licenseNumber input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>License State*</h5>
                                <input type="text" name="licenseState" class="licenseState input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Date*</h5>
                                <input type="text" name="warningDateIssued" class="warningDateIssued input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>Location*</h5>
                                <input required type="text" name="warningLocation" class="warningLocation input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                            </div>
                            <div class="col-lg-4">
                                <h5>Officer (ex: B-204)*</h5>
                                <input required type="text" name="warningOfficer" class="warningOfficer input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-12">
                                <h5>Ticket Details*</h5>
                                <textarea required rows="5" name="warningDetails" class="warningDetails input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;"></textarea>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <button id="createWarningBtn" type="submit" class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-md" style="color: #fff;" onclick="return false;">
                                SIGN AND PRINT
                            </button>
                        </div>
                    </div>
                </div>
            </form>

            <div id="ticketDetailsDialog" style="display: none;">
                <div class="row cleafix col-lg-12">
                    <div class="col-lg-12">
                        <h4>STATE OF SAN ANDREAS TICKET INFORMATION</h4>
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Full Name</h5>
                                <input type="text" class="ticketDetailName input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly />
                            </div>
                            <div class="col-lg-4">
                                <h5>License Number</h5>
                                <input class="ticketDetailLicense input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly />
                            </div>
                            <div class="col-lg-4">
                                <h5>Charges</h5>
                                <textarea class="ticketCharges input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly></textarea>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Date</h5>
                                <input class="ticketDetailDate input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly />
                            </div>
                            <div class="col-lg-4">
                                <h5>Location</h5>
                                <input class="ticketDetailLocation input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly />
                            </div>
                            <div class="col-lg-4">
                                <h5>Officer</h5>
                                <input class="ticketDetailOfficer input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly />
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-8">
                                <h5>Ticket Details</h5>
                                <textarea class="ticketDetailsSum input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly></textarea>
                            </div>
                            <div class="col-lg-4">
                                <h5>Total Fine</h5>
                                <input class="ticketDetailFineTotal input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="arrestFormDetails" style="display: none;">
                <div class="row cleafix col-lg-12">
                    <div class="col-lg-12">
                        <h4>STATE OF SAN ANDREAS ARREST DETAILS</h4>
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Full Name</h5>
                                <input type="text" class="arrestNameDetails input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>License Number</h5>
                                <input type="text" class="arrestLicenseNumber input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>Active Warrant?</h5>
                                <input type="text" class="arrestActiveWarrant input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Arrested On</h5>
                                <input type="text" class="arrestDetailsDateIssued input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>Location</h5>
                                <input type="text" class="arrestDetailsLocation input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>Officer</h5>
                                <input type="text" class="arrestDetailsDetailsOfficer input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-12">
                                <h5>Arrest Details</h5>
                                <textarea rows="5" class="arrestDetailsDetails input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly></textarea>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-12">
                                <h5>Charges</h5>
                                <textarea rows="5" class="arrestDetailsCharges input-block-level form-control bg-grey2" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly></textarea>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-4"></div>
                            <div class="col-lg-4">
                                <h5>Fine Total</h5>
                                <input type="text" class="arrestDetailsFines input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>Jail Time
                                </h5>
                                <input type="text" class="arrestDetailsJailTime input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="warrantFormDetails" style="display: none;">
                <div class="row cleafix col-lg-12">
                    <div class="col-lg-12">
                        <h4>STATE OF SAN ANDREAS WARRANT DETAILS</h4>
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Full Name</h5>
                                <input type="text" class="warrantNameDetails input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>License Number</h5>
                                <input type="text" class="warrantLicenseNumber input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>Warrant Issued</h5>
                                <input type="text" class="warrantDetailsDateIssued input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Warrant Status</h5>
                                <input type="text" class="warrantDetailsStatus input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>Department</h5>
                                <input type="text" class="warrantDetailsDept input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-4">
                                <h5>Officer</h5>
                                <input type="text" class="warrantDetailsOfficer input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="viewBoloMenu" style="display: none;">
                <div class="row cleafix col-lg-12">
                    <div class="col-lg-12">
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Caller Name</h5>
                                <input type="text" class="createCallNameDetails input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" placeholder="Dispatch or Civilian Name">
                            </div>
                            <div class="col-lg-4">
                                <h5>Caller Location</h5>
                                <input type="text" class="createCallLocation input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                            </div>
                            <div class="col-lg-2">
                                <h5>Call Date</h5>
                                <input type="text" class="createCallDate input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-4">
                                <h5>Call Details</h5>
                                <textarea rows="3" class="createCallDetails input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" placeholder="Type of Call: 10-80, Robbery, etc."></textarea>
                            </div>
                            <div class="col-lg-2">
                                <h5>Officer</h5>
                                <input type="text" class="createCallOfficer input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" placeholder="B-204">
                            </div>
                            <div class="col-lg-4">
                                <h5>Status</h5>
                                <select class="createCallStatus input-block-level form-control bg-grey2" style="height: auto!important; font-size: 15px; color: #fff; min-width: 100%!important;">
                                    <option>Active</option>
                                    <option>Active Bolo</option>
                                    <option>Pending</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <textarea id="notePad" rows="35" class="bg-grey2" style="font-size: 18px !important; border-radius: 10px; min-width: 100%; display: none;"></textarea>
    </section>

    <script>
        var SessionID = '<%=Session["User"]%>';
        var UN = $("#UnitNumber").html();
        var OnPatrol = '<%=Session["OnPatrol"]%>';
        $('#signal11').tooltip({ title: "Radar", placement: "top" });
        $('#1015button').tooltip({ title: "Subject Enroute to Station", placement: "top" });
        $('#1012button').tooltip({ title: "Ride-Along", placement: "top" });
        $('#1011button').tooltip({ title: "Traffic Stop", placement: "top" });
        $('#codezero').tooltip({ title: "Game Crash", placement: "top" });
        $('#clearcodes').tooltip({ title: "Clear Signals/Codes", placement: "top" });
        $('#1019button').tooltip({ title: "Active K-9s", placement: "top" });
        $('#105button').tooltip({ title: "Meal Break", placement: "top" });
        $('#106button').tooltip({ title: "Busy", placement: "top" });
        $('#107button').tooltip({ title: "Out of Service", placement: "top" });
        $('#108button').tooltip({ title: "In Service", placement: "top" });
        $('#1041button').tooltip({ title: "Beginning Tour of Duty", placement: "top" });
        $('#1042button').tooltip({ title: "Ending Tour of Duty", placement: "top" });
        $('#1023button').tooltip({ title: "Arrived on Scene", placement: "top" });
        $('#1097button').tooltip({ title: "In Route", placement: "top" });

     
    </script>

</asp:Content>

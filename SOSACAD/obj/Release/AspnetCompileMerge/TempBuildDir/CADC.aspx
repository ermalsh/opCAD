<%@ Page Title="SOSA CAD" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CADC.aspx.cs" Inherits="SoSACAD.CADSV" ValidateRequest="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <audio id="mySoundClip" style="display: none;">
        <source src="assets/media/alert.ogg" class="mySoundClip" type="audio/ogg">
        <source src="assets/media/alert.mp3" class="mySoundClip" type="audio/mpeg">
    </audio>

    <!-- main content -->
    <section class="content" style="background-color: #333;">
        <div class="container-fluid">
            <!--Voice Menu-->
            <div id="voipPanel" class="panel-group">
                <div class="panel panel-col-grey">

                    <div id="collapse1" class="panel-collapse collapse">
                        <div class="panel-body font-14">
                            <h6 class="text-white">STATUS: <span class="text-success">ONLINE</span></h6>
                            <hr />
                            <div class="col-lg-12 make-center">
                                <button id="open-room" class="bg-grey2 btn btn-raised waves-effect text-white customBtn text-center">Open RTO</button>
                                <div class="card row clearfix bg-grey2 col-lg-12">
                                    <br />
                                    <span class="">Channel Info & Units</span>
                                    <hr />
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

            <div class="row clearfix">


                <div class="col-lg-12">
                    <h3 style="color: #fff" class="text-center">DISPATCHER MENU</h3>
                    <div class="col-lg-2">
                        <button class="bg-grey btn-block btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="civSearchDialog(); return false;">
                            CIVILIANS DATABASE
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button class="bg-grey btn-block btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="vehSearchDialog(); return false;">
                            VEHICLES DATABASE
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button id="penalCodesCheat" class="bg-grey btn btn-lg btn-raised waves-effect btn-block" style="color: #B1B1B1;" onclick="openPenalCodesCheat(); return false;">
                            CHEAT SHEET
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button class="busyUnitsToggleBtn bg-grey btn-block btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="toggleBusyUnits(); return false;">
                            TOGGLE UNITS
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button class="bg-grey btn-block btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="openNotepad(); return false;">
                            NOTEPAD
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button class="bg-grey btn-block btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="logOff();  return false;">
                            LOG OFF
                        </button>
                    </div>
                </div>
            </div>
            <hr />

            <div class="col-lg-12 row clearfix">

                <!-- Contextual Classes -->
                <div class="col-lg-6 col-md-12 col-sm-12">
                    <div id="activeCalls">
                        <div class="card bg-grey">
                            <div class="header bg-grey">
                                <h2>ACTIVE CALLS & BOLOS</h2>
                                <span id="toggleBolosBtn" class="col-lg-2 bg-grey2 label pull-right m-r-10" style="color: #B1B1B1; cursor: pointer;" onclick="toggleBolos();  return false;">Toggle Bolos
                                </span>
                                <span class="col-lg-2 bg-grey2 label pull-right m-r-10" style="color: #B1B1B1; cursor: pointer;" onclick="createCallDialog();  return false;">Add Call
                                </span>
                            </div>

                            <div class="body table-responsive scrollbarActive style-1">
                                <table class="table table-condensed ">
                                    <thead>
                                        <tr class="force-overflow">
                                            <th style="color: #B1B1B1;">Caller</th>
                                            <th style="color: #B1B1B1;">Location</th>
                                            <th style="color: #B1B1B1;">Date</th>
                                            <th style="color: #B1B1B1;">Description</th>
                                            <th style="color: #B1B1B1;">Response</th>
                                            <th style="color: #B1B1B1;">Notes</th>
                                            <th style="color: #B1B1B1;">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody id="boloCalls">
                                    </tbody>
                                    <tbody id="ActiveCallsData">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-12 col-sm-12">
                    <div id="unitConsole">
                        <div class="card bg-grey">
                            <div class="header bg-grey">
                                <h2>UNIT CONSOLE - <span id="currentPatrolStatus"></span></h2>

                            </div>
                            <div class="body">
                                <h4 style="color: #B1B1B1;"><span class="currentControlText text-success">Currently in Control of -</span>&nbsp;&nbsp;<span id="UnitNumber"></span>&nbsp;&nbsp;<span id="UnitName">Select an Available Unit to Control</span></h4>
                                <div class="row clearfix">
                                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                        <button id="105button" type="button" class="btn  btn-raised bg-grey2 btn-block btn-lg waves-effect" onclick="updateStatus105();"><span class="text-white text-lg-center">10-5</span></button>
                                    </div>
                                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                        <button id="106button" type="button" class="btn  btn-raised bg-grey2 btn-block btn-lg waves-effect" onclick="updateStatus106();"><span class="text-white text-lg-center">10-6</span></button>
                                    </div>
                                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                        <button id="107button" type="button" class="btn  btn-raised bg-grey2 btn-block btn-lg waves-effect" onclick="updateStatus107();"><span class="text-white text-lg-center">10-7</span></button>
                                    </div>
                                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                        <button id="108button" type="button" class="btn  btn-raised bg-grey2 btn-block btn-lg waves-effect" onclick="updateStatus108();"><span class="text-white text-lg-center">10-8</span></button>
                                    </div>
                                </div>
                                <div class="row clearfix col-lg-3 pull-right font-18">
                                    <button id="startPitTimeBtn" type="button" class="btn btn-raised bg-grey2 text-white btn-lg waves-effect btn-block text-center" onclick="startPitTimer();">START PIT TIMER</button>
                                </div>
                                <div class="row clearfix">
                                    <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                                        <button id="1041button" type="button" class="btn  btn-raised bg-grey2 btn-block btn-lg waves-effect" onclick="updateStatus1041();"><span class="text-white text-lg-center">10-41</span></button>
                                    </div>
                                    <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                                        <button id="1042button" type="button" class="btn  btn-raised bg-grey2 btn-block btn-lg waves-effect" onclick="updateStatus1042();"><span class="text-white text-lg-center">10-42</span></button>
                                    </div>
                                    <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                                        <button id="1023button" type="button" class="btn  btn-raised bg-grey2 btn-block btn-lg waves-effect" onclick="updateStatus1023();"><span class="text-white text-lg-center">10-23</span></button>
                                    </div>
                                    <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                                        <button id="1097button" type="button" class="btn  btn-raised bg-grey2 btn-block btn-lg waves-effect" onclick="updateStatus1097();"><span class="text-white text-lg-center">10-97</span></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 row clearfix">

                    <!-- Contextual Classes -->
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div id="pendingCalls">
                            <div class="card bg-grey">
                                <div class="header bg-grey">
                                    <h2>PENDING CALLS</h2>
                                </div>
                                <div class="body table-responsive scrollbarPending style-1">
                                    <table class="table table-condensed">
                                        <thead>
                                            <tr class="force-overflow">
                                                <th style="color: #B1B1B1;">Caller</th>
                                                <th style="color: #B1B1B1;">Location</th>
                                                <th style="color: #B1B1B1;">Date</th>
                                                <th style="color: #B1B1B1;">Description</th>
                                                <th style="color: #B1B1B1;">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody id="PendingCallsData">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12 ">
                        <div class="availableUnitsTable card bg-grey">
                            <div class="header bg-grey">
                                <h2 class="text-success">Available Units</h2>
                            </div>
                            <div class="body">
                                <div class="table-responsive scrollbarUnits style-1">
                                    <table class="table table-condensed">
                                        <thead>
                                            <tr class="force-overflow">
                                                <th style="color: #B1B1B1;">Unit</th>
                                                <th style="color: #B1B1B1;">Name</th>
                                                <th style="color: #B1B1B1;">Status</th>
                                                <th style="color: #B1B1B1;">Actions</th>
                                                <th style="color: #B1B1B1;">Division</th>
                                            </tr>
                                        </thead>
                                        <tbody id="availableUnits">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>


                        <div class="busyUnitsTable card bg-grey">
                            <div class="header bg-grey">
                                <h2 class="text-warning">Busy Units</h2>
                            </div>
                            <div class="body">
                                <div class="table-responsive scrollbarUnits style-1">
                                    <table class="table table-condensed">
                                        <thead>
                                            <tr class="force-overflow">
                                                <th style="color: #B1B1B1;">Unit</th>
                                                <th style="color: #B1B1B1;">Name</th>
                                                <th style="color: #B1B1B1;">Status</th>
                                                <th style="color: #B1B1B1;">Actions</th>
                                                <th style="color: #B1B1B1;">Division</th>
                                            </tr>
                                        </thead>
                                        <tbody id="busyUnits">
                                        </tbody>
                                    </table>
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
                                    <input required type="text" name="warrantDepartment" class="warrantDepartment input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
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

                <div id="callMenu" style="display: none;">
                    <div class="row cleafix col-lg-12">
                        <div class="col-lg-12">
                            <h4>STATE OF SAN ANDREAS CALL DETAILS</h4>
                            <div class="row clearfix">
                                <div class="col-lg-4">
                                    <h5>Caller Name</h5>
                                    <input type="text" class="callerNameDetails input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                                </div>
                                <div class="col-lg-4">
                                    <h5>Caller Location</h5>
                                    <input type="text" class="callerDetailsLocation input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                                </div>
                                <div class="col-lg-4">
                                    <h5>Call Date</h5>
                                    <input type="text" class="callerDetailsDate input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                                </div>
                            </div>
                            <div class="row clearfix">
                                <div class="col-lg-6">
                                    <h5>Call Details</h5>
                                    <textarea rows="3" class="callerDetailsDetails input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly></textarea>
                                </div>
                                <div class="col-lg-3">
                                    <h5>Officer/s</h5>
                                    <input type="text" class="callerDetailsOfficer input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                                </div>
                                <div class="col-lg-3">
                                    <h5>Status/Type</h5>
                                    <input type="text" class="callerDetailsStatus input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                                </div>
                            </div>
                            <hr />
                            <div class="row clearfix">
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                                    <button id="1022Call" type="button" class="btn btn-raised bg-grey2 btn-block btn-lg waves-effect"><span class="text-white text-lg-center">10-22</span></button>
                                </div>
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                                    <button id="1020Call" type="button" class="btn btn-raised bg-grey2 btn-block btn-lg waves-effect"><span class="text-white text-lg-center">10-20</span></button>
                                </div>
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                                    <button id="1032Call" type="button" class="btn btn-raised bg-grey2 btn-block btn-lg waves-effect"><span class="text-white text-lg-center">10-32</span></button>
                                </div>
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                                    <button id="1099Call" type="button" class="btn btn-raised bg-darkred btn-block btn-lg waves-effect"><span class="text-white text-lg-center">10-99</span></button>
                                </div>
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                                    <button id="signal100call" type="button" class="btn btn-raised bg-darkred btn-block btn-lg waves-effect"><span class="text-white text-lg-center">Signal-100</span></button>
                                </div>
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                                    <button id="code4Call" type="button" class="btn btn-raised bg-success btn-block btn-lg waves-effect"><span class="text-white text-lg-center">Code 4</span></button>
                                </div>
                            </div>
                            <div id="1032Select" class="row clearfix">
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                                </div>
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                                </div>
                                <div id="selectUnit1032Div" class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="visibility: hidden;">
                                    <select id="selectUnit1032" class="input-block-level form-control bg-grey2 p-l-10" style="height: auto!important; font-size: 15px; color: #fff; min-width: 100%!important;">
                                        <option>Select a Unit</option>
                                    </select>
                                </div>
                                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1">
                                    <button id="add1032Btn" type="button" class="btn btn-raised bg-grey2 btn-sm waves-effect" style="visibility: hidden;"><span class="text-white text-lg-center">ADD</span></button>
                                </div>
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                                </div>
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="createCallMenu" style="display: none;">
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
                                        <option>Vehicle Bolo</option>
                                        <option>Person Bolo</option>
                                        <option>Pending</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="1020Location" class="row cleafix col-lg-12" style="visibility: hidden;">
                    <div class="col-lg-12">
                        <div class="row clearfix">
                            <div class="col-lg-12">
                                <h5>Update 10-20 to:</h5>
                                <input type="text" class="callerLocationUpdate input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" placeholder="ROUTE 68 N, Harmony">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <textarea id="notePad" rows="35" class="bg-grey2" style="font-size: 18px !important; border-radius: 10px; min-width: 100%; display: none;"></textarea>
    </section>

    <script>
        $(document).ready(function () {
            var SessionID = '<%=Session["UnitName"]%>';
            var SessionDispatcher = '<%=Session["isDispatcher"]%>';
            loadDispatcherData(SessionID);
            $("form").on("submit", function (event) {
                $(this).serialize();
            });
        });
    </script>
</asp:Content>

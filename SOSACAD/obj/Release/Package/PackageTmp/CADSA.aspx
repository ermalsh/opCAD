<%@ Page Title="SOSARP" Language="C#" MasterPageFile="~/CADSA.Master" AutoEventWireup="true" CodeBehind="CADSA.aspx.cs" Inherits="SoSACAD.CADSA1" ValidateRequest="true" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="content" style="margin: 25px 15px 15px 265px; background-color: #333;">
        <div class="container-fluid">
            <div class="col-lg-12 row clearfix">
                <div class="col-lg-12">
                    <h3 style="color: #fff" class="text-center">SUPER ADMIN MENU</h3>
                    <div class="col-lg-2">
                        <button class="bg-grey btn-block btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="toggleRegisteredUsersTable(); return false;">
                            REGISTERED USERS
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button class="bg-grey btn-block btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="toggleCharacterTable(); return false;">
                            CHARACTER EDITOR
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button class="bg-grey btn btn-lg btn-raised waves-effect btn-block" style="color: #B1B1B1;" onclick="toggleVehiclesTable(); return false;">
                            VEHICLE EDITOR
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button class="bg-grey btn-block btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="toggleCallsTable(); return false;">
                            CALL LOGS
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button class="bg-grey btn-block btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="registerLEO(); return false;">
                            LEO REGISTRATION
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button class="bg-grey btn-block btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="();  return false;">
                            LOG OFF
                        </button>
                    </div>
                </div>
            </div>
            <hr />
            <!-- Basic Examples -->
            <div id="toggleRegUsers" class="row clearfix animated zoomIn" style="display: none;">
                <div class="col-lg-6 col-md-6 col-sm-12">
                    <div class="card bg-grey">
                        <div class="header bg-grey">
                            <h2>REGISTERED UNITS </h2>
                        </div>
                        <div class="body">
                            <div class="table-responsive text-grey">
                                <table id="tableUnits" class="table table-condensed table-bordered regUnitsTable table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Username</th>
                                            <th>Name</th>
                                            <th>Primary Identifier</th>
                                            <th>Approved?</th>
                                            <th>Banned?</th>
                                        </tr>
                                    </thead>
                                    <tbody id="unitsTable">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6 col-md-6 col-sm-12">
                    <div class="card bg-grey">
                        <div class="header bg-grey">
                            <h2>REGISTERED CIVILIANS </h2>
                        </div>
                        <div class="body">
                            <div class="table-responsive text-grey">
                                <table id="tableUsers" class="table table-condensed table-bordered regUnitsTable table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Username</th>
                                            <th>Name</th>
                                            <th>Email Address</th>
                                            <th>Approved?</th>
                                            <th>Banned?</th>
                                        </tr>
                                    </thead>
                                    <tbody id="civiliansTable">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="toggleCharEditor" class="row clearfix animated zoomIn" style="display: none;">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="card bg-grey">
                        <div class="header bg-grey">
                            <h2>REGISTERED CHARACTERS OF SOSA</h2>
                        </div>
                        <div class="body">
                            <div class="table-responsive text-grey">
                                <table id="tableCharacter" class="table table-condensed table-bordered regUnitsTable table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Owner</th>
                                            <th>First Name</th>
                                            <th>Last Name</th>
                                            <th>License Number</th>
                                            <th>License Status</th>
                                            <th>State</th>
                                            <th>Expiration</th>
                                            <th>Address</th>
                                            <th>DOB</th>
                                            <th>Gender</th>
                                            <th>Hair</th>
                                            <th>Ethnicity</th>
                                            <th>Weight</th>
                                        </tr>
                                    </thead>
                                    <tbody id="characterTable">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="toggleVehicleEditor" class="row clearfix animated zoomIn" style="display: none;">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="card bg-grey">
                        <div class="header bg-grey">
                            <h2>REGISTERED VEHICLES OF SOSA</h2>
                        </div>
                        <div class="body">
                            <div class="table-responsive text-grey">
                                <table id="tableVehicles" class="table table-condensed table-bordered regUnitsTable table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Owner</th>
                                            <th>Full Name</th>
                                            <th>License Plate</th>
                                            <th>Model</th>
                                            <th>Make</th>
                                            <th>Color</th>
                                            <th>Registration</th>
                                            <th>Insurance</th>
                                        </tr>
                                    </thead>
                                    <tbody id="vehicleTable">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="toggleCallsTable" class="row clearfix animated zoomIn" style="display: none;">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="card bg-grey">
                        <div class="header bg-grey">
                            <h2>ALL CALLS MADE ON SOSA</h2>
                        </div>
                        <div class="body">
                            <div class="table-responsive text-grey">
                                <table id="tableCalls" class="table table-condensed table-bordered regUnitsTable table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Caller</th>
                                            <th>Location</th>
                                            <th>Details</th>
                                            <th>Date</th>
                                            <th>Response</th>
                                            <th>Notes</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody id="callsTable">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="unitDetails" style="display: none;">
                <div class="col-lg-12">
                    <div class="row clearfix m-t-10 p-r-10">
                        <div class="col-lg-12 bg-grey">
                            <h2 class="font-24">Unit Information</h2>
                            <div class="row clearfix">
                                <div class="col-lg-2">
                                    <h5>Full Name</h5>
                                    <input type="text" class="unitName input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                </div>
                                <div class="col-lg-2">
                                    <h5>CAD Username</h5>
                                    <input type="text" class="unitUsername input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                                </div>
                                <div class="col-lg-2">
                                    <h5>Approved?</h5>
                                    <select class="unitApproved input-block-level form-control bg-grey2 p-l-10" style="height: auto!important; font-size: 15px; color: #fff; min-width: 100%!important;">
                                        <option>Yes</option>
                                        <option>No</option>
                                    </select>
                                </div>
                                <div class="col-lg-2">
                                    <h5>Banned?</h5>
                                    <select class="unitBanned input-block-level form-control bg-grey2 p-l-10" style="height: auto!important; font-size: 15px; color: #fff; min-width: 100%!important;">
                                        <option>Yes</option>
                                        <option>No</option>
                                    </select>
                                </div>
                                <div class="col-lg-2">
                                    <h5>Dispatcher?</h5>
                                    <select class="unitDispatcher input-block-level form-control bg-grey2 p-l-10" style="height: auto!important; font-size: 15px; color: #fff; min-width: 100%!important;">
                                        <option>Yes</option>
                                        <option>No</option>
                                    </select>
                                </div>
                                <div class="col-lg-2">
                                    <h5>Admin?</h5>
                                    <select class="unitAdmin input-block-level form-control bg-grey2 p-l-10" style="height: auto!important; font-size: 15px; color: #fff; min-width: 100%!important;">
                                        <option>Yes</option>
                                        <option>No</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row clearfix">
                                <div class="col-lg-2">
                                    <h5>Primary Identifier</h5>
                                    <input type="text" class="unitPrimaryIdentifier input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                </div>
                                <div class="col-lg-2">
                                    <h5>Division Identifier</h5>
                                    <input type="text" class="unitDivision input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1;" />
                                </div>
                                <div class="col-lg-2">
                                    <h5>Sub-Division ID</h5>
                                    <input type="text" class="unitSubDivision input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1;" />
                                </div>
                                <div class="col-lg-2">
                                    <h5>Sub-Division ID #2</h5>
                                    <input type="text" class="unitSubDivision2 input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1;" />
                                </div>
                                <div class="col-lg-2">
                                    <h5>Sub-Division ID #3</h5>
                                    <input type="text" class="unitSubDivision3 input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1;" />
                                </div>
                                <div class="col-lg-2">
                                    <h5>Sub-Division ID #4</h5>
                                    <input type="text" class="unitSubDivision4 input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1;" />
                                </div>
                            </div>
                            <div class="row clearfix">

                                <div class="col-lg-3">
                                    <label for="newUnitPassword">To reset a password, enter a new one then click reset.</label>
                                    <input type="text" name="newUnitPassword" class="newUnitPassword input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1;" placeholder="New Password" />
                                </div>
                                <div class="col-lg-3">
                                    <button class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="resetUnitComplete(); return false;">
                                        RESET PASSWORD
                                    </button>
                                </div>
                                <div class="col-lg-3">
                                    <button id="archiveUnitBtn" class="pull-right btn btn-raised bg-darkred btn-block waves-effect btn-lg" style="color: #fff;" onclick="return false;">
                                        ARCHIVE ACCOUNT
                                    </button>
                                </div>
                                <div class="col-lg-3">
                                    <button class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="updateUnitComplete(); return false;">
                                        CONFIRM CHANGES
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="userDetails" style="display: none;">
                        <div class="col-lg-12">
                            <div class="row clearfix m-t-10 p-r-10">
                                <div class="col-lg-12 bg-grey">
                                    <h2 class="font-24">User Information</h2>
                                    <div class="row clearfix">
                                        <div class="col-lg-3">
                                            <h5>Full Name</h5>
                                            <input type="text" class="userName input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                        </div>
                                        <div class="col-lg-3">
                                            <h5>CivCAD Username</h5>
                                            <input type="text" class="userUsername input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;" readonly>
                                        </div>
                                        <div class="col-lg-2">
                                            <h5>CivCAD Email</h5>
                                            <input type="text" class="userEmail input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                        </div>
                                        <div class="col-lg-2">
                                            <h5>Approved?</h5>
                                            <select class="userApproved input-block-level form-control bg-grey2 p-l-10" style="height: auto!important; font-size: 15px; color: #fff; min-width: 100%!important;">
                                                <option>Yes</option>
                                                <option>No</option>
                                            </select>
                                        </div>
                                        <div class="col-lg-2">
                                            <h5>Banned?</h5>
                                            <select class="userBanned input-block-level form-control bg-grey2 p-l-10" style="height: auto!important; font-size: 15px; color: #fff; min-width: 100%!important;">
                                                <option>Yes</option>
                                                <option>No</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row clearfix">
                                        <div class="col-lg-3">
                                            <label for="newUserPassword">To reset a password, enter a new one then click reset.</label>
                                            <input type="text" name="newUserPassword" class="newUserPassword input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1;" placeholder="New Password" />
                                        </div>
                                        <div class="col-lg-3">
                                            <button class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="resetUserComplete(); return false;">
                                                RESET PASSWORD
                                            </button>
                                        </div>
                                        <div class="col-lg-3">
                                            <button id="archiveUserBtn" class="pull-right btn btn-raised bg-darkred btn-block waves-effect btn-lg" style="color: #fff;" onclick="return false;">
                                                ARCHIVE ACCOUNT
                                            </button>
                                        </div>
                                        <div class="col-lg-3">
                                            <button class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="updateUserComplete(); return false;">
                                                CONFIRM CHANGES
                                            </button>
                                        </div>
                                        <div class="col-lg-4"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="civDetails" style="display: none;">
                        <div class="col-lg-12">
                            <div class="row clearfix m-t-10 p-r-10">
                                <div class="col-lg-12 bg-grey">
                                    <h2 class="font-24">User Information</h2>
                                    <div class="row clearfix">
                                        <div class="col-lg-3">
                                            <h5>License Number</h5>
                                            <input type="text" name="civLicense" class="civLicense input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                        </div>
                                        <div class="col-lg-2">
                                            <h5>First Name</h5>
                                            <input type="text" name="civFirstName" class="civFirstName input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                        </div>
                                        <div class="col-lg-2">
                                            <h5>Last Name</h5>
                                            <input type="text" name="civLastName" class="civLastName input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                        </div>
                                        <div class="col-lg-2">
                                            <h5>Full Name</h5>
                                            <input type="text" name="civFullName" class="civFullName input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                        </div>
                                        <div class="col-lg-3">
                                            <h5>Address</h5>
                                            <input type="text" name="civAddress" class="civAddress input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                        </div>
                                    </div>
                                    <div class="row clearfix">
                                        <div class="col-lg-2">
                                            <h5>DOB</h5>
                                            <input type="text" name="civDOB" class="civDOB input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                        </div>
                                        <div class="col-lg-2">
                                            <h5>Gender</h5>
                                            <input type="text" name="civGender" class="civGender input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                        </div>
                                        <div class="col-lg-2">
                                            <h5>Hair</h5>
                                            <input type="text" name="civHair" class="civHair input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                        </div>
                                        <div class="col-lg-2">
                                            <h5>Ethnicity</h5>
                                            <input type="text" name="civEthnicity" class="civEthnicity input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                        </div>
                                        <div class="col-lg-2">
                                            <h5>Weight</h5>
                                            <input type="text" name="civWeight" class="civWeight input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                        </div>
                                    </div>
                                    <div class="row clearfix">
                                        <div class="col-lg-3">
                                            <h5>License Expiration</h5>
                                            <input type="text" name="civExpiration" class="civExpiration input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                        </div>
                                        <div class="col-lg-3">
                                            <h5>License Status</h5>
                                            <select name="civLicenseStatus" class="civLicenseStatus input-block-level form-control bg-grey2 p-l-10" style="height: auto!important; font-size: 15px; color: #fff; min-width: 100%!important;">
                                                <option>Valid</option>
                                                <option>Expired</option>
                                                <option>Revoked</option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3">
                                            <h5>License State</h5>
                                            <input type="text" name="civState" class="civState input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                        </div>
                                        <div class="col-lg-3">
                                            <h5>Portrait</h5>
                                            <input type="text" name="civPortrait" class="civPortrait input-block-level form-control bg-grey2 text-center" style="font-size: 15px; color: #B1B1B1; min-width: 100%!important;">
                                        </div>
                                    </div>
                                    <div class="row clearfix">
                                        <div class="col-lg-4"></div>
                                        <div class="col-lg-4">
                                            <button class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="updateCivComplete(); return false;">
                                                CONFIRM CHANGES
                                            </button>
                                        </div>
                                        <div class="col-lg-4"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="leoRegistration" data-toggle="validator" role="form" style="display: none;">
                        <div class="card bg-grey2">
                            <form class="col-md-12" id="sign_up">
                                <div class="panel-group full-body m-t-5" id="accordion_13" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-col-grey">
                                        <div class="panel-heading" role="tab" id="headingOne_13">
                                            <h4 class="panel-title p-5">LEO Registration</h4>
                                        </div>
                                        <div class="panel-body">
                                            <span>Please fill out all of the required fields:</span>
                                            <hr />
                                            <div class="form-group">
                                                <div class="form-line">
                                                    <input id="unitName" name="unitName" type="text" class="form-control text-white" placeholder="Name (ex: David R.)" required />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-line">
                                                    <input id="unitID" name="unitID" type="text" class="form-control text-white" placeholder="Unit ID (Login Username)" required />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-line">
                                                    <input id="unitPW" name="unitPW" type="password" class="form-control text-white" placeholder="Password" required />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-line">
                                                    <input id="unitEmail" name="unitEmail" type="email" class="form-control text-white" placeholder="Email Address" required />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-line">
                                                    <input id="unitNumber" name="unitNumber" type="text" class="form-control text-white" placeholder="Unit Primary Identifier (ex: B-255)" required />
                                                </div>
                                                <button id="addOne" class="btn btn-raised waves-effect" style="background-color: #333; color: #B1B1B1;" onclick="return false;">Add Another Identifier</button>
                                            </div>
                                            <div id="additionalID1" class="form-group">
                                                <div class="form-line">
                                                    <input id="unitDivision" name="unitDivision" type="text" class="form-control text-white" placeholder="Additional Identifier #1" />
                                                </div>
                                                <button id="addTwo" class="btn btn-raised waves-effect" style="background-color: #333; color: #B1B1B1;" onclick="return false;">Add Another Identifier</button>
                                            </div>
                                            <div id="additionalID2" class="form-group">
                                                <div class="form-line">
                                                    <input id="unitDivision2" name="unitDivision2" type="text" class="form-control text-white" placeholder="Additional Identifier #2" />
                                                </div>
                                                <button id="addThree" class="btn btn-raised waves-effect" style="background-color: #333; color: #B1B1B1;" onclick="return false;">Add Another Identifier</button>
                                            </div>
                                            <div id="additionalID3" class="form-group">
                                                <div class="form-line">
                                                    <input id="unitDivision3" name="unitDivision3" type="text" class="form-control text-white" placeholder="Additional Identifier #3" />
                                                </div>
                                                <button id="addFour" class="btn btn-raised waves-effect" style="background-color: #333; color: #B1B1B1;" onclick="return false;">Add Another Identifier</button>
                                            </div>
                                            <div id="additionalID4" class="form-group">
                                                <div class="form-line">
                                                    <input id="unitDivision4" name="unitDivision4" type="text" class="form-control text-white" placeholder="Additional Identifier #4" />
                                                </div>
                                                <button id="addFive" class="btn btn-raised waves-effect" style="background-color: #333; color: #B1B1B1;" onclick="return false;">Add Another Identifier</button>
                                            </div>
                                            <div id="additionalID5" class="form-group">
                                                <div class="form-line">
                                                    <input id="unitDivision5" name="unitDivision5" type="text" class="form-control text-white" placeholder="Additional Identifier #5" />
                                                </div>
                                            </div>
                                            <hr />
                                            <button id="registerLeoFinish" type="submit" class="btn btn-raised waves-effect" style="background-color: #333; color: #B1B1B1;" onclick="return false;">Submit</button>
                                            <span id="regMessage" class="d-block font-18 text-danger"></span>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        $(document).ready(function () {
            var SessionID = '<%=Session["SuperAdminUser"]%>';
            var SessionAdmin = '<%=Session["IsSuperAdmin"]%>';
            loadAdminData(SessionID);
            $("form").on("submit", function (event) {
                $(this).serialize();
            });
        });

    </script>

</asp:Content>

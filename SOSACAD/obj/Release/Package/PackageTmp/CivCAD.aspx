<%@ Page Title="SOSARP" Language="C#" MasterPageFile="~/CivCAD.Master" AutoEventWireup="true" CodeBehind="CivCAD.aspx.cs" Inherits="SoSACAD.CivCAD" ValidateRequest="true" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="cadMain" class="content" style="margin: 25px 15px 15px 265px; background-color: #333;">
        <div class="container-fluid  col-offset-6 centered">
            <div class="row clearfix col-lg-12">
                <div class="col-lg-2 animated">
                    <div class="card bg-grey ">
                        <div class="h6 text-white p-1 font-12 text-center profile-img-container">
                            <img src="assets/images/portraitid.png" height="250" class="p-15 portraitImage embed-responsive" /><span onclick="changeURLImage();" style="cursor: pointer;"><i class="material-icons font-50 text-white">camera_enhance</i></span>
                            <span class="civFullname d-block"></span>
                            <span class="civLicense d-block"></span>
                        </div>
                        <div id="changeImagePopup" class="col-lg-12" style="display: none; z-index: 0;">
                            <div class="animated slideInUp card bg-grey">
                                <h5>URL <span class="pull-right" onclick="changeURLImageSubmit();"><i class="material-icons font-16 text-success" style="cursor: pointer;">check</i></span></h5>
                                <input type="text" class="imageURLUpdate input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="http://sosarp.net/image.jpg...">
                            </div>
                        </div>
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
                            <button class="btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="registerFirearm(); return false;">
                                REGISTER FIREARM
                            </button>
                        </div>
                        <div class="col-lg-12">
                            <button class="btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="createATicket(); return false;">
                                CREATE A TICKET
                            </button>
                        </div>
                        <div class="col-lg-12">
                            <button class="btn btn-raised bg-danger btn-block waves-effect btn-lg" style="color: #fff;" onclick="call911(); return false;">
                                CALL 911
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
                        <div id="civVehicleData" class="col-lg-12 col-md-12 col-sm-12 animated zoomIn" style="display: none;">
                            <div class="card widget-reports bg-grey">
                                <div class="header bg-grey">
                                    <h2>Registered Vehicles</h2>
                                </div>
                                <div class="body bg-grey">
                                    <div class="table-responsive table-condensed">
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

                        <div id="civFirearmData" class="col-lg-12 col-md-12 col-sm-12 animated zoomIn" style="display: none;">
                            <div class="card widget-reports bg-grey">
                                <div class="header bg-grey">
                                    <h2>Registered Firearms</h2>
                                </div>
                                <div class="body bg-grey">
                                    <div class="table-responsive table-condensed">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Type</th>
                                                    <th>Firearm</th>
                                                    <th>Issued Date</th>
                                                    <th>Expiration Date</th>
                                                    <th>Registered To</th>
                                                    <th>Department Issued</th>
                                                    <th>Firearm License Number</th>
                                                </tr>
                                            </thead>
                                            <tbody id="myCivFirearms">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="civTicketData" class="col-lg-12 col-md-12 col-sm-12 animated zoomIn" style="display: none;">
                            <div class="card widget-reports bg-grey">
                                <div class="header bg-grey">
                                    <h2>Tickets and Warnings</h2>
                                </div>
                                <div class="body bg-grey">
                                    <div class="table-responsive table-condensed">
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
                                            <tbody id="myCivTickets">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <form id="createACivilian" data-toggle="validator" class="animated slideInDown card bg-grey col-lg-10" style="display: none;" role="form">
                    <div class="col-lg-12 text-white">
                        <h6 class="text-white p-1 font-16">Civilian Creation Console</h6>
                        <hr />
                    </div>
                    <div class="row clearfix">
                        <div class="header bg-grey">
                            <h2>Basic Information</h2>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-3 form-group has-feedback m-t-0">
                                <h5>First Name*</h5>
                                <small id="civCreateFirstNameHelpInline" class="text-grey">Letters Only. Max 20 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                <input type="text" name="civCreateFirstName" aria-describedby="civCreateFirstNameHelpInline" title="Civilian First Name" pattern="[a-zA-Z]{1,20}" required class="p-2 civCreateFirstName input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Ronnie">
                            </div>
                            <div class="col-lg-3 form-group has-feedback m-t-0">
                                <h5>Last Name*</h5>
                                <small id="civCreateLastNameHelpInline" class="text-grey">Letters Only. Max 20 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                <input type="text" name="civCreateLastName" required aria-describedby="civCreateLastNameHelpInline" title="Civilian Last Name" pattern="[a-zA-Z]{1,20}" class="p-2 civCreateLastName input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Brazzers">
                            </div>
                            <div class="col-lg-3 form-group has-feedback m-t-0">
                                <h5>DOB (mm/dd/yyyy)*</h5>
                                <small id="civCreateDOBHelpInline" class="text-grey">Format, MM/DD/YYYY. Max 10 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                <input type="text" maxlength="10" name="civCreateDOB" aria-describedby="civCreateDOBHelpInline" required title="Date of Birth" pattern="(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d" class="p-2 civCreateDOB input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="10/25/1990">
                            </div>
                            <div class="col-lg-3 form-group has-feedback m-t-0">
                                <h5>Address</h5>
                                <small id="civCreateAddressHelpInline" class="text-grey">Letters and Numbers Only. Max 40 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                <input type="text" name="civCreateAddress" maxlength="40" aria-describedby="civCreateAddressHelpInline" title="Civilian Address" pattern="[a-zA-Z]{0-9}{1,40}" class="p-2 civCreateAddress input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="716 ROUTE 68, Harmony">
                            </div>
                        </div>
                    </div>


                    <div class="row clearfix">
                        <div class="header bg-grey">
                            <h2>Character Attributes</h2>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-2 form-group has-feedback m-t-0">
                                <h5>Gender*</h5>
                                <small id="civCreateGenderHelpInline" class="text-grey">Letters Only. Max 7 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                <input type="text" name="civCreateGender" maxlength="7" required" aria-describedby="civCreateGenderHelpInline" title="Civilian Gender" pattern="[a-zA-Z]{1,7}" class="p-2 civCreateGender input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Male/Female">
                            </div>
                            <div class="col-lg-2 form-group has-feedback m-t-0">
                                <h5>Hair*</h5>
                                <small id="civCreateHairHelpInline" class="text-grey">Letters Only. Max 10 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                <input type="text" name="civCreateHair" maxlength="10" required aria-describedby="civCreateHairHelpInline" title="Civilian Hair Color" pattern="[a-zA-Z]{1,10}" class="p-2 civCreateHair input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Black">
                            </div>
                            <div class="col-lg-3 form-group has-feedback m-t-0">
                                <h5>Ethnicity*</h5>
                                <small id="civCreateEthnicityHelpInline" class="text-grey">Letters Only. Max 15 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                <input type="text" name="civCreateEthnicity" maxlength="15" required aria-describedby="civCreateEthnicityHelpInline" title="Civilian Ethnicity" pattern="[a-zA-Z]{1,15}" class="p-2 civCreateEthnicity input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Asian">
                            </div>
                            <div class="col-lg-2 form-group has-feedback m-t-0">
                                <h5>Weight (lbs)*</h5>
                                <small id="civCreateWeightHelpInline" class="text-grey">Numbers Only. Max 5 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                <input type="text" name="civCreateWeight" maxlength="5" required aria-describedby="civCreateWeightHelpInline" title="Civilian Weight" pattern="[0-9]{1,5}" class="p-2 civCreateWeight input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Ex: 250">
                            </div>
                            <div class="col-lg-3 form-group has-feedback m-t-0">
                                <h5>Image Portrait*</h5>
                                <small id="civCreateImageHelpInline" class="text-grey">URL Only, must start with https:// <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                <input type="text" name="civCreateImage" required aria-describedby="civCreateImageHelpInline" title="Civilian Image" pattern="https?://.+" class="p-2 civCreateImage input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="https://sosarp.net/images/image.jpg">
                            </div>
                        </div>
                    </div>


                    <div class="row clearfix">
                        <div class="header bg-grey">
                            <h2>DMV Registration</h2>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-3 form-group has-feedback m-t-0">
                                <h5>License Number (Auto-Generated)*</h5>
                                <small id="civCreateLicenseNumberHelpInline" class="text-grey">Automatically Populated Field <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                <input type="text" name="civCreateLicenseNumber" aria-describedby="civCreateLicenseNumberHelpInline" required class="p-2 civCreateLicenseNumber input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-3 form-group has-feedback m-t-0">
                                <h5>License State*</h5>
                                <small id="civCreateLicenseStateHelpInline" class="text-grey">Letters Only. Max 20 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                <input type="text" name="civCreateLicenseState" maxlength="20" aria-describedby="civCreateLicenseStateHelpInline" title="Civilian State" pattern="[a-zA-Z\s]{1,20}" required class="p-2 civCreateLicenseState input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="New York">
                            </div>
                            <div class="col-lg-3 form-group has-feedback m-t-0">
                                <h5>License Expiration (Auto-Generated)*</h5>
                                <small id="civCreateLicenseExpHelpInline" class="text-grey">Automatically Populated Field <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                <input type="text" name="civCreateLicenseExp" aria-describedby="civCreateLicenseExpHelpInline" required class="p-2 civCreateLicenseExp input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" readonly>
                            </div>
                            <div class="col-lg-1 form-group has-feedback m-t-0">
                                <h5>Status*</h5>
                                <small id="civCreateLicenseStatusHelpInline" class="text-grey">Select One <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                <select name="civCreateLicenseStatus" required aria-describedby="civCreateLicenseStatusHelpInline" class="p-2 civCreateLicenseStatus input-block-level form-control bg-grey2 p-l-10" style="height: auto!important; font-size: 15px; color: #fff; min-width: 100%!important;">
                                    <option>Valid</option>
                                    <option>Revoked</option>
                                    <option>Expired</option>
                                </select>
                            </div>
                            <div class="col-lg-2 form-group has-feedback m-t-0">
                                <h5>Sign (Full Name)*</h5>
                                <small id="civCreateFullNameHelpInline" class="text-grey">Letters Only. Max 40 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                <input type="text" name="civCreateLicenseNumber" maxlength="40" aria-describedby="civCreateFullNameHelpInline" title="Civilian State" pattern="[a-zA-Z\s]{1,41}" required class="p-2 input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Ronnie Brazzers">
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
                            <button id="createCharacterBtn" type="submit" class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="createCivilianComplete('<%=Session["CivilianUser"]%>'); return false;">
                                CREATE
                            </button>
                        </div>
                        <div class="col-lg-3"></div>
                    </div>
                </form>

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

                <form id="registerVehicles" role="form" data-toggle="validator" class="animated slideInDown card bg-grey col-lg-10" style="display: none;">
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
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Vehicle Model*</h5>
                                    <small id="vehicleModelHelpInline" class="text-grey">Letters Only. Max 15 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input required type="text" name="vehicleModel" aria-describedby="vehicleModelHelpInline" title="Vehicle Model" pattern="[a-zA-Z]{1,15}" maxlength="15" class="p-2 vehCreateModel input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="DeClasse" required>
                                </div>
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Vehicle Make*</h5>
                                    <small id="vehCreateMakeHelpInline" class="text-grey">Letters Only. Max 15 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input required type="text" aria-describedby="vehCreateMakeHelpInline" class="p-2 vehCreateMake input-block-level form-control bg-grey2 p-l-10" title="Vehicle Make" pattern="[a-zA-Z]{1,15}" maxlength="15" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Granger">
                                </div>

                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Vehicle Color*</h5>
                                    <small id="vehCreateColorHelpInline" class="text-grey">Letters Only. Max 10 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input required type="text" aria-describedby="vehCreateColorHelpInline" class="p-2 vehCreateColor input-block-level form-control bg-grey2 p-l-10" title="Vehicle Color" pattern="[a-zA-Z]{1,10}" maxlength="10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Pink">
                                </div>
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Custom License Plate*</h5>
                                    <small id="vehCreatePlateHelpInline" class="text-grey">Letters and Numbers Only. Max 10 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input required type="text" aria-describedby="vehCreatePlateHelpInline" class="p-2 vehCreatePlate input-block-level form-control bg-grey2 p-l-10" title="Vehicle Plate" pattern="[a-zA-Z]{1-9}{1,10}" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="E4TSH1T" maxlength="10">
                                </div>
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Vehicle Owner*</h5>
                                    <small id="vehCreateOwnerHelpInline" class="text-grey">Automatically Populated Field <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input required type="text" aria-describedby="vehCreateOwnerHelpInline" class="p-2 vehCreateOwner input-block-level form-control bg-grey2 p-l-10" disabled style="font-size: 15px; color: #fff; min-width: 100%!important;">
                                </div>
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Insurance*</h5>
                                    <small id="vehCreateInsuranceHelpInline" class="text-grey">Select an Option <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <select required aria-describedby="vehCreateInsuranceHelpInline" class="vehCreateInsurance input-block-level form-control bg-grey2 p-l-10" style="height: auto!important; font-size: 15px; color: #fff; min-width: 100%!important;">
                                        <option>VALID</option>
                                        <option>EXPIRED</option>
                                    </select>
                                </div>
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Registration*</h5>
                                    <small id="vehCreateRegistrationHelpInline" class="text-grey">Select an Option <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <select required aria-describedby="vehCreateRegistrationHelpInline" class="vehCreateRegistration input-block-level form-control bg-grey2 p-l-10" style="height: auto!important; font-size: 15px; color: #fff; min-width: 100%!important;">
                                        <option>VALID</option>
                                        <option>EXPIRED</option>
                                    </select>
                                </div>
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Stolen*</h5>
                                    <small id="vehCreateStolenHelpInline" class="text-grey">Select an Option <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <select required aria-describedby="vehCreateStolenHelpInline" class="vehCreateStolen input-block-level form-control bg-grey2 p-l-10" style="height: auto!important; font-size: 15px; color: #fff; min-width: 100%!important;">
                                        <option>NO</option>
                                        <option>YES</option>
                                    </select>
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
                                <button type="submit" class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="registerVehicleComplete('<%=Session["CivilianUser"]%>'); return false;">
                                    REGISTER
                                </button>
                            </div>
                            <div class="col-lg-3"></div>
                        </div>
                    </div>
                </form>

                <form id="registerFirearms" role="form" data-toggle="validator" class="animated slideInDown card bg-grey col-lg-10" style="display: none;">
                    <div class="col-lg-12 text-white">
                        <h6 class="text-white p-1 font-16">Register a Firearm</h6>
                        <hr />
                    </div>
                    <div class="col-lg-12">
                        <div class="row clearfix">
                            <div class="header bg-grey">
                                <h2>Firearm Registration Form</h2>
                            </div>
                            <div class="col-lg-12">
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Type*</h5>
                                    <small id="firearmTypeHelpInline" class="text-grey">Select an Option <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <select required aria-describedby="firearmTypeHelpInline" name="firearmType" class="firearmType input-block-level form-control bg-grey2 p-l-10" style="height: auto!important; font-size: 15px; color: #fff; min-width: 100%!important;">
                                        <option value="Handgun">Handgun</option>
                                        <option value="Shotgun">Shotgun</option>
                                        <option value="SMG">SMG</option>
                                        <option value="LMG">LMG</option>
                                        <option value="AR">AR</option>
                                        <option value="SR">SR</option>
                                        <option value="Launchers/Other">Launchers/Other</option>
                                    </select>
                                </div>
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Firearm Name/Description*</h5>
                                    <small id="firemarmNameHelpInline" class="text-grey">Firearm Name/Description. Max 20 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input required type="text" aria-describedby="firemarmNameHelpInlineHelpInline" class="p-2 firemarmName input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" title="Firearm Name and Description" pattern="[a-zA-Z]{1,20}" maxlength="20" placeholder="Assault SMG">
                                </div>
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Date Issued*</h5>
                                    <small id="firearmIssuedHelpInline" class="text-grey">Date Issued. Format, MM/DD/YYYY <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input required type="text" aria-describedby="firearmIssuedHelpInline" class="p-2 firearmIssued input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" title="Date Issued" pattern="(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d" placeholder="12/25/2017" maxlength="10">
                                </div>
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Date Expired*</h5>
                                    <small id="firearmExpiredHelpInline" class="text-grey">Date Expired. Format, MM/DD/YYYY <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input required type="text" aria-describedby="firearmExpiredHelpInline" class="p-2 firearmExpired input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" title="Date Expired" pattern="(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d" placeholder="12/25/2019">
                                </div>
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Registrant*</h5>
                                    <small id="firearmOwnerHelpInline" class="text-grey">Automatically Populated Field <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input required type="text" aria-describedby="firearmOwnerHelpInline" class="p-2 firearmOwner input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" disabled>
                                </div>
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Firearm License Number*</h5>
                                    <small id="firearmLicenseNumberHelpInline" class="text-grey">Automatically Populated Field <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input required type="text" aria-describedby="firearmLicenseNumberHelpInline" class="p-2 firearmLicenseNumber input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" disabled>
                                </div>
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Department Issued*</h5>
                                    <small id="firearmDeptHelpInline" class="text-grey">4 Letter Department Code <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input required type="text" aria-describedby="firearmDeptHelpInline" class="p-2 firearmDept input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" maxlength="4" title="Four Letter Department Code" pattern="[a-zA-Z]{4}" placeholder="LSPD">
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
                                <button type="submit" class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="registerFirearmComplete('<%=Session["CivilianUser"]%>'); return false;">
                                    REGISTER
                                </button>
                            </div>
                            <div class="col-lg-3"></div>
                        </div>
                    </div>
                </form>

                <form data-toggle="validator" role="form" id="createATicket" class="animated slideInDown card bg-grey col-lg-10" style="display: none;">
                    <div class="col-lg-12 text-white">
                        <h6 class="text-white p-1 font-16">Civilian Citation Form</h6>
                        <hr />
                    </div>
                    <div class="col-lg-12">
                        <div class="row clearfix">
                            <div class="header bg-grey">
                                <h2>Create a Ticket</h2>
                            </div>
                            <div class="col-lg-12">
                                <div class="col-lg-2 form-group has-feedback m-t-0">
                                    <h5>Full Name*</h5>
                                    <small id="ticketFullNameHelpInline" class="text-grey">Automatically Populated Field <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input type="text" required class="p-2 ticketFullName input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" readonly>
                                </div>
                                <div class="col-lg-2 form-group has-feedback m-t-0">
                                    <h5>Date*</h5>
                                    <small id="ticketDateHelpInline" class="text-grey">Format, MM/DD/YYYY <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input type="text" required maxlength="10" class="p-2 ticketDate input-block-level form-control bg-grey2 p-l-10" title="Date Issued" pattern="(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="12/12/2017">
                                </div>
                                <div class="col-lg-2 form-group has-feedback m-t-0">
                                    <h5>Ticket Unit</h5>
                                    <small id="ticketUnitHelpInline" class="text-grey">Automatically Populated Field <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input type="text" class="p-2 ticketUnit input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" value="A-000" readonly>
                                </div>
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Ticket Location*</h5>
                                    <small id="ticketLocationHelpInline" class="text-grey">Letters and Numbers Only. Max 25 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input type="text" required class="p-2 ticketLocation input-block-level form-control bg-grey2 p-l-10" title="Ticket Location" pattern="[a-zA-Z]{1-25}" maxlength="25" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Paleto">
                                </div>
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>License Number*</h5>
                                    <small id="licenseNumberHelpInline" class="text-grey">Automatically Populated Field <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input type="text" required class="p-2 licenseNumber input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" readonly>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="col-lg-5 form-group has-feedback m-t-0">
                                    <h5>Ticket Details*</h5>
                                    <small id="ticketDetailsHelpInline" class="text-grey">Free-text. Max 50 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <textarea rows="5" required class="p-2 ticketDetails input-block-level form-control bg-grey2 p-l-10" maxlength="50" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Describe the reason for the this ticket to be issued"></textarea>
                                </div>
                                <div class="col-lg-5 form-group has-feedback m-t-0">
                                    <h5>Ticket Charges*</h5>
                                    <small id="ticketChargesHelpInline" class="text-grey">Free-text. Max 50 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <textarea rows="5" required class="p-2 ticketCharges input-block-level form-control bg-grey2 p-l-10" maxlength="50" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Speeding, Failure to Stop, etc."></textarea>
                                </div>
                                <div class="col-lg-2 form-group has-feedback m-t-0">
                                    <h5>Total Fines</h5>
                                    <small id="ticketFinesHelpInline" class="text-grey">Format: $900.00. Max 10 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input type="text" class="p-2 ticketFines input-block-level form-control bg-grey2 p-l-10" title="Total Fines" pattern="\$\d+(\.\d{2})?" maxlength="10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="$2500">
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
                                <button type="submit" class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="createTicketComplete(); return false;">
                                    CREATE
                                </button>
                            </div>
                            <div class="col-lg-3"></div>
                        </div>
                    </div>
                </form>

                <!--Call911-->
                <form id="call911" role="form" data-toggle="validator" class="animated slideInDown card bg-grey col-lg-10" style="display: none;">
                    <div class="col-lg-12 text-white">
                        <h6 class="call911Phone text-white p-1 font-16"></h6>
                        <hr />
                    </div>
                    <div class="col-lg-12">
                        <div class="row clearfix">
                            <div class="header bg-grey">
                                <h1 class="callingText text-danger animated infinite flash text-center">CALLING 911...</h1>
                            </div>
                            <div class="chat scrollbarChat style-1">
                                <div class="col-lg-12 force-overflow bg-grey2">
                                    <div class="chat-history">
                                        <ul>
                                            <li class="911dispatcher clearfix" style="visibility: hidden;">
                                                <div class="message-data text-right"><span class="message-data-name">Dispatcher</span></div>
                                                <div class="message other-message float-right">911, what is your Emergency? </div>
                                            </li>
                                        </ul>
                                        <ul>
                                            <li class="911caller animated slideInLeft" style="display: none;">
                                                <div class="message-data"><span class="911callerName message-data-name"></span><span class="message-data-time 911location text-white"></span></div>
                                                <div class="911message message my-message"></div>
                                            </li>
                                        </ul>
                                        <ul>
                                            <li class="911dispatcher2 clearfix animated slideInRight" style="display: none;">
                                                <div class="message-data text-right"><span class="message-data-name">Dispatcher</span></div>
                                                <div class="message other-message float-right">We will send a Unit your way. A message will appear on your screen when they are on their way.</div>
                                            </li>
                                        </ul>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-12 chat-message clearfix">
                                <div class="col-lg-7 form-group has-feedback m-t-0">
                                    <h5>Call Details</h5>
                                    <small id="callDetailsHelpInline" class="text-grey">Free-text. Max 50 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <textarea rows="3" aria-describedby="callDetailsHelpInline" maxlength="50" required class="p-2 callDetails input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Please explain your reason for this call..."></textarea>
                                </div>
                                <div class="col-lg-3 form-group has-feedback m-t-0">
                                    <h5>Location</h5>
                                    <small id="callLocationHelpInline" class="text-grey">Letters and Numbers Only. Max 25 <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input type="text" aria-describedby="callLocationHelpInline" required title="Call Location" pattern="[a-zA-Z]{1-25}" class="p-2 callLocation input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" placeholder="Sandy Shores">
                                </div>
                                <div class="col-lg-2 form-group has-feedback m-t-0">
                                    <h5>Date</h5>
                                    <small id="callDateHelpInline" class="text-grey">Automatically Populated <span class="glyphicon glyphicon-ok form-control-feedback"></span></small>
                                    <input type="text" aria-describedby="callDateHelpInline" class="p-2 callDate input-block-level form-control bg-grey2 p-l-10" style="font-size: 15px; color: #fff; min-width: 100%!important;" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-lg-3"></div>
                            <div class="col-lg-3">
                                <button class="pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="returnToMenu(); return false;">
                                    HANG UP
                                </button>
                            </div>
                            <div class="col-lg-3">
                                <button type="submit" class="sendCallbtn pull-right btn btn-raised bg-grey2 btn-block waves-effect btn-lg" style="color: #fff;" onclick="create911Call(); return false;">
                                    SEND
                                </button>
                            </div>
                            <div class="col-lg-3"></div>
                        </div>
                    </div>
                </form>
            </div>
        </div>



    </section>

    <script>
        var SessionID = '<%=Session["CivilianUser"]%>';
        $("form").on("submit", function (event) {
            $(this).serialize();
        });
    </script>
</asp:Content>

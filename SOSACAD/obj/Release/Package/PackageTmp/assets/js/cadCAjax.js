$(document).ready(function () {
    getCalls();
    getUnits();
    getCivs();
    getVehs();
    $("#108button").prop("disabled", true);
    $("#1041button").prop("disabled", true);
    $("#107button").prop("disabled", true);
    $("#106button").prop("disabled", true);
    $("#105button").prop("disabled", true);
    $("#1023button").prop("disabled", true);
    $("#1097button").prop("disabled", true);
    $("#1042button").prop("disabled", true);
    $(".currentControlText").hide();
    $(".busyUnitsTable").hide();
    $("#boloCalls").hide();

    //Set Intervals for Data Refreshing
    window.setInterval(function () {
        getCalls();
    }, 15000);
    window.setInterval(function () {
        getUnits();
    }, 4000);

    //Keep Session Alive
    $(function () {
        setInterval(KeepSessionAlive, 10000);
    });
    function KeepSessionAlive() {
        $.post("Shared/KeepSessionAlive.ashx", null, function () {
        });
    }   

    //Toggle Function
    $.fn.extend({
        toggleText: function (a, b) {
            return this.text(this.text() == b ? a : b);
        }
    });
});

//Variables
var civTags = [];
var vehTags = [];
var notifyAlert = function () {};
var now = new Date();
var currentID = "";
var lastID = "";

//jQuery SerializerArrToJSON
function jQFormSerializeArrToJson(formSerializeArr) {
    var jsonObj = {};
    jQuery.map(formSerializeArr, function (n, i) {
        jsonObj[n.name] = n.value;
    });

    return jsonObj;
}

//Load and Display all Elements of the Logged in Dispatcher Account
function loadDispatcherData(SessionID) {
    $.ajax({
        type: "POST",
        url: "CADC.aspx/GetUnitData",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (unitData) {
                $("#loggedUser").text(unitData.Name);
                $("#currentIdentifier").text(unitData.Division);
                $("#currentPatrolStatus").html("<span class='text-success'>Connected and Transmitting as: " + unitData.Division + "</span>");
            }))
        },
        failure: function (response) {

        },
        complete: function (response) { }
    });
}

//Load and Display all Calls
function getCalls() {
    notifyAlert.SendAlert = function () { return false;};
    $.ajax({
        type: "POST",
        url: "CADC.aspx/GetAllCalls",
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $('#ActiveCallsData').css('visibility', 'hidden');
            $('#ActiveCallsData').html("");
            $('#PendingCallsData').css('visibility', 'hidden');
            $('#PendingCallsData').html("");
            $('#boloCalls').css('visibility', 'hidden');
            $('#boloCalls').html("");
            ($.map(data.d, function (callData) {
                if (callData.Status === "Pending") {
                    currentID = callData.ID;
                    pendingCalls = "<tr class='bg-grey2'><td>" + callData.Caller + "</td>" + "<td>" + callData.Location + "</td>" + "<td>" + callData.Date_Time + "</td>" + "<td>" + callData.Description + "</td>" + "<td><span id='" + callData.ID + "' class='assignBtn label label-default d-block'>Must Select a Unit First</span>" +
                        "</td>" + "</tr>";
                    $('#PendingCallsData').append(pendingCalls);
                } else if (callData.Status === "Active") {
                    var activeCalls = "<tr class='bg-darkred'><td>" + callData.Caller + "</td>" + "<td>" + callData.Location + "</td>" + "<td>" + callData.Date_Time + "</td>" + "<td>" + callData.Description + "</td>" + "<td>" + callData.Unit_Responding + "</td><td>" + callData.Notes + "</td>" +
                        "<td class='text-center'>" + "<span class='m-l-5 label bg-grey2 d-block' onclick='openMenu(\"" + callData.ID + "\")' return false;' style='cursor:pointer;'>MENU</span>" + "</tr>";
                    $('#ActiveCallsData').append(activeCalls);
                } else if (callData.Status === "Vehicle Bolo" || callData.Status === "Person Bolo") {
                    var activeBolo = "<tr class='bg-darkred'><td>" + callData.Caller + "</td>" + "<td>" + callData.Location + "</td>" + "<td>" + callData.Date_Time + "</td>" + "<td>" + callData.Description + "</td>" + "<td>" + callData.Unit_Responding + "</td><td>" + callData.Notes + "</td>" +
                        "<td class='text-center'>" + "<span class='m-l-5 label bg-grey2 d-block' onclick='openMenu(\"" + callData.ID + "\")' return false;' style='cursor:pointer;'>MENU</span>" + "</tr>";
                    $("#boloCalls").append(activeBolo);
                }
            }))

        },
        failure: function (response) {
            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function (data) {
            $('#ActiveCallsData').css('visibility', 'visible');
            $('#PendingCallsData').css('visibility', 'visible');
            $('#boloCalls').css('visibility', 'visible');
            if (currentID != lastID) {
                document.getElementById('mySoundClip').play();
                notifyAlert.SendAlert = function () {
                    $.notify({
                        message: "<span style='font-size:15px;'><strong>Attention:</strong> There are <strong>pending</strong> calls awaiting assignment</span>"
                    }, {
                            type: "danger",
                            allow_dismiss: false,
                            newest_on_top: true,
                            timer: 2000,
                            placement: {
                                from: "top",
                                align: "center"
                            },
                            animate: {
                                enter: "animated fadeInDown",
                                exit: "animated fadeOutUp"
                            }
                        });
                };
                notifyAlert.SendAlert();
            }
            lastID = currentID;
            getStats();
        }
    });
}

//Load and Display all LEO/Units
function getUnits() {
    $.ajax({
        type: "POST",
        url: "CADC.aspx/GetAllUnits",
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $('#availableUnits').css('visibility', 'hidden');
            $('#availableUnits').html("");
            $('#busyUnits').css('visibility', 'hidden');
            $('#busyUnits').html("");
            
            ($.map(data.d, function (unitData) {
                var availableHTML = "<tr class='success'>" + "<td>" + unitData.Unit_Number + "</td>" + "<td>" + unitData.Name + "</td>" + "<td>" + unitData.Status + "</td>" + "<td><a href='javascript: void(0)' onclick='loadUnitData(\"" + unitData.Unit_Number + "\")'><span class='label bg-grey2'>Select</span></a></td><td>" + unitData.UnitIcon + "</td>" + "</tr>";
                var busyHTML = "<tr class='bg-grey2'>" + "<td>" + unitData.Unit_Number + "</td>" + "<td>" + unitData.Name + "</td>" + "<td>" + unitData.Status + "</td>" + "<td><a href='javascript: void(0)' onclick='loadUnitData(\"" + unitData.Unit_Number + "\")'><span class='label bg-grey2'>Select</span></a></td><td>" + unitData.UnitIcon + "</td>" + "</tr>";
                if (unitData.Status === "10-8" || unitData.Status === "10-19" || unitData.Status === "10-23" || unitData.Status === "10-97" || unitData.Status === "SIGNAL 11" || unitData.Status === "10-12") {
                    availUnits = availableHTML;
                    $('#availableUnits').append(availUnits);
                }
                if (unitData.Status === "10-5" || unitData.Status === "10-6" || unitData.Status === "10-7" || unitData.Status === "10-41" || unitData.Status === "10-15" || unitData.Status === "10-11") {
                    availUnits = busyHTML;
                    $('#busyUnits').append(availUnits);
                }
            }))
        },
        failure: function (response) {
        },
        complete: function (response) {
            $('#availableUnits').css('visibility', 'visible');
            $('#busyUnits').css('visibility', 'visible');
        }
    });
}

//Get an Populate list of all Vehicles in auto-complete search input
function getVehs() {
    $.ajax({
        type: "POST",
        url: "/api/Vehicle/GetAllVehicles",
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data, function (vehData) {
                vehTags.push(vehData.License_Number);
            }))
        },
        failure: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () {

        }
    });
}

//Open the Vehicle Search box Dialog
function vehSearchDialog() {
    $('<div id="civilianLookup" class="col-lg-12" style="display:none;"> <div> <label for="plateLookup">License Plate Number</label> <input id="plateLookup" type="text" class="plateLookup input-block-level form-control bg-grey2 text-center" style="color: #B1B1B1; min-width: 100%!important; font-size: 18px;"> </div> </div>').dialog({
        title: 'NCIC Vehicle Database',
        height: 'auto',
        width: '20%',
        buttons: {
            Cancel: function () {
                $(this).dialog('close')
            },
            Search: function () {
                searchVeh($('#plateLookup').val());
                $(this).dialog('close')
            } //end function for Ok button
        } //end buttons
    });
    $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
    $('#vehDetails').html();
    $(".plateLookup").autocomplete({
        source: vehTags
    });
}

//Load and Display the Searched Vehicles Data
function searchVeh(vehPlate) {
    var vehicles = [];
    var vehJSONData = {
        "License_Number": vehPlate
    };
    $.ajax({
        type: "POST",
        url: "api/Vehicle/VehicleLookup",
        data: JSON.stringify(vehJSONData),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data, function (vehData) {
                $(".licensePlateNumber").text(vehData.License_Number);
                if (vehData.Registration_Valid === "Expired") {
                    $(".plateTopLeft").css("font-size", 12);
                    $(".plateTopLeft").addClass("animated infinite flash");
                } else {
                    $(".plateTopLeft").css("font-size", 16);
                    $(".plateTopLeft").removeClass("animated infinite flash");
                }
                $(".licensePlateExpiration").text(vehData.Registration_Valid);
                $(".insuranceStatus").text(vehData.Insurance_Valid);
                $(".stolenStatus").text(vehData.Stolen);
                $(".vehModel").text(vehData.Model);
                $(".vehMake").text(vehData.Make);
                $(".vehColor").text(vehData.Color);
                $(".vehOwner").text(vehData.Owner);
                var vehInfo = $('#vehDetails').html();
                $('<div class="card col-lg-12" style="background:#333;">' + vehInfo + '</div>').dialog({
                    title: vehData.License_Number + " - " + vehData.Model + " " + vehData.Make,
                    height: 'auto',
                    width: '40%',
                    modal: true,
                    draggable: false,
                    resizable: false,
                    close: function () {
                        location.reload();
                    },
                    buttons: {
                        Done: function () {
                            $(this).dialog('close');
                            location.reload();
                        } //end function for Ok button

                    }//end buttons
                });
                $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
            }))
        },
        failure: function (response) {

        },
        complete: function () {
            $('#SearchResultsVehs').css('visibility', 'visible');
        }
    });
}

//Get an Populate list of all Civilian Characters in auto-complete search input
function getCivs() {
    $.ajax({
        type: "POST",
        url: "api/Civilian/GetAllCivilians",
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data, function (civData) {
                civTags.push(civData.Full_Name);
            }))
            $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
        },
        failure: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () { }
    });
}


//Open the Civilain Character Search box Dialog
function civSearchDialog() {
    $('<div id="civilianLookup" class="col-lg-12" style="display:none;"> <div> <label for="nameLookup">Name</label> <input id="nameLookup" type="text" class="nameLookup input-block-level form-control bg-grey2 text-center" style="color: #B1B1B1; min-width: 100%!important; font-size: 18px;"> </div> </div>').dialog({
        title: 'NCIC Civilian Database',
        height: 'auto',
        width: '20%',
        buttons: {
            Cancel: function () {
                $(this).dialog('close')
            },
            Search: function () {
                searchCiv($('#nameLookup').val());
                $(this).dialog('close')
            } //end function for Ok button
        } //end buttons
    });
    $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
    $(".nameLookup").autocomplete({
        source: civTags
    });
}

//Load and Display the Searched Civilian Character
function searchCiv(civName) {
    var revoked = "";
    var civJSONData = {
        "Full_Name": civName
    };
    $.ajax({
        type: "POST",
        url: "api/Civilian/CivilianLookup",
        data: JSON.stringify(civJSONData),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data, function (civData) {
                document.getElementById("btnsCivDetails").innerHTML = '<button type="button" class="btn btn-raised bg-grey btn-block btn-lg waves-effect" style="color: #B1B1B1;" onclick="createWarrant(' + civData.License_Number + ')">CREATE WARRANT</button> <button type="button" class="btn btn-raised bg-grey btn-block btn-lg waves-effect" style="color: #B1B1B1;" onclick="createArrest(' + civData.License_Number + ')">ARREST REPORT</button> <button type="button" class="btn btn-raised bg-grey btn-block btn-lg waves-effect" style="color: #B1B1B1;" onclick="createTicket(' + civData.License_Number + ')">WRITE CITATION</button> <button type="button" class="btn btn-raised bg-grey btn-block btn-lg waves-effect" style="color: #B1B1B1;" onclick="createWarning(' + civData.License_Number + ')">ISSUE WARNING</button>';
                var civInfo = $('#civDetails').html();
                $('<div class="card col-lg-12" style="background:#333;">' + civInfo + '</div>').dialog({
                    title: civData.Full_Name + " - " + civData.License_Number,
                    height: 'auto',
                    width: '60%',
                    modal: true,
                    draggable: false,
                    resizable: false,
                    close: function () {
                        location.reload();
                    },
                    buttons: {
                        Done: function () {
                            $(this).dialog('close');
                        } //end function for Ok button

                    }//end buttons
                });
                $(".firstName").html(civData.First_Name);
                $(".lastName").html(civData.Last_Name);
                $(".address").html(civData.Address);
                $(".dob").html(civData.DOB);
                $(".gender").html(civData.Gender);
                $(".hair").html(civData.Hair);
                $(".ethnicity").html(civData.Ethnicity);
                $(".weight").html(civData.Weight);
                $(".licenseExp").html(civData.License_Expiration);
                $(".licenseState").text(civData.License_State);
                $(".licenseNumberID").text(civData.License_Number);
                $(".licenseImage").attr("src", civData.Portrait);
                $(".ui-button").addClass('btn bg-grey2 btn-block btn-sm btn-raised text-white');
                civTickets(civData.License_Number);
                civArrests(civData.License_Number);
                civWarrants(civData.License_Number);
                revoked = civData.License_Status;
            }))

        },
        failure: function (response) {

        },
        complete: function () {
            if (revoked == "Valid") {
                $(".licenseStatus").html('<span class="text-success">' + revoked + '</span>');
            }
            if (revoked == "Revoked") {
                $(".licenseStatus").html('<span class="text-danger">' + revoked + '</span>');
            }
            if (revoked == "Expired") {
                $(".licenseStatus").html('<span class="text-warning">' + revoked + '</span>');
            }
        }
    });
}

//Load and Display the Searched Civilian Character Arrests
function civArrests(civLicense) {
    var arrests = [];
    var civArrestsJSONData = {
        "licenseNumber": civLicense
    };
    $(".priorArrests").html("");
    $.ajax({
        type: "POST",
        url: "api/Civilian/LoadArrests",
        data: JSON.stringify(civArrestsJSONData),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data, function (arrestData) {
                arrests = "<tr class='bg-grey2'>" +
                    "<td>" + arrestData.ID + "</td>" +
                    "<td>" + arrestData.arrestDetails + "</td>" +
                    "<td>" + arrestData.arrestCharges + "</td>" +
                    "<td>" + arrestData.arrestOfficer + "</td>" +
                    "<td><a href='javascript: void(0)' onclick='viewArrestDetails(\"" + arrestData.ID + "\")'><span class='label label-default'>View</span></a></td>" +
                    "</tr>";
                $(".priorArrests").append(arrests);
            }))

        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//Load and Display the Searched Civilian Character Tickets
function civTickets(civLicense) {
    var tickets = [];
    var civTicketsJSONData = {
        "licenseNumber": civLicense
    };
    $(".priorTraffic").html("");
    $.ajax({
        type: "POST",
        url: "api/Civilian/LoadTickets",
        data: JSON.stringify(civTicketsJSONData),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data, function (ticketData) {
                tickets = "<tr class='bg-grey2'>" +
                    "<td>" + ticketData.ID + "</td>" +
                    "<td>" + ticketData.ticketDetails + "</td>" +
                    "<td>" + ticketData.ticketCharges + "</td>" +
                    "<td>" + ticketData.ticketOfficer + "</td>" +
                    "<td><a href='javascript: void(0)' onclick='viewTicketDetails(\"" + ticketData.ID + "\")'><span class='label label-default'>View</span></a></td>" +
                    "</tr>";
                $(".priorTraffic").append(tickets);
            }))

        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}


//Load and Display the Searched Civilian Character Warrants
function civWarrants(civLicense) {
    var warrants = [];
    var civWarrantsJSONData = {
        "licenseNumber": civLicense
    };
    $(".priorWarrants").html("");
    $.ajax({
        type: "POST",
        url: "api/Civilian/LoadWarrants",
        data: JSON.stringify(civWarrantsJSONData),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data, function (warrantData) {
                warrants = "<tr class='bg-grey2'>" +
                    "<td>" + warrantData.ID + "</td>" +
                    "<td>" + warrantData.warrantDateIssued + "</td>" +
                    "<td>" + warrantData.warrantCharges + "</td>" +
                    "<td>" + warrantData.warrantStatus + "</td>" +
                    "<td><a href='javascript: void(0)' onclick='viewWarrantDetails(\"" + warrantData.ID + "\")'><span class='label label-default'>View</span></a></td>" +
                    "</tr>";
                $(".priorWarrants").append(warrants);
            }))
        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//On click Event to View Warrant Details of Searched Character
function viewWarrantDetails(ID) {
    var arrests = [];
    $.ajax({
        type: "POST",
        url: "CAD.aspx/CivWarrantDetails",
        data: "{'ID':'" + ID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (warrantData) {
                var viewWarrantDetailsDialog = $('#warrantFormDetails').html();
                $(viewWarrantDetailsDialog).dialog({
                    title: "#" + ID + ' - Warrant Information - ' + warrantData.Full_Name + " - " + warrantData.License_Number,
                    height: 'auto',
                    width: '40%',
                    buttons: {
                        Cancel: function () {
                            $(this).dialog('close')
                        },
                    } //end buttons
                });
                $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
                $(".warrantNameDetails").val(warrantData.Full_Name);
                $(".warrantLicenseNumber").val(warrantData.License_Number);
                $(".warrantDetailsCharges").val(warrantData.Warrant_Charges);
                $(".warrantDetailsDateIssued").val(warrantData.Warrant_Issued);
                $(".warrantDetailsStatus").val(warrantData.Warrant_Status);
                $(".warrantDetailsOfficer").val(warrantData.Warrant_Officer);
                $(".warrantDetailsDept").val(warrantData.Warrant_Department);
            }))
        },
        failure: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () { }
    });
}

//On click Event to View Arrest Details of Searched Character
function viewArrestDetails(ID) {
    var arrests = [];
    $.ajax({
        type: "POST",
        url: "CAD.aspx/CivArrestDetails",
        data: "{'ID':'" + ID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (arrestData) {
                var viewArrestDetailsDialog = $('#arrestFormDetails').html();
                $(viewArrestDetailsDialog).dialog({
                    title: "#" + ID + ' - Arrest Information - ' + arrestData.Full_Name + " - " + arrestData.License_Number,
                    height: 'auto',
                    width: '40%',
                    buttons: {
                        Cancel: function () {
                            $(this).dialog('close')
                        },
                    } //end buttons
                });
                $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
                $(".arrestNameDetails").val(arrestData.Full_Name);
                $(".arrestLicenseNumber").val(arrestData.License_Number);
                $(".arrestDetailsCharges").val(arrestData.Arrest_Charges);
                $(".arrestDetailsDateIssued").val(arrestData.Date);
                $(".arrestDetailsLocation").val(arrestData.Arrest_Location);
                $(".arrestDetailsDetailsOfficer").val(arrestData.Arrest_Unit);
                $(".arrestDetailsDetails").val(arrestData.Arrest_Details);
                $(".arrestDetailsFines").val(arrestData.Arrest_Fine);
                $(".arrestActiveWarrant").val(arrestData.Arrest_Warrant_Active)
            }))
        },
        failure: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () { }
    });
}

//On click Event to View Ticket Details of Searched Character
function viewTicketDetails(ID) {
    var ticketFullName = "";
    var ticketDate = "";
    var ticketDetails = "";
    var ticketUnit = "";
    var ticketLocation = "";
    var ticketFine = "";
    var ticketJailTime = "";
    var ticketCharges = "";
    var licenseNumber = "";
    $.ajax({
        type: "POST",
        url: "CAD.aspx/CivTicketDetails",
        data: "{'ID':'" + ID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (ticketData) {
                ticketFullName = ticketData.Full_Name;
                ticketDate = ticketData.Date;
                ticketDetails = ticketData.Ticket_Details;
                ticketUnit = ticketData.Ticket_Unit;
                ticketLocation = ticketData.Ticket_Location;
                ticketFine = ticketData.Ticket_Fine;
                ticketJailTime = ticketData.Ticket_Jailtime;
                ticketCharges = ticketData.Ticket_Charges;
                licenseNumber = ticketData.License_Number;
                var viewTicketDetailsDialog = $('#ticketDetailsDialog').html();
                $(viewTicketDetailsDialog).dialog({
                    title: "#" + ID + ' - Ticket Information - ' + ticketFullName + " - " + licenseNumber,
                    height: 'auto',
                    width: '40%',
                    buttons: {
                        Cancel: function () {
                            $(this).dialog('close')
                        },
                    } //end buttons
                });
                $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
                $(".ticketDetailName").val(ticketFullName);
                $(".ticketDetailLicense").val(licenseNumber);
                $(".ticketCharges").val(ticketCharges);
                $(".ticketDetailDate").val(ticketDate);
                $(".ticketDetailLocation").val(ticketLocation);
                $(".ticketDetailOfficer").val(ticketUnit);
                $(".ticketDetailsSum").val(ticketDetails);
                $(".ticketDetailFineTotal").val(ticketFine);
            }))
        },
        failure: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () { }
    });
}


//On click Event to Open Create Warrant Dialog of Searched Character
function createWarrant(License) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/WarrantReport",
        data: "{'License':'" + License + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            var d = new Date();
            var strDate = d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear();
            ($.map(data.d, function (civData) {
                var warrantInfoForm = $('#warrantForm').html();
                $('#warrantForm').dialog({
                    title: 'Warrant Form - ' + civData.Full_Name + " - " + civData.License_Number,
                    height: 'auto',
                    width: '30%',
                    position: {
                        my: "center"
                    }
                });

                $(".fullName").val(civData.Full_Name);
                $(".licenseNumber").val(civData.License_Number);
                $(".licenseState").val(civData.License_State);
                $(".warrantDateIssued").val(strDate);
                $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
            }))
        },
        failure: function (response) {

            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () {

        }
    });
}

//On click Event to Open Create Arrest Dialog of Searched Character
function createArrest(License) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/ArrestReport",
        data: "{'License':'" + License + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            var d = new Date();
            var strDate = d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear();
            ($.map(data.d, function (civData) {
                var arrestInfoForm = $('#arrestForm').html();
                $('#arrestForm').dialog({
                    title: 'Arrest Form - ' + civData.Full_Name + " - " + civData.License_Number,
                    height: 'auto',
                    width: '30%',
                    position: {
                        my: "center"
                    }
                });

                $(".fullName").val(civData.Full_Name);
                $(".licenseNumber").val(civData.License_Number);
                $(".licenseState").val(civData.License_State);
                $(".arrestDateIssued").val(strDate);
                $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
            }))
        },
        failure: function (response) {

            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () {

        }
    });
}

//On click Event to Open Create Ticket Dialog of Searched Character
function createTicket(License) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/TicketReport",
        data: "{'License':'" + License + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            var d = new Date();
            var strDate = d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear();
            ($.map(data.d, function (civData) {
                $('#ticketForm').dialog({
                    title: 'Citation - ' + civData.Full_Name + " - " + civData.License_Number,
                    height: 'auto',
                    width: '30%',
                    position: {
                        my: "center"
                    }
                });

                $(".fullName").val(civData.Full_Name);
                $(".licenseNumber").val(civData.License_Number);
                $(".licenseState").val(civData.License_State);
                $(".ticketDateIssued").val(strDate);
                $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
            }))
        },
        failure: function (response) {

            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () {

        }
    });
}

//On click Event to Open Create Warning Dialog of Searched Character
function createWarning(License) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/WarningReport",
        data: "{'License':'" + License + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            var d = new Date();
            var strDate = d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear();
            ($.map(data.d, function (civData) {
                var warningInfoForm = $('#warningForm').html();
                $('#warningForm').dialog({
                    title: 'Warning - ' + civData.Full_Name + " - " + civData.License_Number,
                    height: 'auto',
                    width: '30%',
                    position: {
                        my: "center"
                    }
                });
                $(".fullName").val(civData.Full_Name);
                $(".licenseNumber").val(civData.License_Number);
                $(".licenseState").val(civData.License_State);
                $(".warningDateIssued").val(strDate);
                $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
            }))
        },
        failure: function (response) {
        },
        complete: function () {

        }
    });
}

//On click Event to Submit the Created Warrant of Searched Character
$('#createWarrantBtn').click(function (event) {
    var warrantFormSerialized = jQFormSerializeArrToJson($("#warrantForm").serializeArray());
    console.log(JSON.stringify(warrantFormSerialized));
    $.ajax({
        type: "POST",
        url: "api/Civilian/AddWarrant",
        data: JSON.stringify(warrantFormSerialized),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            console.log(data)
        },
        failure: function () {

        },
        complete: function (data) {
            civWarrants(data.responseJSON);
            $('#warrantForm').dialog('close');
        }
    });
    event.preventDefault();
});

//On click Event to Submit the Created Arrest of Searched Character
$('#createArrestBtn').click(function (event) {
    var arrestFormSerialized = jQFormSerializeArrToJson($("#arrestForm").serializeArray());
    $.ajax({
        type: "POST",
        url: "api/Civilian/AddArrest",
        data: JSON.stringify(arrestFormSerialized),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function () {
        },
        failure: function () {

        },
        complete: function (data) {
            civArrests(data.responseJSON);
            $('#arrestForm').dialog('close');
        }
    });
    event.preventDefault();
});

//On click Event to Submit the Created Ticket of Searched Character
$('#createTicketBtn').click(function (event) {
    var ticketFormSerialized = jQFormSerializeArrToJson($("#ticketForm").serializeArray());
    $.ajax({
        type: "POST",
        url: "api/Civilian/AddTicket",
        data: JSON.stringify(ticketFormSerialized),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function () {
        },
        failure: function () {

        },
        complete: function (data) {
            civTickets(data.responseJSON);
            $('#ticketForm').dialog('close');
        }
    });
    event.preventDefault();
});

//On click Event to Submit the Created Warning of Searched Character
$('#createWarningBtn').click(function (event) {
    var warningFormSerialized = jQFormSerializeArrToJson($("#warningForm").serializeArray());
    $.ajax({
        type: "POST",
        url: "api/Civilian/AddWarning",
        data: JSON.stringify(warningFormSerialized),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
        },
        failure: function (data) {
        },
        complete: function (data) {
            civTickets(data.responseJSON);
            $('#warningForm').dialog('close');
        }
    });
    event.preventDefault();
});


//Load the Selected Unit Data onto the Console
function loadUnitData(UnitNumber, CallID) {
    $.ajax({
        type: "POST",
        url: "CADC.aspx/LoadUnit",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (unitData) {
                $("#UnitName").text(unitData.Name);
                $("#UnitNumber").text(unitData.Unit_Number);
                $(".assignBtn").each(function () {
                    $(this).html("<a href='javascript: void(0)' class='text-white' onclick='assignUnitData(\"" + UnitNumber + "\",\"" + $(this).attr('id') + "\")'>Assign to: " + unitData.Name + " " + unitData.Unit_Number + "</a>");
                    $(this).addClass('bg-success');
                });
            }))
        },
        failure: function (response) {
        },
        complete: function (response) {
            $(".currentControlText").show();
            $("#108button").prop("disabled", false);
            $("#1041button").prop("disabled", false);
            $("#107button").prop("disabled", false);
            $("#106button").prop("disabled", false);
            $("#105button").prop("disabled", false);
            $("#1023button").prop("disabled", false);
            $("#1097button").prop("disabled", false);
            $("#1042button").prop("disabled", false);
        }
    });
}

//Assign the Selected Unit to a Call on the Calls list
function assignUnitData(UnitNumber, UnitID) {
    $(".assignBtn").html("<span class='label label-default'>Must Select a Unit First</span>");
    $.ajax({
        type: "POST",
        url: "CADC.aspx/AssignUnit",
        data: "{'UnitID':'" + UnitID + "','UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(UnitNumber);
        },
        failure: function (response) {
        },
        complete: function (response) {
            getCalls()
        }
    });
}

//Open Call Details Menu
function openMenu(CallID) {
    $('#selectUnit1032Div').css('visibility', 'hidden');
    $('#add1032Btn').css('visibility', 'hidden');
    $.ajax({
        type: "POST",
        url: "CADC.aspx/GetCall",
        data: "{'CallID':'" + CallID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (callData) {
                $("#1022Call").attr("onclick", "code4('" + callData.ID + "')");
                $("#code4Call").attr("onclick", "code4('" + callData.ID + "')");
                $("#1099Call").attr("onclick", "update1099('" + callData.ID + "')");
                $("#signal100call").attr("onclick", "signal100('" + callData.ID + "')");
                $("#1032Call").attr("onclick", "update1032('" + callData.ID + "')");
                $("#add1032Btn").attr("onclick", "add1032('" + callData.ID + "')");
                $("#1020Call").attr("onclick", "update1020('" + callData.ID + "')");
                $('#callMenu').dialog({
                    title: 'Call Menu for Call #' + CallID + '',
                    height: 'auto',
                    width: '50%',
                    modal: true,
                    draggable: false,
                    resizable: false,
                    buttons: {
                        'Close': function () {
                            $(this).dialog('close');
                        }
                    }//end buttons
                });
                $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
                $(".callerNameDetails").val(callData.Caller);
                $(".callerDetailsLocation").val(callData.Location);
                $(".callerDetailsDate").val(callData.Date_Time);
                $(".callerDetailsDetails").val(callData.Description);
                $(".callerDetailsOfficer").val(callData.Unit_Responding);
                $(".callerDetailsStatus").val(callData.Status);
            }))
        },
        failure: function () {

        },
        complete: function () {

        }
    });
}

//Code 4 Button on the Call Details
function code4(CallID) {
    $.ajax({
        type: "POST",
        url: "CADC.aspx/CodeFour",
        data: "{'CallID':'" + CallID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) { },
        failure: function (response) {
        },
        complete: function (response) {
            getCalls()
        }
    });
}

//1099 Button on the Call Details
function update1099(CallID) {
    swal({
        title: "Are you sure?",
        text: "You are activating the 10-99 Emergency, do you wish to continue?",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: '#333',
        confirmButtonText: 'Yes, activate it!',
        cancelButtonText: "No, deactivate it!",
        closeOnConfirm: false,
        closeOnCancel: false
    },
        function (isConfirm) {
            if (isConfirm) {
                swal({
                    title: '10-99 Activated!',
                    text: 'All Units are being Dispatched to the Active Call Location.',
                    type: 'success'
                }, function () {
                    $.ajax({
                        type: "POST",
                        url: "CADC.aspx/CreateCall1099",
                        data: "{'CallID':'" + CallID + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {

                        },
                        failure: function () {

                        },
                        complete: function () {

                        }
                    });
                });
            } else {
                swal("Cancelled", "10-99 Deactivated.", "error");
            }
        });
}

//Signal 100 Button on the Call Details
function signal100(CallID) {
    swal({
        title: "Are you sure?",
        text: "You are activating the Signal-100 Emergency, do you wish to continue?",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: '#333',
        confirmButtonText: 'Yes, activate it!',
        cancelButtonText: "No, deactivate it!",
        closeOnConfirm: false,
        closeOnCancel: false
    },
        function (isConfirm) {
            if (isConfirm) {
                swal({
                    title: 'Signal-100 Activated!',
                    text: 'All Units are being Dispatched to the Active Call Location.',
                    type: 'success'
                }, function () {
                    $.ajax({
                        type: "POST",
                        url: "CADC.aspx/CreateCallSignal100",
                        data: "{'CallID':'" + CallID + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {

                        },
                        failure: function () {

                        },
                        complete: function () {

                        }
                    });
                });
            } else {
                swal("Cancelled", "Signal-100 Deactivated.", "error");
            }
        });
}


//1032 Button on the Call Details
function update1032(CallID) {
    $('#selectUnit1032').html("");
    $('#selectUnit1032Div').addClass('animated zoomIn');
    $('#add1032Btn').addClass('animated zoomIn');
    $.ajax({
        type: "POST",
        url: "CADC.aspx/GetAllUnits",
        data: "",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (unitData) {
                if (unitData.Status === '10-8') {
                    $('#selectUnit1032').append('<option value="' + unitData.Unit_Number + '">' + unitData.Unit_Number + '</option>');
                }
            }))
        },
        failure: function () {

        },
        complete: function () {
            $('#selectUnit1032Div').css('visibility', 'visible');
            $('#add1032Btn').css('visibility', 'visible');
        }
    });
}

//Assign another Unit 10-32 and Add call to DB
function add1032(CallID) {
    var UnitAdded = $('#selectUnit1032Div option:selected').text();
   
    $.ajax({
        type: "POST",
        url: "CADC.aspx/CreateCall1032",
        data: "{'CallID':'" + CallID + "','UnitAdded':'" + UnitAdded + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $("#selectUnit1032Div option[value=" + UnitAdded + "]").remove();
        },
        failure: function () {

        },
        complete: function () {
            getCalls();
        }
    });
}

//1020 Button on the Call Details
function update1020(CallID) {
    $('.callerLocationUpdate').val("");
    var Location = "";
    $('.callerLocationUpdate').css('visibility', 'visible');
    $('#1020Location').dialog({
        title: '10-20 Update on Call #' + CallID,
        height: 'auto',
        width: '25%',
        modal: false,
        draggable: true,
        resizable: true,
        buttons: {
            'Update': function () {
                Location = $(".callerLocationUpdate").val();
                $.ajax({
                    type: "POST",
                    url: "CADC.aspx/UpdateCall1020",
                    data: "{'CallID':'" + CallID + "','Location':'" + Location + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                      
                    },
                    failure: function () {

                    },
                    complete: function () {
                        $('.callerLocationUpdate').css('visibility', 'hidden');
                        getCalls();
                    }
                });

                $(this).dialog('close');
            }
        }
    });
    $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
}

//Create New Call Dialog Button on the Call Details
function createCallDialog() {
    now.setDate(now.getDate() + 0);
    var todaysDate = now.getDate() + "/" + now.getMonth() + "/" + now.getFullYear();
    $(".createCallDate").val(todaysDate);
    $('#createCallMenu').dialog({
        title: 'Create a Call',
        height: 'auto',
        width: '50%',
        modal: true,
        draggable: false,
        resizable: false,
        buttons: {
            'Close': function () {
                $(this).dialog('close');
            },
            'Create': function () {
                var createCallName = $(".createCallNameDetails").val();
                var createCallLocation = $(".createCallLocation").val();
                var createCallDate = todaysDate;
                var createCallDetails = $(".createCallDetails").val();
                var createCallOfficer = $(".createCallOfficer").val();
                var createCallStatus = $(".createCallStatus").val();
                 $.ajax({
                     type: "POST",
                     url: "CADC.aspx/CreateCall",
                     data: "{'CallName':'" + createCallName + "','CallLocation':'" + createCallLocation + "','CallDate':'" + createCallDate + "','CallDetails':'" + createCallDetails + "','CallOfficer':'" + createCallOfficer + "','CallStatus':'" + createCallStatus + "'}",
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     async: true,
                     success: function (data) {

                     },
                     failure: function () {

                     },
                     complete: function () {
                         getCalls();
                         $('#createCallMenu').dialog('close')
                     }
                 });
            } //end function for Ok button
        }//end buttons
    });
    $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
}

//Get Current SOSA and Dispatcher Stats
function getStats() {
    $.ajax({
        type: "POST",
        url: "CADC.aspx/GetStats",
        data: "",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $("#ticketsWritten").text(data.d[0]);
            $("#warningsWritten").text(data.d[1]);
            $("#arrestsMade").text(data.d[2]);
            $("#callsResponded").text(data.d[3]);
        },
        failure: function (response) {

        },
        complete: function (response) { }
    });
}

//Open the Notepad Button
var notePadText;
function openNotepad() {
    $('#notePad').dialog({
        title: 'Patrol Notepad',
        height: 'auto',
        width: '25%',
        modal: false,
        draggable: true,
        resizable: true,
        buttons: {
            'Save and Close': function () {
                notePadText = $('#notePad').val();
                $(this).dialog('close');
            }
        }//end buttons
    });
    $('#notePad').val(notePadText);
    $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
}

//Open Dialog of Penal Codes iFrame
function openPenalCodesCheat() {
    $('<div class="col-lg-12"><iframe src="https://docs.google.com/spreadsheets/d/1S7m5meZf2TnvWz6ZCoyZxxWb0xtcx9BUaRzFGYH81o0/edit#gid=0" style="border:0px #333 none;" name="PatrolMap" scrolling="no" frameborder="1" marginheight="0px" marginwidth="0px" width="100%" height="100%" allowfullscreen></iframe></div>').dialog({
        title: 'Penal Codes Cheat Sheet',
        width: 1280,
        height: 720,
        modal: false,
        draggable: true,
        resizable: true,
        overflow: 'hidden',
        buttons: {
            Close: function () {
                $(this).dialog('close');
            } //end function for Ok button

        }//end buttons
    });
    $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
}

//Log off On click AJAX event to remove session and redirect to login
function logOff() {
    swal({
        title: "Logging off!",
        text: "We are logging you off, please wait a moment.",
        type: "warning",
        timer: 5000,
        showConfirmButton: false
    }, function () {
        window.location = 'default.aspx';
    });
}

//108 Status Update Button on the Call Details
function updateStatus108() {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus108",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) { },
        failure: function (response) { },
        complete: function () { }
    });
}

//UPDATE STATUS TO 10-6
function updateStatus106() {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus106",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) { },
        failure: function (response) { },
        complete: function () { }
    });
}
//UPDATE STATUS TO 10-5
function updateStatus105() {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus105",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) { },
        failure: function (response) { },
        complete: function () { }
    });
}
//UPDATE STATUS TO 10-7
function updateStatus107() {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus107",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) { },
        failure: function (response) { },
        complete: function () { }
    });
}
//UPDATE STATUS TO 10-41
function updateStatus1041() {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus1041",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) { },
        failure: function (response) { },
        complete: function () { }
    });
}
//UPDATE STATUS TO 10-42
function updateStatus1042() {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus1042",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) { },
        failure: function (response) { },
        complete: function () { }
    });
}
//UPDATE STATUS TO 10-23
function updateStatus1023() {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus1023",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) { },
        failure: function (response) { },
        complete: function () { }
    });
}
//UPDATE STATUS TO 10-97
function updateStatus1097() {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus1097",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) { },
        failure: function (response) { },
        complete: function () { }
    });
}
//UPDATE STATUS TO 10-19
function updateStatus1019() {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus1019",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) { },
        failure: function (response) { },
        complete: function () { }
    });
}

//Toggle Busy Units button to Toggle Between available and Busy
function toggleBusyUnits() {
    $('.busyUnitsTable').toggle();
    $('.availableUnitsTable').toggle();
}

//Toggle Between Bolos and Calls
function toggleBolos() {
    $('#boloCalls').toggle();
    $('#ActiveCallsData').toggle();
    $("#toggleBolosBtn").toggleText('Toggle Bolos', 'Toggle Calls');
}

//Start the Pit Timer Button
function startPitTimer() {
    $("#startPitTimeBtn").attr("disabled", true);
    $("#startPitTimeBtn").addClass("bg-darkred");
    $("#startPitTimeBtn").addClass("animated infinite pulse");
    var seconds = 230;
    clearTimeout(tick);
    function tick() {
        var counter = document.getElementById("startPitTimeBtn");
        seconds--;
        counter.innerHTML = seconds < 0 ? "0" : "" + String(seconds) + " Seconds";
        if (seconds > 0) {
            setTimeout(tick, 1000);
        } else {
            counter.innerHTML = "START PIT TIMER";
            $("#startPitTimeBtn").removeClass("animated infinite pulse");
            $("#startPitTimeBtn").removeClass("bg-darkred");
            $("#startPitTimeBtn").addClass("bg-grey2");
            $("#startPitTimeBtn").attr("disabled", false);
            swal({
                title: "PIT TIME EXPIRED",
                text: "You are now clear to PIT.",
                type: "warning",
                showConfirmButton: true
            });
        }
    }
    tick();
}
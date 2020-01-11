$(document).ready(function () {

    loadUnitData(SessionID);
    window.setInterval(function () {
        loadUnitData(SessionID);
    }, 10000);
    getCivs();
    getVehs();
    $('#selectServer').css('display', 'none');
    $('#selectIdentifier').css('display', 'none');
    $('#startPatrol').css('display', 'none');
    $("#boloCallsCard").hide();
    $("#boloVehicleCallsCard").hide();
    //Set Intervals for Data Refreshing
    window.setInterval(function () {
        getCalls();
    }, 10000);


    //Keep Session Alive
    $(function () {
        setInterval(KeepSessionAlive, 10000);
    });

    function KeepSessionAlive() {
        $.post("Shared/KeepSessionAlive.ashx", null, function () { });
    }

    //Toggle Function
    $.fn.extend({
        toggleText: function (a, b) {
            return this.text(this.text() == b ? a : b);
        }
    });


    //Animate.CSS Function (animateCss)
    $.fn.extend({
        animateCss: function (animationName, callback) {
            var animationEnd = (function (el) {
                var animations = {
                    animation: 'animationend',
                    OAnimation: 'oAnimationEnd',
                    MozAnimation: 'mozAnimationEnd',
                    WebkitAnimation: 'webkitAnimationEnd',
                };
                for (var t in animations) {
                    if (el.style[t] !== undefined) {
                        return animations[t];
                    }
                }
            })(document.createElement('div'));
            this.addClass('animated ' + animationName).one(animationEnd, function () {
                $(this).removeClass('animated ' + animationName);

                if (typeof callback === 'function') callback();
            });
            return this;
        },
    });

    //Toggle between Divisions UI Effects 
    $('.toggleDivision').click(function () {
        $('.toggleDivision').not(this).prop("disabled", false);
        $(this).prop("disabled", true);
        $(this).animateCss('flash', function () {
            $('#selectServer').addClass('animated fadeIn');
            $('#selectServer').css('display', 'block');
        });
    });

    //Toggle between Servers UI Effects 
    $('.toggleServer').click(function () {
        $('.toggleServer').not(this).prop("disabled", false);
        $(this).prop("disabled", true);
        $(this).animateCss('flash', function () {
            $('#selectIdentifier').addClass('animated fadeIn');
            $('#selectIdentifier').css('display', 'block');
        });
    });

    //Toggle between Identifiers UI Effects 
    $('.toggleIdentifier').click(function () {
        $('.toggleIdentifier').not(this).prop("disabled", false);
        $(this).prop("disabled", true);
        $(this).animateCss('flash', function () {
            $('#startPatrol').addClass('animated fadeIn');
            $('#startPatrol').css('display', 'block');
        });
    });

    //Toggle between Statuses UI Effects 
    $(".toggleStatus").click(function () {
        $('.toggleStatus').not(this).prop("disabled", false);
        $(this).prop("disabled", true);
    });
});

//Variables
var notifyAlert = function () { };
notifyAlert.SendAlert = null;
var currentID = 0;
var lastID = 0;
var unitPrimaryID = "";

//jQuery SerializerArrToJSON
function jQFormSerializeArrToJson(formSerializeArr) {
    var jsonObj = {};
    jQuery.map(formSerializeArr, function (n, i) {
        jsonObj[n.name] = n.value;
    });

    return jsonObj;
}




//Load and Display all Elements of the Logged in LEO/UNIT Account
function loadUnitData(SessionID) {
    var UnitNumber = {
        "UnitNumberEncrypted": SessionID
    };
    $.ajax({
        type: "POST",
        url: "api/Unit/GetUnitData",
        data: JSON.stringify(UnitNumber),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data, function (unitData) {
                $("#UnitNumber").text(unitData.Unit_Number);
                $("#UnitName").text(unitData.Name);
                $("#currentIdentifier").text(unitData.Division);
                unitPrimaryID = unitData.Division;
                if (unitData.Status === "10-8" || unitData.Status === "10-19" || unitData.Status === "10-23" || unitData.Status === "10-97" || unitData.Status === "SIGNAL 11" || unitData.Status === "10-12") {
                    $("#CurrentStatus").html("<span class='text-success'>" + unitData.Status + "</span>");
                    $("#currentPatrolStatus").html("<span class='text-success'>Connected and Available as: " + unitData.Unit_Number + "</span>");
                } else if (unitData.Status === "10-5" || unitData.Status === "10-6" || unitData.Status === "10-7" || unitData.Status === "10-41" || unitData.Status === "10-15" || unitData.Status === "10-11") {
                    $("#CurrentStatus").html("<span class='text-warning'>" + unitData.Status + "</span>");
                    $("#currentPatrolStatus").html("<span class='text-warning'>Connected and Busy with status " + unitData.Status + "</span>");
                } else if (unitData.Status === "10-42" || unitData.Status === "CODE ZERO") {
                    $("#CurrentStatus").html("<span class='text-danger'>" + unitData.Status + "</span>");
                    $("#currentPatrolStatus").html("<span class='text-danger'>Connected but Unavailable with status " + unitData.Status + "</span>");
                }
                $("#loggedUser").text(unitData.Name);
                $("#Identifier1Btn").text(unitData.Division);
                if (unitData.Sub_Division != "") {
                    $('#Identifier2Btn').css('visibility', 'visible');
                    $("#Identifier2Btn").text(unitData.Sub_Division);
                }
                if (unitData.Sub_Division_2 != "") {
                    $("#Identifier3Btn").css('visibility', 'visible');
                    $("#Identifier3Btn").text(unitData.Sub_Division_2);
                }
                if (unitData.Sub_Division_3 != "") {
                    $("#Identifier4Btn").css('visibility', 'visible');
                    $("#Identifier4Btn").text(unitData.Sub_Division_3);
                }
                if (unitData.Sub_Division_4 != "") {
                    $("#Identifier5Btn").css('visibility', 'visible');
                    $("#Identifier5Btn").text(unitData.Sub_Division_4);
                }
                if (OnPatrol == "Yes") {
                    $("#cadMain").hide();
                    $("#patrolMain").show();
                    $("#patrolMain").removeClass("animated bounceInDown");
                }
                getStats(unitData.Unit_Number);
            }))
        },
        failure: function (response) { },
        complete: function (response) {
            var pi = document.getElementById("UnitNumber").innerHTML;
        }
    });
}


//Load and Display all Calls assigned to this Unit
function getCalls() {
    var calls = [];
    pi = document.getElementById("UnitNumber").innerHTML;
    var pID = {
        "PrimaryIdentifier": unitPrimaryID
    };
    $("#ActiveCallsData").css('visibility', 'hidden');
    $('#ActiveCallsData').html("");
    $.ajax({
        type: "POST",
        url: "api/Call/GetCallData",
        data: JSON.stringify(pID),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data, function (callData) {
                if (callData.Status === "Active" & (callData.Notes != "Signal-100" || callData.Notes != "10-99" || callData.Notes != "10-32 Additional")) {
                    currentID = data.length;
                    calls = "<div class='card bg-darkred p-3 cardShadow'><h6>" + callData.Caller + "<span class='pull-right'>" + callData.Date_Time + "</span></h6>" +
                        "<span class='d-block'>" + callData.Location + "<span class='pull-right'>" + callData.Unit_Responding + "</span></span><hr>" +
                        "<span class='d-block text-center'>" + callData.Description + "</span><hr>" +
                        "<span class='d-block'>Notes: " + callData.Notes + "</span><hr>" +
                        "<span class='pull-left'>" + callData.Status + "</span><span class='label bg-success pull-right' style='cursor:pointer;' onclick='code4(" + callData.ID + ")'>Code 4</span></div>";
                    $('#ActiveCallsData').append(calls);
                }
            }))

        },
        failure: function (response) {

            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () {
            getAllCalls();
        }
    });
}

//Load and Display all Calls 
function getAllCalls() {
    notifyAlert.SendAlert = function () {
        return false;
    };
    var calls = [];
    var activeVehicleBolo = [];
    var activePersonBolo = [];
    var callsHistory = [];
    $.ajax({
        type: "POST",
        url: "api/Call/GetAllCallData",
        data: "",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $('#boloCalls').css('visibility', 'hidden');
            $('#boloCalls').html("");
            $('#boloVehicleCalls').css('visibility', 'hidden');
            $('#boloVehicleCalls').html("");
            $("#historyCallsData").css('visibility', 'hidden');
            $('#historyCallsData').html("");
            ($.map(data, function (callData) {
                if (callData.Status === "Closed") {
                    callsHistory =
                        "<div class='card bg-grey p-3 cardShadow'><h6>" + callData.Caller + "<span class='pull-right'>" + callData.Date_Time + "</span></h6>" +
                        "<span class='d-block'>" + callData.Location + "<span class='pull-right'>" + callData.Unit_Responding + "</span></span><hr>" +
                        "<span class='d-block text-center'>" + callData.Description + "</span></div>";
                    $('#historyCallsData').append(callsHistory);
                }
                if (callData.Status === "Vehicle Bolo") {
                    activeVehicleBolo =
                        "<div class='card bg-darkred p-3 cardShadow'><h6>" + callData.Caller + "<span class='pull-right'>" + callData.Date_Time + "</span></h6>" +
                        "<span class='d-block'>" + callData.Location + "<span class='pull-right'>" + callData.Unit_Responding + "</span></span><hr>" +
                        "<span class='d-block text-center'>" + callData.Description + "</span><hr>" +
                        "<span class='d-block'>Notes: " + callData.Notes + "</span></div>";
                    $("#boloVehicleCalls").append(activeVehicleBolo);
                }

                if (callData.Status === "Person Bolo") {
                    activePersonBolo =
                        "<div class='card bg-darkred p-3 cardShadow'><h6>" + callData.Caller + "<span class='pull-right'>" + callData.Date_Time + "</span></h6>" +
                        "<span class='d-block'>" + callData.Location + "<span class='pull-right'>" + callData.Unit_Responding + "</span></span><hr>" +
                        "<span class='d-block text-center'>" + callData.Description + "</span><hr>" +
                        "<span class='d-block'>Notes: " + callData.Notes + "</span></div>";
                    $("#boloCalls").append(activePersonBolo);
                }

                if (callData.Status === "Active" && callData.Notes === "Signal-100" || callData.Status === "Active" && callData.Notes === "10-99") {
                    currentID = data.length;
                    calls = "<div class='card bg-darkred p-3 cardShadow'><h6>" + callData.Caller + "<span class='pull-right'>" + callData.Date_Time + "</span></h6>" +
                        "<span class='d-block'>" + callData.Location + "<span class='pull-right'>" + callData.Unit_Responding + "</span></span><hr>" +
                        "<span class='d-block text-center'>" + callData.Description + "</span><hr>" +
                        "<span class='d-block'>Notes: " + callData.Notes + "</span><hr>" +
                        "<span class='pull-left'>" + callData.Status + "</span><span class='label bg-success pull-right' style='cursor:pointer;' onclick='code4(" + callData.ID + ")'>Code 4</span></div>";
                    $('#ActiveCallsData').append(calls);
                }

                if (callData.Status === "Active" && callData.Notes === "Signal-100") {
                    $.notify({
                        message: "<span style='font-size:15px;'><strong>All Units:</strong> There is a <strong>Signal-100</strong> currently in effect.</span>"
                    }, {
                            type: "danger",
                            allow_dismiss: false,
                            newest_on_top: true,
                            hide: false,
                            timer: 5000,
                            placement: {
                                from: "top",
                                align: "center"
                            },
                            animate: {
                                enter: "animated fadeInDown",
                                exit: "animated fadeOutUp"
                            }
                        });
                }

            }))
        },
        failure: function (response) {

            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () {
            if (currentID > lastID) {
                document.getElementById('mySoundClip').play();
                notifyAlert.SendAlert = function () {
                    $.notify({
                        message: "<span style='font-size:15px;'><strong>Attention:</strong> You have received a new <strong>call</strong> or a new <strong>bolo</strong> alert.</span>"
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

            $('#ActiveCallsData').css('visibility', 'visible');
            $('#boloCalls').css('visibility', 'visible');
            $('#boloVehicleCalls').css('visibility', 'visible');
            $('#historyCallsData').css('visibility', 'visible');
        }
    });
}


//Set and Update DB with the Selected Identifier
function setIdentifier(Identifier, SessionID) {
    var CurrentIdentifier = $('#currentIdentifier').text();
    var sID = {
        "SelectedIdentifier": Identifier,
        "UnitNumberEncrypted": SessionID,
    };

    $.ajax({
        type: "POST",
        url: "api/Unit/UpdateIdentifier",
        data: JSON.stringify(sID),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function () {

        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//Get an Populate list of all Civilian Characters in auto-complete search input
function getCivs() {
    var civTags = [];
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
        },
        failure: function (response) {

            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () {
            getCalls();
            $("#nameLookup").autocomplete({
                source: civTags
            });
        }
    });
}

//Get an Populate list of all Vehicles in auto-complete search input
function getVehs() {
    var vehTags = [];
    $.ajax({
        type: "POST",
        url: "api/Vehicle/GetAllVehicles",
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

            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () {
            $("#plateLookup").autocomplete({
                source: vehTags
            });
        }
    });
    GetScores(1);
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
                    width: 'auto',
                    height: 'auto',
                    maxWidth: 600,
                    modal: true,
                    draggable: false,
                    resizable: false,
                    fluid: true,
                    buttons: {
                        Done: function () {
                            $(this).dialog('close');
                        } //end function for Ok button

                    } //end buttons
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
                    width: 'auto',
                    height: 'auto',
                    maxWidth: 200,
                    modal: true,
                    draggable: false,
                    resizable: false,
                    fluid: true,
                    buttons: {
                        Done: function () {
                            $(this).dialog('close');
                        } //end function for Ok button

                    } //end buttons
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

            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () {

        }
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
                $(".arrestDetailsJailTime").val(arrestData.Arrest_Jailtime);
                $(".arrestActiveWarrant").val(arrestData.Arrest_Warrant_Active)
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

            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () {

        }
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
        failure: function (response) { },
        complete: function () {

        }
    });
}

//On click Event to Submit the Created Warrant of Searched Character
$('#createWarrantBtn').click(function (event) {
    $("#warrantForm").dialog().dialog("close");
    var warrantFormSerialized = jQFormSerializeArrToJson($("#warrantForm").serializeArray());
    console.log(JSON.stringify(warrantFormSerialized));
    $.ajax({
        type: "POST",
        url: "/api/Civilian/AddWarrant",
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
    $("#arrestForm").dialog().dialog("close");
    var arrestFormSerialized = jQFormSerializeArrToJson($("#arrestForm").serializeArray());
    $.ajax({
        type: "POST",
        url: "/api/Civilian/AddArrest",
        data: JSON.stringify(arrestFormSerialized),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function () { },
        failure: function () {

        },
        complete: function (data) {
            console.log(data.responseJSON)
            civArrests(data.responseJSON);
            $('#arrestForm').dialog('close');
        }
    });
    event.preventDefault();
});

//On click Event to Submit the Created Ticket of Searched Character
$('#createTicketBtn').click(function (event) {
    $("#ticketForm").dialog().dialog("close");
    var ticketFormSerialized = jQFormSerializeArrToJson($("#ticketForm").serializeArray());
    $.ajax({
        type: "POST",
        url: "/api/Civilian/AddTicket",
        data: JSON.stringify(ticketFormSerialized),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function () { },
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
    $("#warningForm").dialog().dialog("close");
    var warningFormSerialized = jQFormSerializeArrToJson($("#warningForm").serializeArray());
    $.ajax({
        type: "POST",
        url: "/api/Civilian/AddWarning",
        data: JSON.stringify(warningFormSerialized),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) { },
        failure: function (data) { },
        complete: function (data) {
            civTickets(data.responseJSON);
            $('#warningForm').dialog('close');
        }
    });
    event.preventDefault();
});

//Log off On click AJAX event to remove session and redirect to login
function logOff() {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/RemovePatrolStatus",
        data: "{'UnitNumber':'" + unitPrimaryID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {

        },
        failure: function (response) {


        },
        complete: function (response) {
            logOut();
        }
    });
}

//Onclick event to Start Patrol and Update UI
function startPatrol(SessionID) {
    $("#cadMain").animateCss('bounceOutUp', function () {
        $("#cadMain").hide();
        var UnitNumber = {
            "UnitNumberEncrypted": SessionID
        };
        $.ajax({
            type: "POST",
            url: "api/Unit/GetUnitData",
            data: JSON.stringify(UnitNumber),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                ($.map(data, function (unitData) {
                    $("#currentPatrolStatus").html("<span class='text-success'>Connected and Transmitting as: " + unitData.Unit_Number + "</span>");
                }))
            },
            failure: function (response) {


            },
            complete: function (response) {

                $("#patrolMain").css("display", "block");
                setPatrolStatus(unitPrimaryID);
            }
        })
    });
}

//Get Stats AJAX call to Populate current LEO Stats
function getStats(Unit) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/GetStats",
        data: "{'UnitNumber':'" + Unit + "'}",
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
        complete: function (response) {

        }
    });
}

//Set cookie session so that Unit can be automatically set on Patrol if client crashed
function setPatrolStatus(unitPrimaryID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/SetPatrolStatus",
        data: "{'UnitNumber':'" + unitPrimaryID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) { },
        failure: function (response) {


        },
        complete: function (response) {
            $.notify({
                message: "<span style='font-size:18px;'><strong>Timeclock Alert<br></strong> You are now clocked in, <strong>DO NOT</strong> forget to <strong>CLOCK OUT</strong> at the end of your patrol.</span>"
            }, {
                    type: "warning",
                    allow_dismiss: false,
                    newest_on_top: true,
                    timer: 5000,
                    placement: {
                        from: "bottom",
                        align: "left"
                    },
                    animate: {
                        enter: "animated fadeInLeft",
                        exit: "animated fadeOutLeft"
                    }
                });
        }
    });
}

//Open the Notepad Button
var notePadText;

function openNotepad() {

    $('#notePad').dialog({
        title: 'Patrol Notepad',
        height: 'auto',
        width: '375',
        modal: false,
        draggable: true,
        resizable: true,
        buttons: {
            'Save and Close': function () {
                notePadText = $('#notePad').val();
                $(this).dialog('close');
            }
        } //end buttons
    });
    $('#notePad').val(notePadText);
    $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
}

//Open the 10 Codes List Button
function open10Codes() {
    $("<div class='col-lg-12'><div class='col-lg-6'><p>Police codes:<br />10-0 Caution<br />10-1 - Frequency Change<br />10-2 - Negitive<br />10-3 - Stop Transmitting<br />10-4 - Affirmative<br />10-5 - Meal Break<br />10-6 - Busy<br />10-7 - Out of Service<br />10-8 - In Service<br />10-9 - Repeat<br />10-10 - Fight in Progress<br />10-11 - Traffic Stop<br />10-12 - Active Ride Along<br />10-13 - Shots Fired<br />10-15 - Subject in custody en route to Station<br />10-16 - Stolen Vehicle<br />10-17 - Suspicious Person<br />10-19 - Active K-9<br />10-20 - Location<br />10-22 - Disregard<br />10-23 - Arrived on Scene<br />10-25 - Domestic Dispute<br />10-26 - ETA<br />10-27 - Driver's License Check for Valid<br />10-28 - Vehicle License Plate Check<br />10-29 - NCIC Warrant Check<br />10-30 - Wanted Person<br />10-31 - Not Wanted No Warrants<br />10-32 - Request Backup (Code 1-2-3)<br />10-41 - Beginning Tour of Duty<br />10-42 - Ending Tour of Duty<br />10-43 - Information<br />10-49 - Homicide<br />10-50 - Vehicle Accident<br />10-51 - Request Towing Service<br />10-52 - Request EMS<br />10-53 - Fire Dept Requested<br />10-55 - Intoxicated Driver<br />10-56 - Intoxicated Pedestrian<br />10-60 - Armed with a Gun</div><div class='col-lg-6'>10-61 - Armed with a Knife<br />10-62 - Kidnapping<br />10-64 - Sexual Assault<br />10-65 - Escorting Prisoner<br />10-66 - Reckless Driver<br />10-67 - Fire<br />10-68 - Armed Robbery<br />10-70 - Foot Pursuit<br />10-71 - Request Supervisor at Scene<br />10-73 - Advise Status<br />10-80 - Vehicle Pursuit<br />10-89 - In Game Advice About Mistake<br />10-90 - In Game Warning<br />10-93 - Removed From Game<br />10-95 - Recording<br />10-97 - In Route<br />10-99 - Officer In Distress Extreme Emergency On<br />Code 1 - Normal Response No Lights/siren<br />Code 2 - lights and sometimes sirens<br />Code 3 - Use lights and siren<br />Code 4 - No further assistance needed<br />Code 5 Felony Stop<br />Code 6 Stay out of area<br />Code 11 SWAT Call up<br />Code Zero - Game Crash</p></div></div>").dialog({
        title: '10-Codes',
        height: 'auto',
        width: '375',
        modal: false,
        draggable: true,
        resizable: true,
        buttons: {
            Close: function () {
                $(this).dialog('close');
            } //end function for Ok button

        } //end buttons
    });
    $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
}

//Open new Tab to Patrol Map
function openPatrolMap() {
    window.open('http://map.sosarp.net/', '_blank');
}

//Open Dialog of Penal Codes iFrame
function openPenalCodes() {
    $('<div class="col-lg-12"><iframe src="https://docs.google.com/document/d/1Y4SRJVTkkxHLYuhzp6x42XAaAmWdxFxKm03jfG_34SU/edit" style="border:0px #333 none;" name="PatrolMap" scrolling="no" frameborder="1" marginheight="0px" marginwidth="0px" width="100%" height="100%" allowfullscreen></iframe></div>').dialog({
        title: 'Penal Codes',
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

        } //end buttons
    });
    $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
}


function openPenalCodesCheat() {
    $('<div class="col-lg-12"><iframe src="https://docs.google.com/spreadsheets/d/1S7m5meZf2TnvWz6ZCoyZxxWb0xtcx9BUaRzFGYH81o0/edit?usp=sharing" style="border:0px #333 none;" name="PatrolMap" scrolling="no" frameborder="1" marginheight="0px" marginwidth="0px" width="100%" height="100%" allowfullscreen></iframe></div>').dialog({
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

        } //end buttons
    });
    $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
}

//Log out and Back to the Main pre-patrol screen
function logOut() {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/LogOutSessions",
        data: "",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {

        },
        failure: function (response) {

        },
        complete: function () {
            window.location.reload();
        }
    });
}

//Toggle Between Bolos and Calls
function toggleBolos() {
    $('#boloCallsCard').toggle();
    $('#ActiveCallsDataCard').toggle();
    $('#historyCallsDataCard').toggle();
    $('#boloVehicleCallsCard').toggle();
    $("#toggleBolosBtn").toggleText('Toggle Bolos', 'Toggle Calls');
}

//UPDATE STATUS TO 10-8
function updateStatus108(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus108",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(SessionID);
        },
        failure: function (response) {

        },
        complete: function () {
            $.getScript("assets/voip/Connection.js", function (data, textStatus, jqxhr) {
                console.log(data); // Data returned
                console.log(textStatus); // Success
                console.log(jqxhr.status); // 200
                console.log("Load was performed.");
            });
        }
    });
}

//UPDATE STATUS TO 10-6
function updateStatus106(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus106",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(SessionID);
        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE STATUS TO 10-5
function updateStatus105(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus105",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(SessionID);
        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE STATUS TO 10-7
function updateStatus107(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus107",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(SessionID);
        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE STATUS TO 10-41
function updateStatus1041(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus1041",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(SessionID);
        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}


//UPDATE STATUS TO 10-42
function updateStatus1042(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus1042",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(SessionID);
        },
        failure: function (response) {

        },
        complete: function () {
            logOff()
        }
    });
}

//UPDATE STATUS TO 10-23
function updateStatus1023(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus1023",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(SessionID);
        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE STATUS TO 10-97
function updateStatus1097(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus1097",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(SessionID);
        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}


//UPDATE STATUS TO 10-19
function updateStatus1019(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus1019",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(SessionID);
        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE STATUS TO CODE ZERO CRASHED
function updateStatusCodeZero(SessionID) {
    $('#codezero').animateCss('flash');
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatusCodeZero",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(SessionID);
        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE STATUS SIGNAL 11 RADAR
function updateStatusSignal11(SessionID) {
    $('#signal11').animateCss('flash');
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatusSignal11",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(SessionID);
        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE STATUS TO 10-15 TRANSPORT
function updateStatus1015(SessionID) {
    $('#1015button').animateCss('flash');
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus1015",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(SessionID);
        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE STATUS TO 10-12 RIDE ALONG
function updateStatus1012(SessionID) {
    $('#1012button').animateCss('flash');
    var UnitNumber = SessionID;
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus1012",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(SessionID);
        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE STATUS TO 10-11 TRAFFIC STOP
function updateStatus1011(SessionID) {
    $('#1011button').animateCss('flash');
    var UnitNumber = SessionID;
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus1011",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(SessionID);
        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE UNIT ICON SAHP
function SAHPClicked(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/DivisionSAHP",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $('#divisionLogo').animateCss('fadeIn');
        },
        failure: function (response) {

        },
        complete: function () {
            $('#divisionLogo').animateCss('zoomOut', function () {
                $("#divisionLogo").attr("src", "assets/images/SAHP.png");
                $('#divisionLogo').animateCss('zoomIn');
            });
        }
    });
}

//UPDATE UNIT ICON SWAT
function swatClicked(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/DivisionSWAT",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $('#divisionLogo').animateCss('fadeIn');
        },
        failure: function (response) {

        },
        complete: function () {
            $('#divisionLogo').animateCss('zoomOut', function () {
                $("#divisionLogo").attr("src", "assets/images/SOSASWAT.png");
                $('#divisionLogo').animateCss('zoomIn');
            });
        }
    });
}

//UPDATE UNIT ICON BCSO
function bcsoClicked(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/DivisionBCSO",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $('#divisionLogo').animateCss('fadeIn');
        },
        failure: function (response) {

        },
        complete: function () {
            $('#divisionLogo').animateCss('zoomOut', function () {
                $("#divisionLogo").attr("src", "assets/images/BCSO.png");
                $('#divisionLogo').animateCss('zoomIn');
            });
        }
    });
}

//UPDATE UNIT ICON LSPD
function lspdClicked(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/DivisionLSPD",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $('#divisionLogo').animateCss('fadeIn');
        },
        failure: function (response) {

        },
        complete: function () {
            $('#divisionLogo').animateCss('zoomOut', function () {
                $("#divisionLogo").attr("src", "assets/images/SOSALSPD.png");
                $('#divisionLogo').animateCss('zoomIn');
            });
        }
    });
}

//UPDATE UNIT ICON EMS
function emsClicked(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/DivisionEMS",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {

        },
        failure: function (response) {

        },
        complete: function () {
            $('#divisionLogo').animateCss('zoomOut', function () {
                $("#divisionLogo").attr("src", "assets/images/SOSAEMS.png");
                $('#divisionLogo').animateCss('zoomIn');
            });
        }
    });
}

//UPDATE UNIT ICON SAFD
function safdClicked(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/DivisionSAFD",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $('#divisionLogo').animateCss('fadeIn');
        },
        failure: function (response) {

        },
        complete: function () {
            $('#divisionLogo').animateCss('zoomOut', function () {
                $("#divisionLogo").attr("src", "assets/images/SOSAFD.png");
                $('#divisionLogo').animateCss('zoomIn');
            });
        }
    });
}

//Code 4 Button
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


//Set and Update DB with the Selected Identifier
function GetScores(modifier) {
    var arrests = "";
    var tickets = "";
    var warrants = "";
    var calls = "";
    var a = 0;
    var t = 0;
    var c = 0;
    var w = 0;
    $.ajax({
        type: "POST",
        url: "api/Leaderboards/GetLeaderboard",
        data: JSON.stringify(modifier),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $.map(data, function (scoredata) {
                switch (modifier) {
                    case 1:
                        a++;
                        arrests = '<div class="item row text-center"> <div class="col-sm-12"><i class="zmdi zmdi-star pull-left font-30"></i><span class="font-25 h6">RANK: #' + a + '</span><i class="zmdi zmdi-star pull-right font-30"></i></div> <div class="col-sm-12"> <p class="font-20">' + scoredata.Unit + ' with ' + scoredata.Points + ' arrests </p> </div> </div>'
                        $("#arrestsLeaders").append(arrests);
                        break;
                    case 2:
                        t++;
                        tickets = '<div class="item row text-center"> <div class="col-sm-12"><i class="zmdi zmdi-star pull-left font-30"></i><span class="font-25 h6">RANK: #' + t + '</span><i class="zmdi zmdi-star pull-right font-30"></i></div> <div class="col-sm-12"> <p class="font-20">' + scoredata.Unit + ' with ' + scoredata.Points + ' tickets </p> </div> </div>'
                        $("#ticketsLeaders").append(tickets);
                        break;
                    case 3:
                        w++;
                        warrants = '<div class="item row text-center"> <div class="col-sm-12"><i class="zmdi zmdi-star pull-left font-30"></i><span class="font-25 h6">RANK: #' + w + '</span><i class="zmdi zmdi-star pull-right font-30"></i></div> <div class="col-sm-12"> <p class="font-20">' + scoredata.Unit + ' with ' + scoredata.Points + ' warrant </p> </div> </div>'
                        $("#warrantsLeaders").append(warrants);
                        break;
                    case 4:
                        c++;
                        calls = '<div class="item row text-center"> <div class="col-sm-12"><i class="zmdi zmdi-star pull-left font-30"></i><span class="font-25 h6">RANK: #' + c + '</span><i class="zmdi zmdi-star pull-right font-30"></i></div> <div class="col-sm-12"> <p class="font-20">' + scoredata.Unit + ' with ' + scoredata.Points + ' calls </p> </div> </div>'
                        $("#callsLeaders").append(calls);
                        break;
                    default:
                        console.log("No Data")
                        break;
                }
            })
        },
        failure: function (response) {

        },
        complete: function () {
            if (modifier < 4) {
                modifier++
                GetScores(modifier);
            }
        }
    });
}

// Sign off and log out / clock out when closing the window
window.onbeforeunload = function () {
    logOff();
   // Do something
}


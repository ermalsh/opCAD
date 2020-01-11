$(document).ready(function () {
    loadUnitData(SessionID);
    getCivs();
    getVehs();
    window.setInterval(function () {
        getCalls();
    }, 30000);

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

    $('.toggleDivision').click(function () {
        $('.toggleDivision').not(this).prop("disabled", false);
        $(this).prop("disabled", true);
        $(this).animateCss('bounce', function () {
            $('#selectServer').addClass('animated zoomIn');
            $('#selectServer').css('display', 'block');
        });
    });

    $('.toggleServer').click(function () {
        $('.toggleServer').not(this).prop("disabled", false);
        $(this).prop("disabled", true);
        $(this).animateCss('bounce', function () {
            $('#selectIdentifier').addClass('animated zoomIn');
            $('#selectIdentifier').css('display', 'block');
        });
    });

    $('.toggleIdentifier').click(function () {
        $('.toggleIdentifier').not(this).prop("disabled", false);
        $(this).prop("disabled", true);
        $(this).animateCss('bounce', function () {
            $('#startPatrol').addClass('animated zoomIn');
            $('#startPatrol').css('display', 'block');
        });
    });

    $(".toggleStatus").click(function () {
        $('.toggleStatus').not(this).prop("disabled", false);
        $(this).prop("disabled", true);
    });

    $('#selectServer').css('display', 'none');
    $('#selectIdentifier').css('display', 'none');
    $('#startPatrol').css('display', 'none');

});


//UPDATE UNIT LIST
function loadUnitData(SessionID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/GetUnitData",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (unitData) {
                $("#UnitNumber").text(unitData.Unit_Number);
                $("#UnitName").text(unitData.Name);
                $("#currentIdentifier").text(unitData.Division);

                if (unitData.Status === "10-8") {
                    $("#CurrentStatus").html("<span class='animated flash text-success'>" + unitData.Status + "</span>");
                } else if (unitData.Status === "10-5") {
                    $("#CurrentStatus").html("<span class='animated flash text-warning'>" + unitData.Status + "</span>");
                } else if (unitData.Status === "10-6") {
                    $("#CurrentStatus").html("<span class='animated flash text-warning'>" + unitData.Status + "</span>");
                } else if (unitData.Status === "10-23") {
                    $("#CurrentStatus").html("<span class='animated flash text-success'>" + unitData.Status + "</span>");
                } else if (unitData.Status === "10-97") {
                    $("#CurrentStatus").html("<span class='animated flash text-success'>" + unitData.Status + "</span>");
                } else if (unitData.Status === "10-41") {
                    $("#CurrentStatus").html("<span class='animated flash text-warning'>" + unitData.Status + "</span>");
                } else if (unitData.Status === "10-7") {
                    $("#CurrentStatus").html("<span class='animated flash text-danger'>" + unitData.Status + "</span>");
                } else if (unitData.Status === "10-42") {
                    $("#CurrentStatus").html("<span class='animated flash text-danger'>" + unitData.Status + "</span>");
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
                    $("#currentPatrolStatus").html("<span class='text-success'>Connected and Transmitting as: " + unitData.Unit_Number + "</span>");
                }
                getStats(unitData.Unit_Number);
            }))
        },
        failure: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            console.log("Message: " + r.Message);
            console.log("StackTrace: " + r.StackTrace);
            console.log("ExceptionType: " + r.ExceptionType);
        },
        complete: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            var pi = document.getElementById("UnitNumber").innerHTML;

        }
    });
}

//UPDATE CALL LIST
function getCalls() {
    var calls = [];
    pi = document.getElementById("UnitNumber").innerHTML;
    $.ajax({
        type: "POST",
        url: "CAD.aspx/GetAllCalls",
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $("#ActiveCallsData").css('visibility', 'hidden');
            $('#ActiveCallsData').html("");
            ($.map(data.d, function (callData) {
                if (callData.Status === "Active" && callData.Unit_Responding === pi) {
                    calls = "<tr class='danger animated fadeIn'>" +
                        "<td id='callID' runat='server'>" + callData.ID + "</td>" +
                        "<td>" + callData.Caller + "</td>" +
                        "<td>" + callData.Location + "</td>" +
                        "<td>" + callData.Date_Time + "</td>" +
                        "<td>" + callData.Description + "</td>" +
                        "<td>" + callData.Unit_Responding + "</td>" +
                        "<td>" + callData.Status + "</td>" +
                        "</tr>";
                    $('#ActiveCallsData').append(calls);
                    document.getElementById('mySoundClip').play();
                    $.notify({
                        message: "<span style='font-size:15px;'><strong>Attention:</strong> You are currently <strong>active</strong> on a call</span>"
                    }, {
                            type: "danger",
                            allow_dismiss: true,
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
                }
            }))
        },
        failure: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function (callData) {
            $('#ActiveCallsData').css('visibility', 'visible');
        }
    });
}

function setIdentifier(Identifier, UnitName){
    var CurrentIdentifier = $('#currentIdentifier').text();
     $.ajax({
        type: "POST",
        url: "CAD.aspx/SetIdentifier",
        data: "{'Identifier':'" + Identifier +"', 'UnitName':'" + UnitName +"'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
      
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

//UPDATE CALL LIST
function getCivs() {
    var civTags = [];
    $.ajax({
        type: "POST",
        url: "CAD.aspx/GetAllCivs",
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (civData) {
                civTags.push(civData.Full_Name);
            }))
        },
        failure: function (response) {
            var r = jQuery.parseJSON(response.responseText);
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

//UPDATE CALL LIST
function searchCiv(civName) {
    var revoked = "No";
    $.ajax({
        type: "POST",
        url: "CAD.aspx/SearchCivs",
        data: "{'Name':'" + civName + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
           
            ($.map(data.d, function (civData) {
                document.getElementById("btnsCivDetails").innerHTML ='<button type="button" class="btn btn-raised bg-grey btn-block btn-lg waves-effect" style="color: #B1B1B1;" onclick="createWarrant('+civData.License_Number+')">CREATE WARRANT</button> <button type="button" class="btn btn-raised bg-grey btn-block btn-lg waves-effect" style="color: #B1B1B1;" onclick="createArrest('+civData.License_Number+')">ARREST REPORT</button> <button type="button" class="btn btn-raised bg-grey btn-block btn-lg waves-effect" style="color: #B1B1B1;" onclick="createTicket('+civData.License_Number+')">WRITE CITATION</button> <button type="button" class="btn btn-raised bg-grey btn-block btn-lg waves-effect" style="color: #B1B1B1;" onclick="createWarning('+civData.License_Number+')">ISSUE WARNING</button>';
                var civInfo = $('#civDetails').html();
                $('<div class="card col-lg-12" style="background:#333;">' + civInfo +'</div>').dialog({
                    title: civData.Full_Name + " - " + civData.License_Number,
                    height: 'auto',
                    width: '60%',
                    modal: true,
                    draggable: false,
                    resizable: false,
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
                $(".ui-button").addClass('btn bg-grey2 btn-block btn-sm btn-raised text-white');
                
                if (civData.License_Status != "Valid") {
                    $(".licenseStatus").html('<span class="text-danger">'+civData.License_Status+'</span>');
                } else {
                    $(".licenseStatus").html('<span class="text-success">' + civData.License_Status + '</span>');
                }
                civTickets(civData.License_Number);
                civArrests(civData.License_Number);
                civWarrants(civData.License_Number);
                
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

//GET ARRESTS/TICKETS/WARRANTS
function civArrests(civLicense) {
    var arrests = [];
    $(".priorArrests").html("");
    $.ajax({
        type: "POST",
        url: "CAD.aspx/CivArrests",
        data: "{'License':'" + civLicense + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (arrestData) {
                arrests = "<tr class='bg-grey2'>" +
                    "<td>" + arrestData.ID + "</td>" +
                    "<td>" + arrestData.Arrest_Details + "</td>" +
                    "<td>" + arrestData.Arrest_Charges + "</td>" +
                    "<td>" + arrestData.Arrest_Unit + "</td>" +
                    "<td><a href='javascript: void(0)' onclick='viewArrestDetails(\"" + arrestData.ID + "\")'><span class='label label-default'>View</span></a></td>" +
                    "</tr>";-
                $(".priorArrests").append(arrests);
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

//TICKETS
function civTickets(civLicense) {

    var tickets = [];
    $(".priorTraffic").html("");
    $.ajax({
        type: "POST",
        url: "CAD.aspx/CivTickets",
        data: "{'License':'" + civLicense + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (ticketData) {
                tickets = "<tr class='bg-grey2'>" +
                    "<td>" + ticketData.ID + "</td>" +
                    "<td>" + ticketData.Ticket_Details + "</td>" +
                    "<td>" + ticketData.Ticket_Charges + "</td>" + 
                    "<td>" + ticketData.Ticket_Unit + "</td>" +
                    "<td><a href='javascript: void(0)' onclick='viewTicketDetails(\"" + ticketData.ID + "\")'><span class='label label-default'>View</span></a></td>" +
                    "</tr>"; 
                $(".priorTraffic").append(tickets);
               
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

//WARRANTS
function civWarrants(civLicense) {
    var warrants = [];
    $(".priorWarrants").html("");
    $.ajax({
        type: "POST",
        url: "CAD.aspx/CivWarrants",
        data: "{'License':'" + civLicense + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (warrantData) {
                warrants = "<tr class='bg-grey2'>" +
                    "<td>" + warrantData.ID + "</td>" +
                    "<td>" + warrantData.Warrant_Issued + "</td>" +
                    "<td>" + warrantData.Warrant_Charges + "</td>" +
                    "<td>" + warrantData.Warrant_Status + "</td>" +
                    "<td><a href='javascript: void(0)' onclick='viewWarrantDetails(\"" + warrantData.ID + "\")'><span class='label label-default'>View</span></a></td>" +
                    "</tr>";
                $(".priorWarrants").append(warrants);
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

//CivDetailButtons
function createWarrant(License){
    $.ajax({
        type: "POST",
        url: "CAD.aspx/WarrantReport",
        data: "{'License':'" + License + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            var d = new Date();
            var strDate = d.getDate() + "/" + (d.getMonth()+1) + "/" + d.getFullYear();
            ($.map(data.d, function (civData) {
               var warrantInfoForm = $('#warrantForm').html();
                $(warrantInfoForm).dialog({
                    title: 'Warrant Form - ' + civData.Full_Name + " - " + civData.License_Number,
                    height: 'auto',
                    width: '30%',
                    position: {
                        my: "center",
                        at: "center top",
                        of: $("body")
                    },
                    buttons: {
                        Cancel: function () {
                           $(this).dialog('close')
                        },
                         Submit: function () {
                           submitWarrant();
                           $(this).dialog('close')
                        } //end function for Ok button
                        
                    }//end buttons
                });
               
                $(".fullName").val(civData.Full_Name);
                $(".licenseNumber").val(civData.License_Number);
                $(".licenseState").val(civData.License_State);
                $(".warrantDateIssued").val(strDate);
                $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
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

//CivDetailButtons
function createArrest(License){
    $.ajax({
        type: "POST",
        url: "CAD.aspx/ArrestReport",
        data: "{'License':'" + License + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            var d = new Date();
            var strDate = d.getDate() + "/" + (d.getMonth()+1) + "/" + d.getFullYear();
            ($.map(data.d, function (civData) {
               var arrestInfoForm = $('#arrestForm').html();
                $(arrestInfoForm).dialog({
                    title: 'Arrest Form - ' + civData.Full_Name + " - " + civData.License_Number,
                    height: 'auto',
                    width: '30%',
                    position: {
                        my: "center",
                        at: "center top",
                        of: $("body")
                    },
                    buttons: {
                        Cancel: function () {
                           $(this).dialog('close')
                        },
                         Submit: function () {
                           submitArrest();
                           $(this).dialog('close')
                        } //end function for Ok button
                        
                    }//end buttons
                });
               
                $(".fullName").val(civData.Full_Name);
                $(".licenseNumber").val(civData.License_Number);
                $(".licenseState").val(civData.License_State);
                $(".arrestDateIssued").val(strDate);
                $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
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

function submitArrest(){
    var FullName = $('.fullName').get(1).value;
    var LicenseNumber = $('.licenseNumber').get(1).value;
    var LicenseState = $('.licenseState').get(1).value;
    var Date = $('.arrestDateIssued').get(1).value;
    var ArrestCharges = $('.arrestCharges').get(1).value;
    var ArrestOfficer = $('.arrestOfficer').get(1).value;
    var ArrestLocation = $('.arrestLocation').get(1).value;
    var ArrestDetails = $('.arrestDetails').get(1).value;
    var ArrestFines = $('.arrestFines').get(1).value;
    var ArrestJailTime = $('.arrestJailTime').get(1).value;
     $.ajax({
        type: "POST",
        url: "CAD.aspx/CreateArrestReport",
        data: "{'FullName':'" + FullName + "','LicenseNumber':'" + LicenseNumber + "','LicenseState':'" + LicenseState + "','Date':'" + Date + "','ArrestCharges':'" + ArrestCharges + "','ArrestOfficer':'" + ArrestOfficer + "','ArrestLocation':'" + ArrestLocation + "','ArrestDetails':'" + ArrestDetails + "','ArrestFines':'" + ArrestFines + "','ArrestJailTime':'" + ArrestJailTime + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            console.log(data)
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

//CivDetailButtons
function createTicket(License){
    $.ajax({
        type: "POST",
        url: "CAD.aspx/TicketReport",
        data: "{'License':'" + License + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            var d = new Date();
            var strDate = d.getDate() + "/" + (d.getMonth()+1) + "/" + d.getFullYear();
            ($.map(data.d, function (civData) {
               var ticketInfoForm = $('#ticketForm').html();
                $(ticketInfoForm).dialog({
                    title: 'Citation - ' + civData.Full_Name + " - " + civData.License_Number,
                    height: 'auto',
                    width: '30%',
                    position: {
                        my: "center",
                        at: "center top",
                        of: $("body")
                    },
                    buttons: {
                        Cancel: function () {
                           $(this).dialog('close')
                        },
                         Submit: function () {
                           submitTicket();
                           $(this).dialog('close')
                        } //end function for Ok button
                        
                    }//end buttons
                });
               
                $(".fullName").val(civData.Full_Name);
                $(".licenseNumber").val(civData.License_Number);
                $(".licenseState").val(civData.License_State);
                $(".ticketDateIssued").val(strDate);
                $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
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

function submitTicket(){
    var FullName = $('.fullName').get(1).value;
    var LicenseNumber = $('.licenseNumber').get(1).value;
    var LicenseState = $('.licenseState').get(1).value;
    var Date = $('.ticketDateIssued').get(1).value;
    var TicketCharges = $('.ticketCharges').get(1).value;
    var TicketOfficer = $('.ticketOfficer').get(1).value;
    var TicketLocation = $('.ticketLocation').get(1).value;
    var TicketDetails = $('.ticketDetails').get(1).value;
    var TicketFines = $('.ticketFines').get(1).value;
     $.ajax({
        type: "POST",
        url: "CAD.aspx/CreateTicketReport",
        data: "{'FullName':'" + FullName + "','LicenseNumber':'" + LicenseNumber + "','LicenseState':'" + LicenseState + "','Date':'" + Date + "','TicketCharges':'" + TicketCharges + "','TicketOfficer':'" + TicketOfficer + "','TicketLocation':'" + TicketLocation + "','TicketDetails':'" + TicketDetails + "','TicketFines':'" + TicketFines + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            console.log(data)
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

//CivDetailButtons
function createWarning(License){
    $.ajax({
        type: "POST",
        url: "CAD.aspx/WarningReport",
        data: "{'License':'" + License + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            var d = new Date();
            var strDate = d.getDate() + "/" + (d.getMonth()+1) + "/" + d.getFullYear();
            ($.map(data.d, function (civData) {
               var warningInfoForm = $('#warningForm').html();
                $(warningInfoForm).dialog({
                    title: 'Warning - ' + civData.Full_Name + " - " + civData.License_Number,
                    height: 'auto',
                    width: '30%',
                    position: {
                        my: "center",
                        at: "center top",
                        of: $("body")
                    },
                    buttons: {
                        Cancel: function () {
                           $(this).dialog('close')
                        },
                         Submit: function () {
                           submitWarning();
                           $(this).dialog('close')
                        } //end function for Ok button
                        
                    }//end buttons
                });
               
                $(".fullName").val(civData.Full_Name);
                $(".licenseNumber").val(civData.License_Number);
                $(".licenseState").val(civData.License_State);
                $(".warningDateIssued").val(strDate);
                $(".ui-button").addClass('btn bg-grey2 btn-sm btn-raised text-white');
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

function submitWarning(){
    var FullName = $('.fullName').get(1).value;
    var LicenseNumber = $('.licenseNumber').get(1).value;
    var LicenseState = $('.licenseState').get(1).value;
    var Date = $('.warningDateIssued').get(1).value;
    var WarningOfficer = $('.warningOfficer').get(1).value;
    var WarningLocation = $('.warningLocation').get(1).value;
    var WarningDetails = $('.warningDetails').get(1).value;
     $.ajax({
        type: "POST",
        url: "CAD.aspx/CreateWarningReport",
        data: "{'FullName':'" + FullName + "','LicenseNumber':'" + LicenseNumber + "','LicenseState':'" + LicenseState + "','Date':'" + Date + "','WarningOfficer':'" + WarningOfficer + "','WarningLocation':'" + WarningLocation + "','WarningDetails':'" + WarningDetails + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            console.log(data)
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




function submitWarrant(){
    var FullName = $('.fullName').get(1).value;
    var LicenseNumber = $('.licenseNumber').get(1).value;
    var LicenseState = $('.licenseState').get(1).value;
    var Date = $('.warrantDateIssued').get(1).value;
    var WarrantCharges = $('.warrantCharges').get(1).value;
    var WarrantOfficer = $('.warrantOfficer').get(1).value;
    var WarrantDepartment = $('.warrantDepartment').get(1).value;
     $.ajax({
        type: "POST",
        url: "CAD.aspx/CreateWarrantReport",
        data: "{'FullName':'" + FullName + "','LicenseNumber':'" + LicenseNumber + "','LicenseState':'" + LicenseState + "','Date':'" + Date + "','WarrantCharges':'" + WarrantCharges + "','WarrantOfficer':'" + WarrantOfficer + "','WarrantDepartment':'" + WarrantDepartment + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            console.log(data)
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



//SEARCH VEHICLES
function searchVeh(vehPlate) {
    var vehicles = [];
    $.ajax({
        type: "POST",
        url: "CAD.aspx/SearchVehs",
        data: "{'Plate':'" + vehPlate + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $("#SearchResultsVehs").css('visibility', 'hidden');
            $('#SearchResultsVehs').html("");
            ($.map(data.d, function (vehData) {
                vehicles = "<tr class='bg-grey2 animated fadeIn'>" +
                    "<td>" + vehData.Model + "</td>" +
                    "<td>" + vehData.Color + "</td>" +
                    "<td>" + vehData.Owner + "</td>" +
                    "<td>" + vehData.Registration_Valid + "</td>" +
                    "<td>" + vehData.Insurance_Valid + "</td>" +
                    "</tr>";
                $('#SearchResultsVehs').append(vehicles);
            }))
        },
        failure: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () {
            $('#SearchResultsVehs').css('visibility', 'visible');
        }
    });
}

function getVehs() {
    var vehTags = [];
    $.ajax({
        type: "POST",
        url: "CAD.aspx/GetAllVehicles",
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (vehData) {
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
            $("#plateLookup").autocomplete({
                source: vehTags
            });
        }
    });
}

function logOff(){
     $.ajax({
        type: "POST",
        url: "CAD.aspx/RemovePatrolStatus",
        data: "",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {

        },
        failure: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            console.log("Message: " + r.Message);
            console.log("StackTrace: " + r.StackTrace);
            console.log("ExceptionType: " + r.ExceptionType);
        },
        complete: function (response) {
            location.reload();
        }
    });
}

//START THE PATROL
function startPatrol(SessionID) {
    $("#cadMain").animateCss('bounceOutUp', function () {
        $("#cadMain").hide();
        $.ajax({
            type: "POST",
            url: "CAD.aspx/GetUnitData",
            data: "{'UnitNumber':'" + SessionID + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                ($.map(data.d, function (unitData) {
                    $("#currentPatrolStatus").html("<span class='text-success'>Connected and Transmitting as: " + unitData.Unit_Number + "</span>");
                }))
            },
            failure: function (response) {
                var r = jQuery.parseJSON(response.responseText);
                console.log("Message: " + r.Message);
                console.log("StackTrace: " + r.StackTrace);
                console.log("ExceptionType: " + r.ExceptionType);
            },
            complete: function (response) {
                var r = jQuery.parseJSON(response.responseText);
                $("#patrolMain").css("display", "block");
                setPatrolStatus();
            }
        })
    });
}

//GET STATS
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
            var r = jQuery.parseJSON(response.responseText);
            console.log("Message: " + r.Message);
            console.log("StackTrace: " + r.StackTrace);
            console.log("ExceptionType: " + r.ExceptionType);
        },
        complete: function (response) {

        }
    });
}

//START THE PATROL
function setPatrolStatus() {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/SetPatrolStatus",
        data: "",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {

        },
        failure: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            console.log("Message: " + r.Message);
            console.log("StackTrace: " + r.StackTrace);
            console.log("ExceptionType: " + r.ExceptionType);
        },
        complete: function (response) {

        }
    });
}


//ASSIGN UNIT 
function assignUnitData(UnitNumber, UnitID) {
    $.ajax({
        type: "POST",
        url: "CAD.aspx/AssignUnit",
        data: "{'UnitID':'" + UnitID + "','UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {

        },
        failure: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            console.log("Message: " + r.Message);
            console.log("StackTrace: " + r.StackTrace);
            console.log("ExceptionType: " + r.ExceptionType);
        },
        complete: function (response) {
            var r = jQuery.parseJSON(response.responseText);

        }
    });
}

function openNotepad() {
    $('<textarea rows="10" style="background: grey; border-radius: 10px; min-width:100%;"></textarea>').dialog({
                    title: 'Patrol Notepad',
                    height: 'auto',
                    width: '30%',
                    modal: false,
                    draggable: true,
                    resizable: true,
                    buttons: {
                        Close: function () {
                            $(this).dialog('close');
                        } //end function for Ok button
                        
                    }//end buttons
                });
}

function open10Codes() {
    $("<div class='col-lg-12'><div class='col-lg-6'><p>Police codes:<br />10-0 Caution<br />10-1 - Frequency Change<br />10-2 - Negitive<br />10-3 - Stop Transmitting<br />10-4 - Affirmative<br />10-5 - Meal Break<br />10-6 - Busy<br />10-7 - Out of Service<br />10-8 - In Service<br />10-9 - Repeat<br />10-10 - Fight in Progress<br />10-11 - Traffic Stop<br />10-12 - Active Ride Along<br />10-13 - Shots Fired<br />10-15 - Subject in custody en route to Station<br />10-16 - Stolen Vehicle<br />10-17 - Suspicious Person<br />10-20 - Location<br />10-22 - Disregard<br />10-23 - Arrived on Scene<br />10-25 - Domestic Dispute<br />10-26 - ETA<br />10-27 - Driver's License Check for Valid<br />10-28 - Vehicle License Plate Check<br />10-29 - NCIC Warrant Check<br />10-30 - Wanted Person<br />10-31 - Not Wanted No Warrants<br />10-32 - Request Backup (Code 1-2-3)<br />10-41 - Beginning Tour of Duty<br />10-42 - Ending Tour of Duty<br />10-43 - Information<br />10-49 - Homicide<br />10-50 - Vehicle Accident<br />10-51 - Request Towing Service<br />10-52 - Request EMS<br />10-53 - Fire Dept Requested<br />10-55 - Intoxicated Driver<br />10-56 - Intoxicated Pedestrian<br />10-60 - Armed with a Gun</div><div class='col-lg-6'>10-61 - Armed with a Knife<br />10-62 - Kidnapping<br />10-64 - Sexual Assault<br />10-65 - Escorting Prisoner<br />10-66 - Reckless Driver<br />10-67 - Fire<br />10-68 - Armed Robbery<br />10-70 - Foot Pursuit<br />10-71 - Request Supervisor at Scene<br />10-73 - Advise Status<br />10-80 - Vehicle Pursuit<br />10-89 - In Game Advice About Mistake<br />10-90 - In Game Warning<br />10-93 - Removed From Game<br />10-95 - Recording<br />10-97 - In Route<br />10-99 - Officer In Distress Extreme Emergency On<br />Code 1 - Normal Response No Lights/siren<br />Code 2 - lights and sometimes sirens<br />Code 3 - Use lights and siren<br />Code 4 - No further assistance needed<br />Code 5 Felony Stop<br />Code 6 Stay out of area<br />Code 11 SWAT Call up<br />Code Zero - Game Crash</p></div></div>").dialog({
                    title: '10-Codes',
                    height: 'auto',
                    width: '30%',
                    modal: false,
                    draggable: true,
                    resizable: true,
                    buttons: {
                        Close: function () {
                            $(this).dialog('close');
                        } //end function for Ok button
                        
                    }//end buttons
                });
}

function openPatrolMap() {
    $('<div class="col-lg-12"><iframe src="http://map.sosarp.net" style="border:0px #333 none;" name="PatrolMap" scrolling="no" frameborder="1" marginheight="0px" marginwidth="0px" width="100%" height="100%" allowfullscreen></iframe></div>').dialog({
                    title: 'Patrol Map',
                    width: 800,
                    height: 800,
                    modal: false,
                    draggable: true,
                    resizable: true,
                    buttons: {
                        Close: function () {
                            $(this).dialog('close');
                        } //end function for Ok button
                        
                    }//end buttons
                });
}

function openPenalCodes() {
    $('<div class="col-lg-12"><iframe src="https://docs.google.com/spreadsheets/d/1S7m5meZf2TnvWz6ZCoyZxxWb0xtcx9BUaRzFGYH81o0/edit#gid=0" style="border:0px #333 none;" name="PatrolMap" scrolling="no" frameborder="1" marginheight="0px" marginwidth="0px" width="100%" height="100%" allowfullscreen></iframe></div>').dialog({
                    title: 'Penal Codes',
                    width: 800,
                    height: 800,
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
}

//UPDATE STATUS TO 10-8
function updateStatus108(SessionID) {
    var UnitNumber = SessionID;
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus108",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {

        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE STATUS TO 10-6
function updateStatus106(SessionID) {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus106",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {

        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE STATUS TO 10-5
function updateStatus105(SessionID) {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus105",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {

        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE STATUS TO 10-7
function updateStatus107(SessionID) {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus107",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {

        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE STATUS TO 10-41
function updateStatus1041(SessionID) {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus1041",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {

        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}


//UPDATE STATUS TO 10-42
function updateStatus1042(SessionID) {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus1042",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {

        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE STATUS TO 10-23
function updateStatus1023(SessionID) {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus1023",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {

        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}

//UPDATE STATUS TO 10-97
function updateStatus1097(SessionID) {
    var UnitNumber = $("#UnitNumber").text();
    $.ajax({
        type: "POST",
        url: "CAD.aspx/UpdateUnitStatus1097",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {

        },
        failure: function (response) {

        },
        complete: function () {

        }
    });
}


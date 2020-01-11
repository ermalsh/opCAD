$(document).ready(function () {
    $('#activeCalls').hide();
    $('#pendingCalls').hide();
    $('#unitsList').hide();
    $('#offlineUnits').hide();
    $("#108button").prop("disabled", true);
    $("#1041button").prop("disabled", true);
    $("#107button").prop("disabled", true);
    $("#106button").prop("disabled", true);
    $("#105button").prop("disabled", true);
    $("#1023button").prop("disabled", true);
    $("#1097button").prop("disabled", true);
    $("#1042button").prop("disabled", true);
    getCalls();
    getUnits();
});

//UPDATE CALL LIST
function getCalls() {
   
    $('#ActiveCallsData').html("");
    $('#PendingCallsData').html("");
    var p = "AlertNoShow";
    $.ajax({
        type: "POST",
        url: "CADC.aspx/GetAllCalls",
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {

            ($.map(data.d, function (callData) {
                if (callData.Status === "Active") {
                    var rows = "<tr class='danger animated fadeIn'>" +
                        "<td>" + callData.ID + "</td>" +
                        "<td>" + callData.Caller + "</td>" +
                        "<td>" + callData.Location + "</td>" +
                        "<td>" + callData.Date_Time + "</td>" +
                        "<td>" + callData.Description + "</td>" +
                        "<td>" + callData.Unit_Responding + "</td>" +
                        "<td>" + callData.Status + "</td>" +
                        "<td><a href='#'><span class='label label-default'>View</span></a></td></td>" +
                        "</tr>";
                    $('#ActiveCallsData').append(rows);
                    
                }

                if (callData.Status === "Pending") {
                    rows = "<tr class='warning animated fadeIn'>" +
                        "<td id='callID' runat='server'>" + callData.ID + "</td>" +
                        "<td>" + callData.Caller + "</td>" +
                        "<td>" + callData.Location + "</td>" +
                        "<td>" + callData.Date_Time + "</td>" +
                        "<td>" + callData.Description + "</td>" +
                        "<td>" + callData.Status + "</td>" +
                        "<td id='assignPending'><span class='label label-default'>Select Available Unit</span> <span class='label label-danger'>10-22</span></td>" +
                        "</tr>";
                    $('#PendingCallsData').append(rows);
                    p = "AlertShow";
                }
            }))
        },
        failure: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function () {
            if (p == "AlertShow") {
                $.notify({
                    message: "<span style='font-size:15px;'><strong>Attention:</strong> There are pending calls awaiting assignment below.</span>"
                }, {
                        type: "warning",
                        allow_dismiss: true,
                        newest_on_top: true,
                        timer: 1000,
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
            
            $('#ActiveCallsData').show();
            $('#PendingCallsData').show();
            setTimeout(getCalls, 10000);
        }
    });
}

//UPDATE UNIT LIST
function getUnits() {
    $('#availableUnits').html('');
    $('#busyUnits').html('');
    $('#unavailableUnits').html('');
    $.ajax({
        type: "POST",
        url: "CADC.aspx/GetAllUnits",
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (unitData) {
                var availableHTML = "<tr class='success animated fadeIn'>" +
                    "<td>" + unitData.Unit_Number + "</td>" +
                    "<td>" + unitData.Name + "</td>" +
                    "<td>" + unitData.Status + "</td>" +
                    "<td><a href='javascript: void(0)' onclick='loadUnitData(\"" + unitData.Unit_Number + "\")'><span class='label label-default'>Control</span></a></td>" +
                    "</tr>";
                var busyHTML = "<tr class='warning'>" +
                    "<td>" + unitData.Unit_Number + "</td>" +
                    "<td>" + unitData.Name + "</td>" +
                    "<td>" + unitData.Status + "</td>" +
                    "<td><a href='javascript: void(0)' onclick='loadUnitData(\"" + unitData.Unit_Number + "\")'><span class='label label-default'>Control</span></a></td>" +
                    "</tr>";
                var unavailableHTML = "<tr class='danger animated fadeIn'>" +
                    "<td>" + unitData.Unit_Number + "</td>" +
                    "<td>" + unitData.Name + "</td>" +
                    "<td>" + unitData.Status + "</td>" +
                    "<td><a href='javascript: void(0)' onclick='loadUnitData(\"" + unitData.Unit_Number + "\")'><span class='label label-default'>Control</span></a></td>" +
                    "</tr>";

                if (unitData.Status === "10-8") {
                    rows = availableHTML;
               
                    $('#availableUnits').append(rows);
                } else if (unitData.Status === "10-5") {
                    rows = busyHTML;
             
                    $('#busyUnits').append(rows);
                } else if (unitData.Status === "10-6") {
                    rows = busyHTML;
               
                    $('#busyUnits').append(rows);
                } else if (unitData.Status === "10-23") {
                    rows = availableHTML;
               
                    $('#availableUnits').append(rows);
                } else if (unitData.Status === "10-97") {
                    rows = availableHTML;
            
                    $('#availableUnits').append(rows);
                } else if (unitData.Status === "10-41") {
                    rows = busyHTML;
             
                    $('#busyUnits').append(rows);
                } else if (unitData.Status === "10-7") {
                    rows = busyHTML;
            
                    $('#busyUnits').append(rows);
                } else {
                    rows = unavailableHTML;
            
                    $('#unavailableUnits').append(rows);
                }
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
            $('#availableUnits').show();
            $('#busyUnits').show();
            $('#unavailableUnits').show();
            setTimeout(getUnits, 3000);
        }
    });

}

//UPDATE UNIT LIST
function loadUnitData(UnitNumber) {

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
                $("#UnitNumber").html(unitData.Unit_Number);
                if (unitData.Status === "10-8") {
                    $("#assignPending").html("<a href='javascript: void(0)' onclick='assignUnitData(\"" + unitData.Unit_Number + "\",\"" + $("#callID").text() + "\")'><span class='label label-success'>Assign to: " + unitData.Unit_Number + " " + unitData.Name + "</span> <span class='label label-danger'>10-22</span></a>");
                    activate108();
                } else if (unitData.Status === "10-5") {
                    activate105();
                } else if (unitData.Status === "10-6") {
                    activate106();
                } else if (unitData.Status === "10-23") {
                    $("#assignPending").html("<a href='javascript: void(0)' onclick='assignUnitData(\"" + unitData.Unit_Number + "\",\"" + $("#callID").text() + "\")'><span class='label label-success'>Assign to: " + unitData.Unit_Number + " " + unitData.Name + "</span> <span class='label label-danger'>10-22</span></a>");
                    activate1023();
                } else if (unitData.Status === "10-97") {
                    $("#assignPending").html("<a href='javascript: void(0)' onclick='assignUnitData(\"" + unitData.Unit_Number + "\",\"" + $("#callID").text() + "\")'><span class='label label-success'>Assign to: " + unitData.Unit_Number + " " + unitData.Name + "</span> <span class='label label-danger'>10-22</span></a>");
                    activate1097();
                } else if (unitData.Status === "10-41") {
                    activate1041();
                } else if (unitData.Status === "10-7") {
                    activate107();
                } else {
                    activate1042();
                }
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
        }
    });
}


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
                $("#currentPatrolStatus").html("<span class='animated infinite flash text-success'>Connected and Transmitting as: " + unitData.Division + "</span>");
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
        }
    });
}


//ASSIGN UNIT 
function assignUnitData(UnitNumber, UnitID) {
    $("#assignPending").html("<span class='label label-default'>Select Available Unit</span> <span class='label label-danger'>10-22</span>");
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

//UPDATE STATUS TO 10-8
function updateStatus108() {
    var UnitNumber = $("#UnitNumber").text();
    $('#availableUnits').html("");
    $('#busyUnits').html("");
    $('#unavailableUnits').html("");
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus108",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(UnitNumber);
        },
        failure: function (response) {

        },
        complete: function () {
        }
    });
}

//UPDATE STATUS TO 10-6
function updateStatus106() {
    var UnitNumber = $("#UnitNumber").text();
    $('#availableUnits').html("");
    $('#busyUnits').html("");
    $('#unavailableUnits').html("");
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus106",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(UnitNumber);
        },
        failure: function (response) {

        },
        complete: function () {
        }
    });
}

//UPDATE STATUS TO 10-5
function updateStatus105() {
    var UnitNumber = $("#UnitNumber").text();
    $('#availableUnits').html("");
    $('#busyUnits').html("");
    $('#unavailableUnits').html("");
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus105",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(UnitNumber);
        },
        failure: function (response) {

        },
        complete: function () {
        }
    });
}

//UPDATE STATUS TO 10-7
function updateStatus107() {
    var UnitNumber = $("#UnitNumber").text();
    $('#availableUnits').html("");
    $('#busyUnits').html("");
    $('#unavailableUnits').html("");
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus107",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(UnitNumber);
        },
        failure: function (response) {

        },
        complete: function () {
        }
    });
}

//UPDATE STATUS TO 10-41
function updateStatus1041() {
    var UnitNumber = $("#UnitNumber").text();
    $('#availableUnits').html("");
    $('#busyUnits').html("");
    $('#unavailableUnits').html("");
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus1041",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(UnitNumber);
        },
        failure: function (response) {

        },
        complete: function () {
        }
    });
}


//UPDATE STATUS TO 10-42
function updateStatus1042() {
    var UnitNumber = $("#UnitNumber").text();
    $('#availableUnits').html("");
    $('#busyUnits').html("");
    $('#unavailableUnits').html("");
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus1042",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(UnitNumber);
        },
        failure: function (response) {

        },
        complete: function () {
        }
    });
}

//UPDATE STATUS TO 10-23
function updateStatus1023() {
    var UnitNumber = $("#UnitNumber").text();
    $('#availableUnits').html("");
    $('#busyUnits').html("");
    $('#unavailableUnits').html("");
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus1023",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(UnitNumber);
        },
        failure: function (response) {

        },
        complete: function () {
        }
    });
}

//UPDATE STATUS TO 10-97
function updateStatus1097() {
    var UnitNumber = $("#UnitNumber").text();
    $('#availableUnits').html("");
    $('#busyUnits').html("");
    $('#unavailableUnits').html("");
    $.ajax({
        type: "POST",
        url: "CADC.aspx/UpdateUnitStatus1097",
        data: "{'UnitNumber':'" + UnitNumber + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            loadUnitData(UnitNumber);
        },
        failure: function (response) {

        },
        complete: function () {
        }
    });
}

function activate105() {
    $("#108button").prop("disabled", false);
    $("#1041button").prop("disabled", true);
    $("#107button").prop("disabled", false);
    $("#106button").prop("disabled", false);
    $("#105button").prop("disabled", true);
    $("#1023button").prop("disabled", true);
    $("#1097button").prop("disabled", true);
    $("#1042button").prop("disabled", false);
}

function activate106() {
    $("#108button").prop("disabled", false);
    $("#1041button").prop("disabled", true);
    $("#107button").prop("disabled", false);
    $("#106button").prop("disabled", true);
    $("#105button").prop("disabled", false);
    $("#1023button").prop("disabled", true);
    $("#1097button").prop("disabled", true);
    $("#1042button").prop("disabled", false);
}

function activate107() {
    $("#108button").prop("disabled", false);
    $("#1041button").prop("disabled", true);
    $("#107button").prop("disabled", true);
    $("#106button").prop("disabled", false);
    $("#105button").prop("disabled", false);
    $("#1023button").prop("disabled", true);
    $("#1097button").prop("disabled", true);
    $("#1042button").prop("disabled", false);
}

function activate108() {
    $("#108button").prop("disabled", true);
    $("#1041button").prop("disabled", true);
    $("#107button").prop("disabled", false);
    $("#106button").prop("disabled", false);
    $("#105button").prop("disabled", false);
    $("#1023button").prop("disabled", false);
    $("#1097button").prop("disabled", false);
    $("#1042button").prop("disabled", false);
}

function activate1041() {
    $("#108button").prop("disabled", false);
    $("#1041button").prop("disabled", true);
    $("#107button").prop("disabled", false);
    $("#106button").prop("disabled", false);
    $("#105button").prop("disabled", false);
    $("#1023button").prop("disabled", true);
    $("#1097button").prop("disabled", true);
    $("#1042button").prop("disabled", false);
}

function activate1042() {
    $("#108button").prop("disabled", true);
    $("#1041button").prop("disabled", false);
    $("#107button").prop("disabled", true);
    $("#106button").prop("disabled", true);
    $("#105button").prop("disabled", true);
    $("#1023button").prop("disabled", true);
    $("#1097button").prop("disabled", true);
    $("#1042button").prop("disabled", true);
}

function activate1097() {
    $("#108button").prop("disabled", true);
    $("#1041button").prop("disabled", true);
    $("#107button").prop("disabled", false);
    $("#106button").prop("disabled", false);
    $("#105button").prop("disabled", false);
    $("#1023button").prop("disabled", false);
    $("#1097button").prop("disabled", true);
    $("#1042button").prop("disabled", false);
}

function activate1023() {
    $("#108button").prop("disabled", true);
    $("#1041button").prop("disabled", true);
    $("#107button").prop("disabled", false);
    $("#106button").prop("disabled", false);
    $("#105button").prop("disabled", false);
    $("#1023button").prop("disabled", true);
    $("#1097button").prop("disabled", false);
    $("#1042button").prop("disabled", false);
}

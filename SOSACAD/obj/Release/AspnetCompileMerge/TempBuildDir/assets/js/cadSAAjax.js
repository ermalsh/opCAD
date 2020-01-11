$(document).ready(function () {
    var currentUnitID = "";
    var currentUserID = "";
    var currentCivID = "";

    //Keep Session Alive
    $(function () {
        setInterval(KeepSessionAlive, 10000);
    });
    function KeepSessionAlive() {
        $.post("Shared/KeepSessionAlive.ashx", null, function () {
        });
    }
}); 



//Load and Display all Elements of the Logged in Administrator
function loadAdminData(SessionID) {
    $.ajax({
        type: "POST",
        url: "CADSA.aspx/GetAdminData",
        data: "{'UnitNumber':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (unitData) {
                $("#loggedUser").text(unitData.Name);
                $("#currentIdentifier").text(unitData.Division);
            }))
        },
        failure: function (response) {

        },
        complete: function (response) {
            getUsersTable();
        }
    });
}

//Populate the Registered_Users Table onto the UI
function getUsersTable() {
    $.ajax({
        type: "POST",
        url: "CADSA.aspx/GetAllUnits",
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $('#unitsTable').html("");

            ($.map(data.d, function (unitData) {
                var unitsHTML = "<tr class='bg-grey2 animated fadeIn' style='cursor:pointer;' onclick='editUnitMenu(" + unitData.ID + ");'>" + "<td>" + unitData.ID + "</td>" + "<td>" + unitData.LoginName + "</td>" + "<td>" + unitData.Name +
                    "<td>" + unitData.Unit_Number + "</td>" + "<td>" + unitData.isNewUser + "</td>" + "<td>" + unitData.isBanned + "</td></tr>";
                allUnits = unitsHTML;
                $('#unitsTable').append(allUnits);
            }))
        },
        failure: function (response) {

        },
        complete: function (response) {
            getAllUsers();
        }
    });
}


//Populate the Registered_Civs Table onto the UI
function getAllUsers() {
    $.ajax({
        type: "POST",
        url: "CADSA.aspx/GetAllUsers",
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $('#civiliansTable').html("");
            ($.map(data.d, function (users) {
                var civiliansHTML = "<tr class='bg-grey2 animated fadeIn' style='cursor:pointer;' onclick='editUserMenu(" + users.ID + ");'>" + "<td>" + users.ID + "</td>" + "<td>" + users.Username + "</td>" + "<td>" + users.Name +
                    "<td>" + users.Email + "</td>" + "<td>" + users.isApproved + "</td>" + "<td>" + users.isBanned + "</td></tr>";
                allCivilians = civiliansHTML;
                $('#civiliansTable').append(allCivilians);
            }))
        },
        failure: function (response) {

        },
        complete: function (response) {
            getCharactersTable();

        }
    });
}

//Populate the Civilians Table onto the UI
function getCharactersTable() {
    $.ajax({
        type: "POST",
        url: "CADSA.aspx/GetAllCharacters",
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $('#characterTable').html("");
            ($.map(data.d, function (char) {
                var characterHTML = "<tr class='bg-grey2 animated fadeIn' style='cursor:pointer;' onclick='editCivMenu(" + char.ID + ");'>" + "<td>" + char.ID + "</td><td>" + char.Owner + "</td><td>" + char.First_Name + "</td>" +
                    "<td>" + char.Last_Name + "</td><td>" + char.License_Number + "</td><td>" + char.License_Status + "</td><td>" + char.License_State + "</td><td>" + char.License_Expiration + "</td><td>" + char.Address + "</td>" +
                    "<td>" + char.DOB + "</td><td>" + char.Gender + "</td><td>" + char.Hair + "</td><td>" + char.Ethnicity + "</td><td>" + char.Weight + "</td></tr>";
                allCharacters = characterHTML;
                $('#characterTable').append(allCharacters);
            }))
        },
        failure: function (response) {

        },
        complete: function (response) {
            getVehiclesTable();

        }
    });
}

//Populate the Vehicles Table onto the UI
function getVehiclesTable() {
    $.ajax({
        type: "POST",
        url: "CADSA.aspx/GetAllVehicles",
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $('#vehicleTable').html("");
            ($.map(data.d, function (veh) {
                var vehiclesHTML = "<tr class='bg-grey2 animated fadeIn' style='cursor:pointer;' onclick='editVehMenu(" + veh.ID + ");'>" + "<td>" + veh.ID + "</td><td>" + veh.Username + "</td><td>" + veh.Owner + "</td><td>" + veh.License_Number + "</td>" +
                    "<td>" + veh.Model + "</td><td>" + veh.Make + "</td><td>" + veh.Color + "</td><td>" + veh.Registration_Valid + "</td><td>" + veh.Insurance_Valid + "</td></tr>";
                allVehicles = vehiclesHTML;
                $('#vehicleTable').append(allVehicles);
            }))
        },
        failure: function (response) {

        },
        complete: function (response) {
            getCallsTable();
        }
    });
}

//Populate the Calls Table onto the UI
function getCallsTable() {
    $.ajax({
        type: "POST",
        url: "CADSA.aspx/GetAllCalls",
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $('#callsTable').html("");
            ($.map(data.d, function (call) {
                var callsHTML = "<tr class='bg-grey2 animated fadeIn' style='cursor:pointer;' onclick='editCallMenu(" + call.ID + ");'>" + "<td>" + call.ID + "</td><td>" + call.Caller + "</td><td>" + call.Location + "</td><td>" + call.Description + "</td>" +
                    "<td>" + call.Date_Time + "</td><td>" + call.Unit_Responding + "</td><td>" + call.Notes + "</td><td>" + call.Status + "</td></tr>";
                allCalls = callsHTML;
                $('#callsTable').append(allCalls);
            }))
        },
        failure: function (response) {

        },
        complete: function (response) {
            $('.regUnitsTable').DataTable({
                "aLengthMenu": [[10, 20, 30, -1], [10, 20, 30, "All"]],
                "iDisplayLength": 10
            });
        }
    });
}

//Toggle Registered Units/Users Table
function toggleRegisteredUsersTable() {
    $("#toggleCharEditor").hide();
    $("#toggleVehicleEditor").hide();
    $("#toggleCallsTable").hide();
    $("#toggleRegUsers").show();

}

//Toggle Character Table
function toggleCharacterTable() {
    $("#toggleRegUsers").hide();
    $("#toggleVehicleEditor").hide();
    $("#toggleCallsTable").hide();
    $("#toggleCharEditor").show();
}

//Toggle Vehicles Table
function toggleVehiclesTable() {
    $("#toggleRegUsers").hide();
    $("#toggleCharEditor").hide();
    $("#toggleCallsTable").hide();
    $("#toggleVehicleEditor").show();
}

//Toggle Calls Table
function toggleCallsTable() {
    $("#toggleRegUsers").hide();
    $("#toggleCharEditor").hide();
    $("#toggleVehicleEditor").hide();
    $("#toggleCallsTable").show();
}

//Open the Edit Unit Menu Dialog
function editUnitMenu(UnitID) {
    currentUnitID = UnitID;
    $.ajax({
        type: "POST",
        url: "CADSA.aspx/GetUnitData",
        data: "{'ID':'" + UnitID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (units) {
                $('#unitDetails').dialog({
                    title: "Unit " + units.Unit_Number + " | " + units.Name,
                    height: 'auto',
                    width: '60%',
                    modal: true,
                    draggable: false,
                    resizable: false,
                    buttons: {
                       'Close': function () {
                            $(this).dialog('close');
                        }
                    }
                });
                $('.unitName').val(units.Name);
                $('.unitUsername').val(units.LoginName);
                $('.unitApproved').val(units.isNewUser);
                $('.unitBanned').val(units.isBanned);
                $('.unitDispatcher').val(units.isDispatcher);
                $('.unitAdmin').val(units.isAdmin);
                $('.unitPrimaryIdentifier').val(units.Unit_Number);
                $('.unitDivision').val(units.Division);
                $('.unitSubDivision').val(units.Sub_Division);
                $('.unitSubDivision2').val(units.Sub_Division_2);
                $('.unitSubDivision3').val(units.Sub_Division_3);
                $('.unitSubDivision4').val(units.Sub_Division_4);
                $('.ui-button').addClass('btn bg-grey2 btn-block btn-sm btn-raised text-white');
            }))
           
        },
        failure: function (response) {

        },
        complete: function (response) {

        }
    });
}

//AJAX Call to Update Unit in Database
function updateUnitComplete(SessionID) {
    var Name = $('.unitName').val();
    var Approved = $('.unitApproved').val();
    var Banned = $('.unitBanned').val();
    var Dispatcher = $('.unitDispatcher').val();
    var Admin = $('.unitAdmin').val();
    var Primary = $('.unitPrimaryIdentifier').val();
    var Division = $('.unitDivision').val();
    var SubD = $('.unitSubDivision').val();
    var SubD2 = $('.unitSubDivision2').val();
    var SubD3 = $('.unitSubDivision3').val();
    var SubD4 = $('.unitSubDivision4').val();
    $.ajax({
        type: "POST",
        url: "CADSA.aspx/UpdateUnitData",
        data: "{'Name':'" + Name + "','ID':'" + currentUnitID + "','Approved':'" + Approved + "','Banned':'" + Banned + "','Dispatcher':'" + Dispatcher + "','Admin':'" + Admin + "','Primary':'" + Primary + "','Division':'" + Division + "','SubD':'" + SubD + "','SubD2':'" + SubD2 + "','SubD3':'" + SubD3 + "','SubD4':'" + SubD4 + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (Name) {
        },
        failure: function (response) {

        },
        complete: function () {
            swal({
                title: "Unit Updated",
                text: "You have successfully updated Unit #" + currentUnitID + " " + Name,
                type: "success",
                timer: 2000,
                showConfirmButton: false
            }, function () {
                location.reload();
            });
        }
    });
}

//AJAX Call to Reset Registered Unit/LEO Password
function resetUnitComplete() {
    var unitNewPassword = $('.newUnitPassword').val();
    swal({
        title: "Are you sure?",
        text: "You are about to reset a Unit password!",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: '#333',
        confirmButtonText: 'Yes, reset it!',
        cancelButtonText: "No, don't reset it!",
        closeOnConfirm: false,
        closeOnCancel: false
    },
        function (isConfirm) {
            if (isConfirm) {
                swal({
                    title: 'Reseting Unit Password!',
                    text: 'Unit password has been successfully changed.',
                    type: 'success'
                }, function () {
                    $.ajax({
                        type: "POST",
                        url: "CADSA.aspx/ResetUnitPassword",
                        data: "{'UnitID':'" + currentUnitID + "', 'UnitPassword':'" + unitNewPassword + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {

                        },
                        failure: function (response) {
         
                        },
                        complete: function () {
                            $('.newUnitPassword').val("");
                        }
                    });
                });
            } else {
                $('.newUnitPassword').val("");
                swal("Cancelled", "Unit password was NOT reset.", "error");
            }
        });
}

//Open the Edit Registered Civilian Menu Dialog
function editUserMenu(UserID) {
    currentUserID = UserID;
    $.ajax({
        type: "POST",
        url: "CADSA.aspx/GetUserData",
        data: "{'ID':'" + UserID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (users) {
                $('#userDetails').dialog({
                    title: "User " + UserID + " | " + users.Name,
                    height: 'auto',
                    width: '60%',
                    modal: true,
                    draggable: false,
                    resizable: false,
                    buttons: {
                        'Close': function () {
                            $(this).dialog('close');
                        }
                    }
                });
                $('.userName').val(users.Name);
                $('.userUsername').val(users.Username);
                $('.userApproved').val(users.isApproved);
                $('.userBanned').val(users.isBanned);
                $('.userEmail').val(users.Email);
                $('.ui-button').addClass('btn bg-grey2 btn-block btn-sm btn-raised text-white');
            }))

        },
        failure: function (response) {

        },
        complete: function (response) {

        }
    });
}

//AJAX Call to Update Registered Civilian in Database
function updateUserComplete() {
    var Name = $('.userName').val();
    var Approved = $('.userApproved').val();
    var Banned = $('.userBanned').val();
    var Email = $('.userEmail').val();
    $.ajax({
        type: "POST",
        url: "CADSA.aspx/UpdateUserData",
        data: "{'Name':'" + Name + "','ID':'" + currentUserID + "','Approved':'" + Approved + "','Banned':'" + Banned + "','Email':'" + Email + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (Name) {
        },
        failure: function (response) {

        },
        complete: function () {
            swal({
                title: "User Updated",
                text: "You have successfully updated User #" + currentUserID + " " + Name,
                type: "success",
                timer: 2000,
                showConfirmButton: false
            }, function () {
                location.reload();
            });
        }
    });
}

//AJAX Call to Reset Registered User/LEO Password
function resetUserComplete() {
    var userNewPassword = $('.newUserPassword').val();
    swal({
        title: "Are you sure?",
        text: "You are about to reset a User password!",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: '#333',
        confirmButtonText: 'Yes, reset it!',
        cancelButtonText: "No, don't reset it!",
        closeOnConfirm: false,
        closeOnCancel: false
    },
        function (isConfirm) {
            if (isConfirm) {
                swal({
                    title: 'Reseting User Password!',
                    text: 'User password has been successfully changed.',
                    type: 'success'
                }, function () {
                    $.ajax({
                        type: "POST",
                        url: "CADSA.aspx/ResetUserPassword",
                        data: "{'UserID':'" + currentUserID + "', 'UserPassword':'" + userNewPassword + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {

                        },
                        failure: function (response) {

                        },
                        complete: function () {
                            $('.newUserPassword').val("");
                        }
                    });
                });
            } else {
                $('.newUserPassword').val("");
                swal("Cancelled", "User password was NOT reset.", "error");
            }
        });
}

//Archive Unit Account and Remove from LEO
$("#archiveUnitBtn").click(function() {
    swal({
        title: "Are you sure?",
        text: "You are about to Archive a Unit account!",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: '#333',
        confirmButtonText: 'Yes, archive it!',
        cancelButtonText: "No, don't archive it!",
        closeOnConfirm: false,
        closeOnCancel: false
    },
        function (isConfirm) {
            if (isConfirm) {
                swal({
                    title: 'Poof! That Unit is Gone.',
                    text: 'That Unit has disappeared...for a very long time.',
                    type: 'success'
                }, function () {
                    $.ajax({
                        type: "POST",
                        url: "CADSA.aspx/ArchiveUnit",
                        data: "{'UserID':'" + currentUnitID + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {
                            location.reload();
                        },
                        failure: function (response) {

                        },
                        complete: function () {
                        }
                    });
                });
            } else {
                swal("That was close...", "This Unit has NOT been Archived...Today.", "error");
            }
        });
});

//Archive User Account and Remove from LEO
$("#archiveUserBtn").click(function () {
    swal({
        title: "Are you sure?",
        text: "You are about to Archive a Civilian User account!",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: '#333',
        confirmButtonText: 'Yes, archive it!',
        cancelButtonText: "No, don't archive it!",
        closeOnConfirm: false,
        closeOnCancel: false
    },
        function (isConfirm) {
            if (isConfirm) {
                swal({
                    title: 'Poof! That Civilian is Gone.',
                    text: 'That Civilian User has disappeared...for a very long time.',
                    type: 'success'
                }, function () {
                    $.ajax({
                        type: "POST",
                        url: "CADSA.aspx/ArchiveUser",
                        data: "{'UserID':'" + currentUserID + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {
                            location.reload();
                        },
                        failure: function (response) {

                        },
                        complete: function () {
                        }
                    });
                });
            } else {
                swal("That was close...", "This Civilian has NOT been Archived...Today.", "error");
            }
        });
});

//Open the Edit Character Menu Dialog
function editCivMenu(CivID) {
    currentCivID = CivID;
    $.ajax({
        type: "POST",
        url: "CADSA.aspx/GetCivData",
        data: "{'CivID':'" + CivID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (civs) {
                $('#civDetails').dialog({
                    title: "Civilian " + CivID + " | " + civs.Full_Name,
                    height: 'auto',
                    width: '60%',
                    modal: true,
                    draggable: false,
                    resizable: false,
                    buttons: {
                        'Close': function () {
                            $(this).dialog('close');
                        }
                    }
                });
             
                $('.civFullName').val(civs.Full_Name);
                $('.civLicense').val(civs.License_Number);
                $('.civAddress').val(civs.Address);
                $('.civLicenseStatus').val(civs.License_Status);
                $('.civDOB').val(civs.DOB);
                $('.civGender').val(civs.Gender);
                $('.civHair').val(civs.Hair);
                $('.civEthnicity').val(civs.Ethnicity);
                $('.civWeight').val(civs.Weight);
                $('.civExpiration').val(civs.License_Expiration);
                $('.civState').val(civs.License_State);
                $('.civPortrait').val(civs.Portrait);
                $('.civFirstName').val(civs.First_Name);
                $('.civLastName').val(civs.Last_Name);
                $('.ui-button').addClass('btn bg-grey2 btn-block btn-sm btn-raised text-white');
            }))

        },
        failure: function (response) {

        },
        complete: function (response) {
           
        }
    });
}

//AJAX Call to Update Character in Database
function updateCivComplete() {
    var civMap = {};
    $('#civDetails input, #civDetails select').each(function (key, value) {
        civMap[$(this).attr('name')] = $(this).val();
    });

    $.ajax({
        type: "POST",
        url: "CADSA.aspx/UpdateCivData",
        data: "{'FirstName':'" + civMap.civFirstName + "','LastName':'" + civMap.civLastName + "','FullName':'" + civMap.civFullName + "','CivLicense':'" + civMap.civLicense + "','CivAddress':'" + civMap.civAddress + "','CivLicenseStatus':'" + civMap.civLicenseStatus + "','CivDOB':'" + civMap.civDOB + "','CivGender':'" + civMap.civGender + "','CivHair':'" + civMap.civHair +
        "','CivEthnicity':'" + civMap.civEthnicity + "','CivWeight':'" + civMap.civWeight + "','CivExpiration':'" + civMap.civExpiration + "','CivState':'" + civMap.civState + "','CivPortrait':'" + civMap.civPortrait + "','CivID':'" + currentCivID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (Name) {
        },
        failure: function (response) {

        },
        complete: function () {
            swal({
                title: "User Updated",
                text: "You have successfully updated Civilian " + civMap.civFullName,
                type: "success",
                timer: 2000,
                showConfirmButton: false
            }, function () {
                location.reload();
            });
        }
    });
}

//Open Register LEO Dialog
function registerLEO() {
    console.log('test')
    $('#leoRegistration').dialog({
        title: "LEO Registration",
        height: 'auto',
        width: '60%',
        modal: true,
        draggable: false,
        resizable: false,
        buttons: {
            'Close': function () {
                $(this).dialog('close');
            }
        }
    });
    $('.ui-button').addClass('btn bg-grey2 btn-block btn-sm btn-raised text-white');
}

$('#registerLeoFinish').click(function () {
    var leoRegMap = {};
    $('#leoRegistration input').each(function (key, value) {
        leoRegMap[$(this).attr('name')] = $(this).val();
    });

    $.ajax({
        type: "POST",
        url: "api/Registration/LEO",
        data: JSON.stringify(leoRegMap),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
       
        },
        failure: function (response) {

        },
        complete: function (data) {
            if (data.responseJSON !== "Success") {
                $("#regMessage").html(data.responseJSON);
            } else {
                swal({
                    title: "New LEO Registered",
                    text: "You have successfully Registered a new Unit to the team. You must approve the account in order for the User to login.",
                    type: "success",
                    timer: 10000,
                    showConfirmButton: false
                }, function () {
                    location.reload();
                });
            }
        }
    });
});

//Registration ID Buttons Toggle/Hide
$(document).ready(function () {
    $("#additionalID1").hide();
    $("#additionalID2").hide();
    $("#additionalID3").hide();
    $("#additionalID4").hide();
    $("#additionalID5").hide();
});

$("#addOne").click(function () {
    $("#addOne").hide();
    $("#additionalID1").show();
});

$("#addTwo").click(function () {
    $("#addTwo").hide();
    $("#additionalID2").show();
});

$("#addThree").click(function () {
    $("#addThree").hide();
    $("#additionalID3").show();
});

$("#addFour").click(function () {
    $("#addFour").hide();
    $("#additionalID4").show();
});

$("#addFive").click(function () {
    $("#addFive").hide();
    $("#additionalID5").show();
});


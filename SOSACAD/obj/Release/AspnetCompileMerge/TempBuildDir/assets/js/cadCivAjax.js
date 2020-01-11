
$(document).ready(function () {
    var currentCivilianLicense = "";
    loadCivilianData(SessionID);
    loadCivilianList(SessionID);
    window.setInterval(function () {
        loadCivilianData(SessionID);
    }, 3000);

    //Keep Session Alive
    $(function () {
        setInterval(KeepSessionAlive, 10000);
    });

    function KeepSessionAlive() {
        $.post("Shared/KeepSessionAlive.ashx", null, function () {
        });
    }   
});

//Allow no spaces on certain inputs
$(function () {
    $('.vehCreatePlate, .civCreateDOB').on('keypress', function (e) {
        if (e.which === 32)
            return false;
    });
});

//Get todays date
var now = new Date();

//Load Vehicle Data Timeout
var currentCivilianSelected = "";
setTimeout(function () { loadVehicleData(currentCivilianSelected); }, 1000);

//Load and Display all Elements of the Logged in Civilian Account
function loadCivilianData(Username) {
      $.ajax({
        type: "POST",
        url: "CivCAD.aspx/GetAllCivs",
        data: "{'Username':'" + Username + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (civData) {
                $("#loggedUser").text(civData.Full_Name);
                $(".civFirstName").text(civData.First_Name);
                $(".civLastName").text(civData.Last_Name);
                $(".civDOB").text(civData.DOB);
                $(".civLicense").text(civData.License_Number);
                $(".civState").text(civData.License_State);
                $(".civAddress").text(civData.Address);
                $(".licenseStatus").text(civData.License_Status);
                $(".licenseExp").text(civData.License_Expiration);
                $(".civFullname").text(civData.Full_Name);
                $(".vehCreateOwner").val(civData.Full_Name);
                $(".portraitImage").attr("src", civData.Portrait);
                currentCivilianSelected = civData.Full_Name;
                currentCivilianLicense = civData.License_Number;
                if (civData.License_Status === "Revoked"){
                    $(".licenseStatus").addClass('text-danger');
                } else {
                    $(".licenseStatus").addClass('text-success');
                }
            }))
        },
        failure: function (response) {

        },
        complete: function (data) {
            if (currentCivilianSelected === "") {
                createCivilian();
                $('.btn').prop("disabled", true);
                $('#createCharacterBtn').prop("disabled", false);
            }
        }
    });
}

//Load and Display all Elements of the Logged in Civilians Selected Characters Vehicle
function loadVehicleData(Owner) {
    var vehicles = [];
    $.ajax({
        type: "POST",
        url: "CivCAD.aspx/GetMyVehicles",
        data: "{'Owner':'" + Owner + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (vehData) {
                vehicles += "<tr class='bg-grey2'>" +
                    "<td>" + vehData.License_Number + "</td>" +
                    "<td>" + vehData.Make + "</td>" +
                    "<td>" + vehData.Model + "</td>" +
                    "<td>" + vehData.Color + "</td>" +
                    "<td class='registrationColor'>" + vehData.Registration_Valid + "</td>" +
                    "<td class='insuranceColor'>" + vehData.Insurance_Valid + "</td>" +
                    "</tr>";
                $('#myCivVehicles').html(vehicles);
            }))
        },
        failure: function (response) {

        },
        complete: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            $("#civVehicleData").show();
            loadTicketData(currentCivilianSelected);
        }
    });
}


//Load and Display all Elements of the Logged in Civilians Selected Characters Tickets
function loadTicketData(Owner) {
    var tickets = [];
    $.ajax({
        type: "POST",
        url: "CivCAD.aspx/GetMyTickets",
        data: "{'Owner':'" + Owner + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (ticketData) {
                tickets += "<tr class='bg-grey2'>" +
                    "<td>" + ticketData.ID + "</td>" +
                    "<td>" + ticketData.Date + "</td>" +
                    "<td>" + ticketData.Ticket_Location + "</td>" +
                    "<td>" + ticketData.Ticket_Charges + "</td>" +
                    "<td>" + ticketData.Ticket_Fine + "</td>" +
                    "<td>" + ticketData.Ticket_Details + "</td>" +
                    "</tr>";
                $('#myCivTickets').html(tickets);
            }))
        },
        failure: function (response) {

        },
        complete: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            $("#civTicketData").show();
            loadFirearmData(currentCivilianSelected);
        }
    });
}

//Load and Display all Elements of the Logged in Civilians Selected Characters Tickets
function loadFirearmData(Owner) {
    var firearms = [];
    $.ajax({
        type: "POST",
        url: "CivCAD.aspx/GetMyFirearms",
        data: "{'Owner':'" + Owner + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (firearmData) {
                firearms += "<tr class='bg-grey2'>" +
                    "<td>" + firearmData.Type + "</td>" +
                    "<td>" + firearmData.Name + "</td>" +
                    "<td>" + firearmData.Date + "</td>" +
                    "<td>" + firearmData.DateExp + "</td>" +
                    "<td>" + firearmData.Registrant + "</td>" +
                    "<td>" + firearmData.Dept + "</td>" +
                    "<td>" + firearmData.LicenseNumber + "</td>" +
                    "</tr>";
                $('#myCivFirearms').html(firearms);
            }))
        },
        failure: function (response) {

        },
        complete: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            $("#civFirearmData").show();
            getStats(currentCivilianSelected);
        }
    });
}

//Load and Display all Elements of the Logged in Civilians Stats
function getStats(Civilian) {
    $.ajax({
        type: "POST",
        url: "CivCAD.aspx/GetStats",
        data: "{'Civilian':'" + Civilian + "','Username':'" + SessionID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $("#registeredVehs").text(data.d[0]);
            $("#ticketsReceived").text(data.d[2]);
            $("#timesWarned").text(data.d[1]);
            $("#totalCharacters").text(data.d[3]);
        },
        failure: function (response) {

        },
        complete: function (response) {

        }
    });
}

//Load and Display all Elements of the Logged in Civilians Characters
function loadCivilianList(Username) {
    var htmlData = "";
      $.ajax({
        type: "POST",
        url: "CivCAD.aspx/GetMyCivs",
        data: "{'Username':'" + Username + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            ($.map(data.d, function (civData) {
                htmlData += '<div class="col-lg-2"><button class="character btn btn-raised bg-grey btn-block btn-lg waves-effect text-white" onclick="civilianSelected(' + civData.License_Number + ",'" + Username + '\'); return false;"> <img src="'+civData.Portrait+'" height="120" class="embed-responsive"/> <br /> <span class="d-block">' + civData.Full_Name + '</span> <span class="d-block">' + civData.License_Number + '</span></button></div>';
            }))
        },
        failure: function (response) {

        },
        complete: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            $("#switchCivilianBtns").html(htmlData);
        }

    });
}

//Switch between Characters on click event
function civilianSelected(License, Username) {
    $.ajax({
        type: "POST",
        url: "CivCAD.aspx/SwitchCivilian",
        data: "{'License':'" + License + "','Username':'" + Username + "'}",
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
        complete: function (data) {
            swal({
                title: "SOSA Civilian Switched!",
                text: "Please wait while we redirect you to your selected civilian profile.",
                type: "success",
                timer: 5000,
                showConfirmButton: false
            }, function () {
                window.location.reload();
            });
        }
    });
    return false;
}
now.setDate(now.getDate() + 365);
function createCivilian() {
    $(".civCreateLicenseExp").val(0);

    var randomDate = now.getMonth() + "/" + now.getDate() + "/" + now.getFullYear();
    $("#registerVehicles").hide();
    $("#registerFirearms").hide();
    $("#switchCivilian").hide();
    $("#dmvData").hide();
    $("#call911").hide();
    $("#createATicket").hide();
    $("#createACivilian").show();

    $(".civCreateLicenseNumber").val(Math.floor(Math.random()*1000000000));
    $(".civCreateLicenseExp").val(randomDate);
}

//Complete Character on click AJAX call to Insert new Character in DB
function createCivilianComplete(Username) {
    var FirstName = $('.civCreateFirstName').val();
    var LastName = $('.civCreateLastName').val();
    var DOB = $('.civCreateDOB').val();
    var Address = $('.civCreateAddress').val();
    var Gender = $('.civCreateGender').val();
    var Hair = $('.civCreateHair').val();
    var Ethnicity = $('.civCreateEthnicity').val();
    var Weight = $('.civCreateWeight').val();
    var LicenseNumber = $('.civCreateLicenseNumber').val();
    var LicenseState = $('.civCreateLicenseState').val();
    var LicenseExpDate = $('.civCreateLicenseExp').val();
    var PortraitImage = $('.civCreateImage').val();
    var LicenseStatus = $('.civCreateLicenseStatus').val();
     $.ajax({
        type: "POST",
        url: "CivCAD.aspx/CreateCivilian",
        data: "{'FirstName':'" + FirstName + "','LastName':'" + LastName + "','DOB':'" + DOB + "','Address':'" + Address + "','ImagePortrait':'" + PortraitImage + "','Gender':'" 
        + Gender + "','Hair':'" + Hair + "','Ethnicity':'" + Ethnicity + "','Weight':'" + Weight + "','LicenseNumber':'" + LicenseNumber + "','LicenseState':'" + LicenseState + "','LicenseExpDate':'" + LicenseExpDate + "','Username':'" + Username + "','LicenseStatus':'" + LicenseStatus + "'}",
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
        complete: function (data) {
            swal({
                title: "SOSA Civilian Created!",
                text: "Welcome to the State of San Andreas, "+FirstName+". You are now successfully registered as a Civilian of San Andreas. Redirecting in 5 seconds.",
                type: "success",
                timer: 5000,
                showConfirmButton: false
                    }, function(){
                        civilianSelected(LicenseNumber, Username);
                        window.location.reload();
            });
        }
    });
}

//Complete Vehicle on click AJAX call to Insert new Vehicle in DB
function registerVehicleComplete(Username) {
    var Model = $('.vehCreateModel').val();
    var Make = $('.vehCreateMake').val();
    var Color = $('.vehCreateColor').val();
    var Plate = $('.vehCreatePlate').val();
    var Insurance = $('.vehCreateInsurance').val();
    var Stolen = $('.vehCreateStolen').val();
    var Registration = $('.vehCreateRegistration').val();

    $.ajax({
        type: "POST",
        url: "CivCAD.aspx/RegisterVehicle",
        data: "{'Model':'" + Model + "','Make':'" + Make + "','Color':'" + Color + "','Plate':'" + Plate + "','Owner':'" + currentCivilianSelected + "','User':'" + Username + "','Insurance':'" + Insurance + "','Stolen':'" + Stolen + "','Registration':'" + Registration + "'}",
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
        complete: function (data) {
            swal({
                title: "SOSA Vehicle Created!",
                text: "You have successfully registered your vehicle: "+ Model + " " + Make + ". Drive Safe! Redirecting in 5 seconds.",
                type: "success",
                timer: 5000,
                showConfirmButton: false
            }, function () {
                window.location.reload();
            });
        }
    });
}

//Complete Register Firarm on click AJAX call to Insert new Firearm in DB
function registerFirearmComplete() {
    var Type = $('.firearmType').val();
    var Name = $('.firemarmName').val();
    var Date = $('.firearmIssued').val();
    var DateExp = $('.firearmExpired').val();
    var LicenseNumber = $('.firearmLicenseNumber').val();
    var Dept = $('.firearmDept').val();

    $.ajax({
        type: "POST",
        url: "CivCAD.aspx/RegisterFirearm",
        data: "{'Type':'" + Type + "','Name':'" + Name + "','Date':'" + Date + "','DateExp':'" + DateExp + "','Registrant':'" + currentCivilianSelected + "','Dept':'" + Dept + "','LicenseNumber':'" + LicenseNumber + "'}",
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
        complete: function (data) {
            swal({
                title: "SOSA Firearm Registered!",
                text: "You have successfully registered your Firearm: " + Type + " " + Name + ". Be Safe! Redirecting in 5 seconds.",
                type: "success",
                timer: 5000,
                showConfirmButton: false
            }, function () {
                window.location.reload();
            });
        }
    });
}

//AJAX Call to Create a Ticket for Selected Character
function createTicketComplete() {
    var FullName = $('.ticketFullName').val();
    var TicketDate = $('.ticketDate').val();
    var TicketUnit = $('.ticketUnit').val();
    var TicketLocation = $('.ticketLocation').val();
    var TicketLicenseNumber = $('.licenseNumber').val();
    var TicketDetails = $('.ticketDetails').val();
    var TicketCharges = $('.ticketCharges').val();
    var TicketFines = $('.ticketFines').val();

    $.ajax({
        type: "POST",
        url: "CivCAD.aspx/CreateTicket",
        data: "{'FullName':'" + FullName + "','TicketDate':'" + TicketDate + "','TicketUnit':'" + TicketUnit + "','TicketLocation':'" + TicketLocation + "','TicketLicenseNumber':'" + TicketLicenseNumber + "','TicketDetails':'" + TicketDetails + "','TicketCharges':'" + TicketCharges + "','TicketFines':'" + TicketFines + "'}",
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
        complete: function (data) {
            swal({
                title: "Civilian Ticket Created!",
                text: "You have successfully created a Ticket for: " + currentCivilianSelected + ". Redirecting in 5 seconds.",
                type: "success",
                timer: 5000,
                showConfirmButton: false
            }, function () {
                window.location.reload();
            });
        }
    });
}

//AJAX Call to Create a 911 Call for Selected Character
function create911Call() {
    var CallDate = $('.callDate').val();
    var CallLocation = $('.callLocation').val();
    var CallDetails = $('.callDetails').val();
    var CallerName = currentCivilianSelected;
    $.ajax({
        type: "POST",
        url: "CivCAD.aspx/CreateCall",
        data: "{'CallerName':'" + CallerName + "','CallDate':'" + CallDate + "','CallLocation':'" + CallLocation + "','CallDetails':'" + CallDetails + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (data) {
            $('.sendCallbtn').hide();
        },
        failure: function (response) {
            var r = jQuery.parseJSON(response.responseText);
            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        },
        complete: function (data) {
            
            $('.911callerName').text(CallerName);
            $('.911message').text(CallDetails);
            $('.911location').text(CallLocation);
            $('.911caller').css('display', 'block');
            setTimeout(function () {
                $('.911dispatcher2').css('display', 'block');
            }, 3000);
            setTimeout(function () {
                swal({
                    title: "New Message",
                    text: "Hello, " + currentCivilianSelected + ". We have sent a Unit to your location, they will arrive shortly.",
                    type: "success",
                    showConfirmButton: true
                }, function () {
                    window.location.reload();
                    });
            },8000);
        }
    });
}

//Switch Civilian UI to Toggle
function switchCivilian() {
    $("#dmvData").hide();
    $("#createACivilian").hide();
    $("#registerVehicles").hide();
    $("#registerFirearms").hide();
    $("#createATicket").hide();
    $("#call911").hide();
    $("#switchCivilian").show();
}

//Register Vehicle UI to Toggle
function registerVehicle() {
    $("#dmvData").hide();
    $("#createACivilian").hide();
    $("#createATicket").hide();
    $("#switchCivilian").hide();
    $("#call911").hide();
    $("#registerFirearms").hide();
    $("#registerVehicles").show();
}

//Main Menu UI Toggle
function returnToMenu() {
    $("#createACivilian").hide();
    $("#registerVehicles").hide();
    $("#createATicket").hide();
    $("#switchCivilian").hide();
    $("#call911").hide();
    $("#registerFirearms").hide();
    $("#dmvData").show();
}

//Create a Ticket UI Toggle
function createATicket() {
    $("#createACivilian").hide();
    $("#registerVehicles").hide();
    $("#switchCivilian").hide();
    $("#dmvData").hide();
    $("#call911").hide();
    $("#registerFirearms").hide();
    $("#createATicket").show();
    $(".ticketFullName").val(currentCivilianSelected);
    $(".licenseNumber").val(currentCivilianLicense);
}


//Create a Ticket UI Toggle
function registerFirearm() {
    $("#createATicket").hide();
    $("#createACivilian").hide();
    $("#switchCivilian").hide();
    $("#dmvData").hide();
    $("#call911").hide();
    $("#registerFirearms").show();
    $("#registerVehicles").hide();
    $(".ticketFullName").val(currentCivilianSelected);
    $(".licenseNumber").val(currentCivilianLicense);
    $(".firearmLicenseNumber").val(Math.floor(Math.random() * 1000000000));
    $(".firearmOwner").val(currentCivilianSelected);
}

//Call 911 UI Toggle
function call911() {
    now.setDate(now.getDate() + 0);
    var todaysDate = now.getDate() + "/" + now.getMonth() + "/" + now.getFullYear();
    $("#createACivilian").hide();
    $("#registerVehicles").hide();
    $("#switchCivilian").hide();
    $("#registerFirearms").hide();
    $("#dmvData").hide();
    $("#createATicket").hide();
    $("#call911").show();
    $(".call911Phone").text(currentCivilianSelected + "'s Cell Phone");
    $(".callDate").val(todaysDate);
    setTimeout(function () {
        $(".callingText").removeClass("animated infinite flash");
        $(".callingText").addClass("text-success");
        $(".callingText").text("CONNECTED");
        $(".911dispatcher").addClass("animated slideInRight");
        $(".911dispatcher").css("visibility", "visible");

    }, 3000);
}

//Show the DIV for changing Selected Character Image
function changeURLImage() {
    $("#changeImagePopup").show();
}

//AJAX Call to Update Character Image in DB
function changeURLImageSubmit() {
    var imageURLUpdate = $(".imageURLUpdate").val();
    $.ajax({
        type: "POST",
        url: "CivCAD.aspx/ChangeCivilianImage",
        data: "{'FullName':'" + currentCivilianSelected + "', 'URL':'" + imageURLUpdate + "'}",
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
        complete: function (data) {
            swal({
                title: "SOSA Civilian Image Updated!",
                text: "Please wait while we redirect you to your selected civilian profile.",
                type: "success",
                timer: 5000,
                showConfirmButton: false
            }, function () {
                window.location.reload();
            });
        }
    });
    return false;
}
$(document).ready(function () {
    var currentCivilianSelected = "";
    loadCivilianData(SessionID);
    loadCivilianList(SessionID);
});

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
                currentCivilianSelected = civData.Full_Name;
                if (civData.License_Status === "Revoked"){
                    $(".licenseStatus").addClass('text-danger');
                } else {
                    $(".licenseStatus").addClass('text-success');
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
            loadVehicleData(currentCivilianSelected);
        }
    });
}

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
                vehicles += "<tr class='bg-grey2 animated fadeIn'>" +
                    "<td>" + vehData.License_Number + "</td>" +
                    "<td>" + vehData.Make + "</td>" +
                    "<td>" + vehData.Model + "</td>" +
                    "<td>" + vehData.Color + "</td>" +
                    "<td>" + vehData.Registration_Valid + "</td>" +
                    "<td>" + vehData.Insurance_Valid + "</td>" +
                    "</tr>";
                $('#myCivVehicles').html(vehicles);
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
                htmlData += '<div class="col-lg-2"><button class="character btn btn-raised bg-grey btn-block btn-lg waves-effect text-white" onclick="civilianSelected(' + civData.License_Number + ",'" + Username + '\'); return false;"> <img src="assets/images/portraitid.png" height="90" class="embed-responsive"/> <br /> <span class="d-block">' + civData.Full_Name + '</span> <span class="d-block">' + civData.License_Number + '</span></button></div>';
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
            $("#switchCivilianBtns").html(htmlData);
        }

    });
}

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
                text: "Please wait while we redirect you to your selected Civilian profile.",
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

function createCivilian() {
    var now = new Date();
    now.setDate(now.getDate()+ 365);
    var randomDate = now.getMonth() + "/" + now.getDate() + "/" + now.getFullYear();
    $("#dmvData").hide();
    $("#switchCivilian").hide();
    $("#registerVehicles").hide();
    $("#createACivilian").show();

    $(".civCreateLicenseNumber").val(Math.floor(Math.random()*1000000000));
    $(".civCreateLicenseExp").val(randomDate);
}

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

     $.ajax({
        type: "POST",
        url: "CivCAD.aspx/CreateCivilian",
        data: "{'FirstName':'" + FirstName + "','LastName':'" + LastName + "','DOB':'" + DOB + "','Address':'" + Address + "','Gender':'" 
        + Gender + "','Hair':'" + Hair + "','Ethnicity':'" + Ethnicity + "','Weight':'" + Weight + "','LicenseNumber':'" + LicenseNumber + "','LicenseState':'" + LicenseState + "','LicenseExpDate':'" + LicenseExpDate + "','Username':'" + Username + "'}",
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
                text: "Welcome to the State of San Andreas, "+FirstName+". You are now successfully registered as a Civilian of San Andreas. Redirecting in 6 seconds.",
                type: "success",
                timer: 6000,
                showConfirmButton: false
                    }, function(){
                window.location.reload();
            });
        }
    });
}

function registerVehicleComplete(Civilian) {
    var Model = $('.vehCreateModel').val();
    var Make = $('.vehCreateMake').val();
    var Color = $('.vehCreateColor').val();
    var Plate = $('.vehCreatePlate').val();
    $.ajax({
        type: "POST",
        url: "CivCAD.aspx/RegisterVehicle",
        data: "{'Model':'" + Model + "','Make':'" + Make + "','Color':'" + Color + "','Plate':'" + Plate + "','Owner':'" + Civilian + "','User':'" + currentCivilianSelected + "'}",
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
                text: "You have successfully registered your vehicle: "+ Model + " " + Make + ". Drive Safe! Redirecting in 6 seconds.",
                type: "success",
                timer: 6000,
                showConfirmButton: false
            }, function () {
                window.location.reload();
            });
        }
    });
}

function switchCivilian() {
    $("#dmvData").hide();
    $("#createACivilian").hide();
    $("#registerVehicles").hide();
    $("#switchCivilian").show();
}

function registerVehicle() {
    $("#dmvData").hide();
    $("#createACivilian").hide();
    $("#registerVehicles").show();
    $("#switchCivilian").hide();
}

function returnToMenu() {
    $("#dmvData").show();
    $("#createACivilian").hide();
    $("#registerVehicles").hide();
    $("#switchCivilian").hide();
}
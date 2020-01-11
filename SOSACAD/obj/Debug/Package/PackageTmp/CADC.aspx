<%@ Page Title="SOSA CAD" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CADC.aspx.cs" Inherits="SoSACAD.CADSV" MaintainScrollPositionOnPostBack = "true"%>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <!-- main content -->
    <section class="content" style="background-color: #333;">
        <div class="container-fluid">
            <div class="block-header">
                <h2 style="color: #B1B1B1 !important;">SoSA CAD - Computer-aided Dispatch System | Dashboard</h2>
            </div>

             <div class="container-fluid">
            <div class="row clearfix">
                <div class="col-lg-12">
                    <h3 style="color: #fff" class="text-center">DISPATCHER MENU</h3>
                    <div class="col-lg-2">
                        <button class="bg-grey btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="$('#activeCalls').toggle(); return false;">
                            ACTIVE CALLS
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button class="bg-grey btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="$('#pendingCalls').toggle(); return false;">
                            PENDING CALLS
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button class="bg-grey btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="$('#unitsList').toggle(); return false;">
                            AVAILABLE UNITS
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button class="bg-grey btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="$('#offlineUnits').toggle(); return false;">
                            OFFLINE UNITS
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button class="bg-grey btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="$('#activeUnits').toggle(); return false;">
                            NOTEPAD
                        </button>
                    </div>
                    <div class="col-lg-2">
                        <button class="bg-grey btn btn-lg btn-raised waves-effect" style="color: #B1B1B1;" onclick="$('#activeCalls').toggle(); return false;">
                            LOG OFF
                        </button>
                    </div>
                </div>
            </div>
                 <hr />
             <div id="unitConsole" class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="card bg-grey">
                        <div class="header bg-grey">
                            <h2>UNIT CONSOLE - <span id="currentPatrolStatus"></span></h2>
                        </div>
                        <div class="body">
                            <h4 style="color: #B1B1B1;"><span id="UnitNumber"></span> <span id="UnitName">Select an Available Unit to Control</span></h4>
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

            <!-- Contextual Classes -->
            <div id="activeCalls" class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="card bg-grey">
                        <div class="header bg-grey">
                            <h2>ACTIVE CALLS</h2>
                        </div>
                        <div class="body table-responsive">
                            <table class="table table-condensed">
                                <thead>
                                    <tr>
                                        <th style="color: #B1B1B1;">ID #</th>
                                        <th style="color: #B1B1B1;">Caller</th>
                                        <th style="color: #B1B1B1;">Location</th>
                                        <th style="color: #B1B1B1;">Date & Time</th>
                                        <th style="color: #B1B1B1;">Description</th>
                                        <th style="color: #B1B1B1;">Officer</th>
                                        <th style="color: #B1B1B1;">Status</th>
                                        <th style="color: #B1B1B1;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody id="ActiveCallsData">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div id="pendingCalls" class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="card bg-grey">
                        <div class="header bg-grey">
                            <h2>PENDING CALLS</h2>
                        </div>
                        <div class="body table-responsive">
                            <table class="table table-condensed">
                                <thead>
                                    <tr>
                                        <th style="color: #B1B1B1;">ID #</th>
                                        <th style="color: #B1B1B1;">Caller</th>
                                        <th style="color: #B1B1B1;">Location</th>
                                        <th style="color: #B1B1B1;">Date & Time</th>
                                        <th style="color: #B1B1B1;">Description</th>
                                        <th style="color: #B1B1B1;">Status</th>
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

            <div id="unitsList" class="row clearfix">
                <div class="col-lg-6 col-md-6 col-sm-12 ">
                    <div class="card bg-grey">
                        <div class="header bg-grey">
                            <h2 class="text-success">Available Units</h2>
                        </div>
                        <div class="body">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th style="color: #B1B1B1;">Unit #</th>
                                            <th style="color: #B1B1B1;">Name</th>
                                            <th style="color: #B1B1B1;">Status</th>
                                            <th style="color: #B1B1B1;">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody id="availableUnits">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-12 ">
                    <div class="card bg-grey">
                        <div class="header bg-grey">
                            <h2 class="text-warning">Busy Units</h2>
                        </div>
                        <div class="body">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th style="color: #B1B1B1;">Unit #</th>
                                            <th style="color: #B1B1B1;">Name</th>
                                            <th style="color: #B1B1B1;">Status</th>
                                            <th style="color: #B1B1B1;">Actions</th>
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
              
            <div id="offlineUnits" class="row clearfix">
                <div class="col-lg-6 col-md-6 col-sm-12 ">
                    <div class="card bg-grey">
                        <div class="header bg-grey">
                            <h2 class="text-danger">Unavailable Units</h2>
                        </div>
                        <div class="body">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th style="color: #B1B1B1;">Unit #</th>
                                            <th style="color: #B1B1B1;">Name</th>
                                            <th style="color: #B1B1B1;">Status</th>
                                            <th style="color: #B1B1B1;">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody id="unavailableUnits">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
            </div>
    </section>
    <script>
        $(document).ready(function () {
            var SessionID = '<%=Session["User"]%>';
            loadDispatcherData(SessionID);
            });
</script>
</asp:Content>

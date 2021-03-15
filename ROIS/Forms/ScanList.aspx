<%@ Page Title="" Language="C#" MasterPageFile="~/Forms/Site.Master" AutoEventWireup="true" CodeBehind="ScanList.aspx.cs" Inherits="ROIS.Forms.ScanList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../css/upload_style.css" rel="stylesheet" />
    <link href="../css/lightbox.min.css" rel="stylesheet" />

    <form id="formtemp">

        <div class="form-group m-form__group row">
            <div class="col-12">
                <div class="input-group input-group-lg m-input-group">

                    <div class="input-group-prepend">
                        <%--Barcode scanning button--%>
                        <a href="#" class="btn btn-outline-accent btn-lg m-btn m-btn--icon " id="btnScan" name="btnScan">
                            <i class="la la-barcode"></i>
                        </a>
                        <%--Barcode scanning button--%>
                    </div>

                    <input type="text" class="form-control form-co-lg m-input m--icon-font-size-sm2 align-items-lg-start" id="txtBarcode" placeholder="Scan Barcode" />
                </div>

            </div>
        </div>
    </form>

        <!--Begin Form portlet-->
        <div class="row">
        <div class="col-md-6">
            <!--begin::Portlet-->
            <div class="m-portlet m-portlet--tab">
                <div class="m-portlet__head">
                    <div class="m-portlet__head-caption">
                        <div class="m-portlet__head-title">
                            <h3 class="m-portlet__head-text">Scanning
                            </h3>
                        </div>
                    </div>
                </div>

                <div class="m-portlet__body font">

                    <%--    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>--%>
                    <div class="form-group m-form__group row">
                        <div class="col-12">
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <label for="example-refno-input" class="col-3 col-form-label">Reference No.</label>
                        <div class="col-9">
                            <input type="text" class="form-control m-input" id="txtRefNo" placeholder="Reference No." disabled="disabled">
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <label for="example-qty-input" class="col-3 col-form-label">Location:</label>
                        <div class="col-5">
                            <select class="form-control m-input" id="selectLocation">
                                <option value="0">--SELECT--</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <label for="example-qty-input" class="col-3 col-form-label">Reason:</label>
                        <div class="col-5">
                            <select class="form-control m-input" id="selectReason">
                                <option value="0">--SELECT--</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <!--end::Portlet-->
        </div>

        <div class="col-md-6">

        </div>

    </div>

        <div class="m-portlet m-portlet--mobile">
        <div class="m-portlet__head">
            <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                    <h3 class="m-portlet__head-text">Scanned Barcode</h3>
                </div>
            </div>
        </div>
        <div class="m-portlet__body">

            <!--begin: Datatable -->
            <div id="m_table_1_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
                <div class="row">
                    <div class="col-sm-12">
                        <table id="dgrid" class="table table-striped- table-bordered table-hover table-checkable dataTable no-footer dtr-inline collapsed" role="grid">
                            <thead>
                                <tr>
                                    <th>Barcode</th>
                                    <th>Location</th>
                                    <th>Reason</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot>
                            </tfoot>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!--begin::Modal-->
    <div class="modal fade" id="modal_scan" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modal_scan_label">Scanning</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="interactive" class="viewport"></div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>


            </div>
        </div>
    </div>

    <!--end::Modal-->
   <script>
       $(document).ready(function () {
           locationDropDown();
           getReasons(1);

           loadGrid();

           function loadGrid() {
               $.ajax({
                   url: 'ROISWebService.asmx/ScanListTbl',
                   method: 'post',
                   contentType: "application/json; charset=utf-8",
                   dataType: 'json',
                   success: function (data) {
                       $('#dgrid').dataTable({
                           responsive: true,
                           data: data,
                           bDestroy: true,
                           columns: [
                               { 'data': 'barcode' },
                               { 'data': 'location' },
                               { 'data': 'reason' }
                           ],

                           order: [[0, "asc"]],

                       });
                       //$('#m_table_1').show();
                       //$('#waitmeload').hide();
                   } // end success

               }); //end loadGrid
           }

           function resetForm() {
               $('#selectLocation').val(0);
               $('#selectReason').val(0);
               $('#txtBarcode').val('');
               loadGrid();
           }

           $('#txtBarcode').blur(function () {
               let varBarcode = $('#txtBarcode').val().trim();
               let selectedLoc = $('#selectLocation option:selected').val();
               let selectedReason = $('#selectReason option:selected').val();
               let uip = '<%= Request.UserHostAddress %>'

                if (varBarcode != '') {
                    if (selectedLoc == 0 || selectedReason == 0) {
                        swal("Error", "You must select a location and reason", "error");
                    }
                    else {
                        InsertTblData(varBarcode, selectedLoc, selectedReason, uip)
                    }
                }
           });

           function InsertTblData(argBarcode, argLocId, argReasonId, argIpAdd = '192.168.1.1') {
               var request = new XMLHttpRequest();
               var data = JSON.stringify({ scannedBarcode: argBarcode, locId: argLocId, reasonId: argReasonId, ipAdd: argIpAdd});
               request.open('POST', 'ROISWebService.asmx/InsertScannnedBarcode', true);
               request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

               request.onload = function () {
                   if (this.status >= 200 && this.status < 400) {
                       // Success!
                       swal("Success!", "Barcode Successfully Scanned", "success");
                       resetForm();
                   } else {
                       console.log(this.response);
                   }
               };

               request.onerror = function () {
                   console.log(this.response);
               };

               request.send(data);
           }

            $('#btnScan').click(function () {
                $('#modal_scan').modal('show');

                Quagga.init({
                    inputStream: {
                        name: "Live",
                        type: "LiveStream",
                        target: document.querySelector('#interactive.viewport'),
                    },
                    decoder: {
                        readers: ["code_128_reader"]
                    }
                }, function (err) {
                    if (err) {
                        console.log(err);
                        return
                    }
                    console.log("Initialization finished. Ready to start");
                    Quagga.start();
                });
            });

            Quagga.onDetected(function (result) {
                let code = result.codeResult.code;
                $('#txtBarcode').val(code);
                let scannedBarcode = $('#txtBarcode').val().trim();
                $('#modal_scan').modal('hide');
                let selectedLoc = $('#selectLocation option:selected').val();
                let selectedReason = $('#selectReason option:selected').val();
                let uip = '<%= Request.UserHostAddress %>'

                if (scannedBarcode != '') {
                    if (selectedLoc == 0 || selectedReason == 0) {
                        swal("Error", "You must select a location and reason", "error");
                    }
                    else {
                        InsertTblData(scannedBarcode, selectedLoc, selectedReason, uip);
                    }
                }

                Quagga.stop();
                console.log("Stop camera.");
            });
        });

       function locationDropDown() {
           let fromLocalStorage = JSON.parse(localStorage.getItem("receivingDropdown"));
           let sel = document.getElementById("selectLocation");

           if (!fromLocalStorage) {
               $(location).attr('href', 'Login.aspx');
           }
           else {
               console.log(!fromLocalStorage);
               for (i in fromLocalStorage) {
                   let opt = document.createElement("option");
                   opt.appendChild(document.createTextNode(fromLocalStorage[i].locationDesc));
                   opt.value = fromLocalStorage[i].locationId;
                   sel.appendChild(opt);
               }
           }
       }

       function getReasons(transactionType) {
           let currentUserId = sessionStorage.getItem("userId");
           let sel = document.getElementById("selectReason");
           let data = JSON.stringify({ userId: currentUserId, transactionMode: transactionType });
           let request = new XMLHttpRequest();
           request.open('POST', 'ROISWebService.asmx/GetReasons');
           request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

           request.onload = function () {
               if (this.status >= 200 && this.status < 400) {
                   let reasons = JSON.parse(this.responseText);

                   for (i in reasons) {
                       let opt = document.createElement("option");
                       opt.appendChild(document.createTextNode(reasons[i].reasonDesc));
                       opt.value = reasons[i].reasonId;
                       sel.appendChild(opt);
                   }
               }
               else {

               }
           };

           request.onerror = function () {
               console.log("Test");
           };

           request.send(data);
       }
   </script>
    <script src="../scripts/lightbox-plus-jquery.min.js"></script>
    <script src="../scripts/adapter-latest.js"></script>
    <script src="../scripts/quagga.js"></script>
    <script src="../scripts/scale.fix.js"></script>
</asp:Content>  

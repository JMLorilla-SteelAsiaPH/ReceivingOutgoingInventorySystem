 <%@ Page Title="" Language="C#" MasterPageFile="~/Forms/Site.Master" AutoEventWireup="true" CodeBehind="ScanReceiving.aspx.cs" Inherits="ROIS.Forms.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link href="../css/upload_style.css" rel="stylesheet" />
    <link href="../css/lightbox.min.css" rel="stylesheet" />

    <form id="formtemp">

        <div class="form-group m-form__group row">
            <div class="col-12">
                <div class="input-group input-group-lg m-input-group">

                    <div class="input-group-prepend">
                        <%--                  <span class="input-group-text" id="basic-addon1"><i class="la la-barcode"></i>
          
                           
                        </span>--%>

                        <%--Barcode scanning button--%>
                        <a href="#" class="btn btn-outline-accent btn-lg m-btn m-btn--icon " id="btnScan" name="btnScan">

                            <i class="la la-barcode"></i>

                        </a>
                        <%--Barcode scanning button--%>

                        <%--  <input class="btn btn-secondary" type="button" id="btnScan" name="btnScan" value="Upload" />--%>
                    </div>

                    <input type="text" class="form-control form-co-lg m-input m--icon-font-size-sm2 align-items-lg-start" id="txtBarcode" placeholder="Scan Barcode" />
                </div>

            </div>
        </div>
    </form>
    <div class="row">
        <div class="col-md-6">
            <!--begin::Portlet-->
            <div class="m-portlet m-portlet--tab">
                <div class="m-portlet__head">
                    <div class="m-portlet__head-caption">
                        <div class="m-portlet__head-title">
                            <h3 class="m-portlet__head-text">Receiving Issuance
                            </h3>
                        </div>
                    </div>
                    <div class="m-portlet__head-tools">
                        <ul class="m-portlet__nav">
                            <li class="m-portlet__nav-item">
                                <button class="m-portlet__nav-link btn btn-primary m-btn m-btn--pill m-btn--air" id="btnEdit1">
                                    <span>
                                        <i class="fa fa-clipboard-list"></i>
                                        <span>Edit</span>
                                    </span>
                                </button>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="m-portlet__body font">

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
                        <label for="example-prodcode-input" class="col-3 col-form-label">Product Code</label>
                        <div class="col-9">
                            <input type="text" class="form-control m-input" id="txtProdCode" placeholder="Product Code" disabled="disabled">
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <label for="example-locid-input" class="col-3 col-form-label">Location ID</label>
                        <div class="col-3">
                            <input type="text" class="form-control m-input" id="txtLocID" placeholder="Location ID" disabled="disabled">
                        </div>
                    </div>
                    <div class="form-group m-form__group row">
                        <label for="example-fileno-input" class="col-3 col-form-label">File No.</label>
                        <div class="col-9">
                            <input type="text" class="form-control m-input" id="txtFileNo" placeholder="File No." disabled="disabled">
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <label for="example-bundleno-input" class="col-3 col-form-label">Bundle No.</label>
                        <div class="col-9">
                            <input type="text" class="form-control m-input" id="txtBundleNo" placeholder="Bundle No." disabled="disabled">
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <label for="example-qty-input" class="col-3 col-form-label">Qty.</label>
                        <div class="col-5">
                            <input type="number" class="form-control m-input" id="txtQty" disabled="disabled">
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <label for="example-qty-input" class="col-3 col-form-label">Location:</label>
                        <div class="col-5">
                            <select class="form-control m-input" id="selectLocation">
                            </select>
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <button type="button" class=" col-3 btn btn-accent" id="btnReceive">RECEIVE</button>
                        <div class="col-5">
                        </div>
                    </div>

                    
                </div>
            </div>

            <!--end::Portlet-->
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
            $('#btnEdit1').hide();
            $('.progress').hide();
            $('#btnReceive').prop("disabled", true);

            $('#btnReceive').click(function () {
                var employee = sessionStorage.getItem("userId");

                let argId = $('#txtBarcode').val();
                let argRefNo = $("#txtRefNo").val();
                let argProdCd = $("#txtProdCode").val();
                let argFileNo = $("#txtFileNo").val();
                let argBundleNo = $("#txtBundleNo").val();
                let argQty = $("#txtQty").val();
                let argLastUser = employee;

                receiveData(argId, argRefNo, argProdCd, argFileNo, argBundleNo, argQty, argLastUser);
            });

            function receiveData(argId, argRefNo, argProdCd, argFileNo, argBundleNo, argQty, argLastUser) {
                var request = new XMLHttpRequest();
                var data = JSON.stringify({ passId: argId, passRefNo: argRefNo, passProdCd: argProdCd, passFileNo: argFileNo, passBundleNo: argBundleNo, passQty: argQty, passLastUser: argLastUser });
                request.open('POST', 'ROISWebService.asmx/InsertReceivingData', true);
                request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

                request.onload = function () {
                    if (this.status >= 200 && this.status < 400) {
                        // Success!
                        swal("Receiving Data Recorded");
                        clearForm();
                    } else {
                        console.log(this.response);
                    }
                };

                request.onerror = function () {
                    console.log(this.response);
                };

                request.send(data);
            }

            $('#txtBarcode').blur(function () {
                var varBarcodeTag = $('#txtBarcode').val();
                if (varBarcodeTag != '') {
                    check_barcode_if_exists(varBarcodeTag);
                }
            });

            $('#btnScan').click(function () {
                $('#modal_scan').modal('show');

                Quagga.init({
                    inputStream: {
                        name: "Live",
                        type: "LiveStream",
                        target: document.querySelector('#interactive.viewport'),    // Or '#yourElement' (optional)
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
                var code = result.codeResult.code;
                $('#txtBarcode').val(code);
                $('#modal_scan').modal('hide');
                check_barcode_if_exists($('#txtBarcode').val());
                Quagga.stop();
                console.log("Stop camera.");
            });

        });

       function check_barcode_if_exists(scanned_barcode) {
           var request = new XMLHttpRequest();
           var data = JSON.stringify({ scannedBarcode: scanned_barcode, transType: 1 });
           request.open('POST', 'ROISWebService.asmx/CheckIfBarcodeExists', true);
           request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

           request.onload = function () {
               if (this.status >= 200 && this.status < 400) {
                   // Success!
                   var result = JSON.parse(this.responseText);

                   if (result > 0) {
                       swal("Data already exists on records.");
                       $('#btnReceive').prop("disabled", true);
                       clearForm();
                   }
                   else {
                       load_ITRLT_posted_subdetails(scanned_barcode);
                   }
               } else {
                   // We reached our target server, but it returned an error
                   console.log("Status Error");
               }
           };

           request.onerror = function () {
               //console.log(this.response);
               console.log("Request OnError");
           };

           request.send(data);
       }

       function clearForm() {
           document.getElementById("#txtBarcode").value = "";
           document.getElementById("txtRefNo").value = "";
           document.getElementById("txtProdCode").value = "";
           document.getElementById("txtFileNo").value = "";
           document.getElementById("txtBundleNo").value = "";
           document.getElementById("txtLocID").value = "";
           document.getElementById("txtQty").value = 0;
       }

       function load_ITRLT_posted_subdetails(scanned_barcode) {
           var request = new XMLHttpRequest();
           var data = JSON.stringify({ scanned_barcode: scanned_barcode });
           request.open('POST', 'ROISWebService.asmx/GetPostedSubdetails', true);
           request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

           request.onload = function () {
               if (this.status >= 200 && this.status < 400) {
                   // Success!
                   var subdetails = JSON.parse(this.responseText);

                   if (subdetails.length != 0) {
                       document.getElementById("txtRefNo").value = subdetails[0].barcodetag;
                       document.getElementById("txtProdCode").value = subdetails[0].prodcode;
                       document.getElementById("txtFileNo").value = subdetails[0].filenumber;
                       document.getElementById("txtBundleNo").value = subdetails[0].bundlenumber;
                       document.getElementById("txtLocID").value = subdetails[0].locationcode;
                       document.getElementById("txtQty").value = subdetails[0].quantity;
                       $('#btnReceive').prop("disabled", false);
                   } else {
                       swal("Data does not exist from source records.");
                       $('#btnReceive').prop("disabled", true);
                   }
               } else {
                   // We reached our target server, but it returned an error
                   document.getElementById("txtRefNo").value = "";
                   document.getElementById("txtProdCode").value = "";
                   document.getElementById("txtFileNo").value = "";
                   document.getElementById("txtBundleNo").value = "";
                   document.getElementById("txtLocID").value = "";
                   document.getElementById("txtQty").value = 0;
               }
           };

           request.onerror = function () {
               //console.log(this.response);
           };

           request.send(data);
       }
   </script>

    <script src="../scripts/lightbox-plus-jquery.min.js"></script>
    <script src="../scripts/adapter-latest.js"></script>
    <script src="../scripts/quagga.js"></script>
    <script src="../scripts/scale.fix.js"></script>
</asp:Content>

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
                        <label for="example-fileno-input" class="col-3 col-form-label">File No.</label>
                        <div class="col-9">
                            <input type="text" class="form-control m-input" id="txtFileNo" placeholder="File No." disabled="disabled">
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

                    <div class="form-group m-form__group row">
                        <p style="font-weight: bold;">Kindly check the form if all information is correct, before submitting.</p>
                    </div>

                    <div class="form-group m-form__group row">
                        <button type="button" class="btn btn-accent" id="btnReceive">RECEIVE</button>
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
           locationDropDown(); 

           getReasons(1);

            $('#btnEdit1').hide();
            $('.progress').hide();
            $('#btnReceive').prop("disabled", true);

            $('#btnReceive').click(function () {
                let confirmPrompt = confirm("Are you sure that you want to record the following information?");

                if (confirmPrompt == true) {
                    confirmInsertion();
                }
            });

            function receiveData(argId, argRefNo, argProdCd, argFileNo, argQty, argLastUser, argReasonId) {
                var request = new XMLHttpRequest();
                var data = JSON.stringify({ passId: argId, passRefNo: argRefNo, passProdCd: argProdCd, passFileNo: argFileNo, passQty: argQty, passLastUser: argLastUser, passReasonId: argReasonId });
                request.open('POST', 'ROISWebService.asmx/InsertReceivingData', true);
                request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

                request.onload = function () {
                    if (this.status >= 200 && this.status < 400) {
                        // Success!
                        swal("Success!", "Receiving Data Recorded", "success");
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

           function confirmInsertion() {
               var employee = sessionStorage.getItem("userId");

               let argId = $('#txtBarcode').val();
               let argRefNo = $("#txtRefNo").val();
               let argProdCd = $("#txtProdCode").val();
               let argFileNo = $("#txtFileNo").val();
               let argQty = $("#txtQty").val();
               let argReasonId = $("#selectReason").val();
               let argLastUser = employee;

               if (argReasonId > 0) {
                   receiveData(argId, argRefNo, argProdCd, argFileNo, argBundleNo, argQty, argLastUser, argReasonId);
               }
               else {
                   swal("Error", "Please select a reason for receiving issuance.", "error");
               }
               
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
                       swal("Scan Failed!", "Data already exists on inventory records. Please try again.", "error");
                       $('#btnReceive').prop("disabled", true);
                       clearForm();
                   }
                   else {
                       load_barcode_details(scanned_barcode, sessionStorage.getItem("userLocDesc"));
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
           document.getElementById("txtQty").value = 0;
           document.getElementById("selectReason").value = 0;
       }

       function load_barcode_details(scanned_barcode, userLocation) {
           var request = new XMLHttpRequest();
           var data = JSON.stringify({ scanned_barcode: scanned_barcode, userLoc: userLocation });
           request.open('POST', 'ROISWebService.asmx/GetPostedDetails', true);
           request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

           request.onload = function () {
               if (this.status >= 200 && this.status < 400) {
                   // Success!
                   var details = JSON.parse(this.responseText);

                   if (details.length != 0) {
                       document.getElementById("txtRefNo").value = details[0].DrNo;
                       document.getElementById("txtProdCode").value = details[0].ProdCode;
                       document.getElementById("txtFileNo").value = details[0].FileNumber;
                       document.getElementById("txtQty").value = details[0].Qty;
                       $('#btnReceive').prop("disabled", false);
                   } else {
                       swal("Scan Failed!", "Data does not exist from source records. Please try again.", "error");
                       $('#btnReceive').prop("disabled", true);
                   }
               } else {
                   // We reached our target server, but it returned an error
                   document.getElementById("txtRefNo").value = "";
                   document.getElementById("txtProdCode").value = "";
                   document.getElementById("txtFileNo").value = "";
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

<%@ Page Title="" Language="C#" MasterPageFile="~/Forms/Site.Master" AutoEventWireup="true" CodeBehind="ScanOutgoing.aspx.cs" Inherits="ROIS.Forms.ScanOutgoing" %>
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
                            <h3 class="m-portlet__head-text">Outgoing Issuance
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
                        <label for="example-bundleno-input" class="col-3 col-form-label">Bundle No.</label>
                        <div class="col-9">
                            <input type="text" class="form-control m-input" id="txtBundleNo" placeholder="Bundle No." disabled="disabled">
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <label for="example-qty-input" class="col-3 col-form-label">Current Qty.</label>
                        <div class="col-5">
                            <input type="number" class="form-control m-input" id="txtQty" disabled="disabled">
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <label for="example-qty-input" class="col-3 col-form-label">Qty. To Be Issued:</label>
                        <div class="col-5">
                            <input type="number" class="form-control m-input" id="txtQtyOut">
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
                        <button type="button" class="btn btn-accent" id="btnSend">SEND OUT</button>
                        <div class="col-5">
                        </div>
                    </div>
                </div>
            </div>

            <!--end::Portlet-->
        </div>

        <div class="col-md-6">

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
//import { to } from "../vendors/moment/src/lib/moment/to";
//import toInt from "../vendors/moment/src/lib/utils/to-int";

       $(document).ready(function () {
           locationDropDown();
           getReasons(2);

            $('#btnEdit1').hide();
            $('.progress').hide();
            var employee = sessionStorage.getItem("username");
            var loc = sessionStorage.getItem("location");
            $('#btnSend').prop("disabled", true);

            $('#txtBarcode').blur(function () {
                var varBarcodeTag = $('#txtBarcode').val();
                if (varBarcodeTag != '') {
                    scanBarcode(varBarcodeTag);
                    //check_barcode_if_exists(varBarcodeTag);
                }
            });

            $('#btnSend').click(function () {
                let confirmInsert = confirm("Are you sure that you want to record the following information?");

                if (confirmInsert == true) {
                    ConfirmInsert();
                }
            });

           function ConfirmInsert()
           {
               var employee = sessionStorage.getItem("userId");

               let argId = $('#txtBarcode').val();
               let argRefNo = $("#txtRefNo").val();
               let argProdCd = $("#txtProdCode").val();
               let argFileNo = $("#txtFileNo").val();
               let argLocId = $("#selectLocation").val();
               let argQty = $("#txtQtyOut").val();
               let argReasonId = $("#selectReason").val();

               let num1 = parseInt($("#txtQtyOut").val());
               let num2 = parseInt($("#txtQty").val());
               let argLastUser = employee;

               //if (argQty <= 0) {
               //    swal("Error", "You cannot enter a zero or negative quantity. Please try again.", "error");
               //}

               //if (num1 > num2) {
               //    swal("Error", "The product does not have enough stock.", "error");
               //}

               //if (argReasonId <= 0) {
               //    swal("Error", "Please select a reason for outgoing issuance", "error");
               //}

               if (argQty > 0 && num1 <= num2 && argReasonId != 0) {
                   outgoingData(argId, argRefNo, argProdCd, argFileNo, argLocId, argQty, argLastUser, argReasonId);
               }
               else {
                   swal("Error", "You have entered incomplete details. Please try again", "error");
               }

               clearForm();
           }

            //function check_barcode_if_exists(scanned_barcode) {
            //    var request = new XMLHttpRequest();
            //    var data = JSON.stringify({ scannedBarcode: scanned_barcode, transType: 2 });
            //    request.open('POST', 'ROISWebService.asmx/CheckIfBarcodeExists', true);
            //    request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

            //    request.onload = function () {
            //        if (this.status >= 200 && this.status < 400) {
            //            // Success!
            //            var result = JSON.parse(this.responseText);

            //            if (result > 0) {
            //                swal("Data already exists on records.");
            //                $('#btnSend').prop("disabled", true);
            //            }
            //            else {
            //                scanBarcode(scanned_barcode);
            //            }
            //        } else {
            //            // We reached our target server, but it returned an error
            //            console.log("Status Error");
            //        }
            //    };

            //    request.onerror = function () {
            //        //console.log(this.response);
            //        console.log("Request OnError");
            //    };

            //    request.send(data);
            //}

            function outgoingData(argId, argRefNo, argProdCd, argFileNo, argLocId, argQty, argLastUser, argReasonId) {
                var request = new XMLHttpRequest();
                var data = JSON.stringify({ passId: argId, passRefNo: argRefNo, passProdCd: argProdCd, passFileNo: argFileNo, passLocId: argLocId, passQty: argQty, passLastUser: argLastUser, passReasonId: argReasonId });
                request.open('POST', 'ROISWebService.asmx/InsertOutgoingData', true);
                request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

                request.onload = function () {
                    if (this.status >= 200 && this.status < 400) {
                        // Success!
                        swal("Success!", "Outgoing Data Recorded", "success");
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

            function clearForm() {
                document.getElementById("txtBarcode").value = "";
                document.getElementById("txtRefNo").value = "";
                document.getElementById("txtProdCode").value = "";
                document.getElementById("txtFileNo").value = "";
                document.getElementById("selectLocation").value = 0;
                document.getElementById("selectReason").value = 0;
                document.getElementById("txtBundleNo").value = "";
                document.getElementById("txtQty").value = 0;
                document.getElementById("txtQtyOut").value = 0;
                document.getElementById("btnSend").disabled = true;
            }

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

                //$('#modal_scan').modal('show');
            });

            Quagga.onDetected(function (result) {
                var code = result.codeResult.code;
                $('#txtBarcode').val(code);
                $('#modal_scan').modal('hide');
                let scannedBarcode = $('#txtBarcode').val();
                //check_barcode_if_exists(scannedBarcode);
                scanBarcode(scannedBarcode);
                Quagga.stop();
                console.log("Stop camera.");
            });

        });

       function locationDropDown() {
           let fromLocalStorage = JSON.parse(localStorage.getItem("outgoingDropdown"));
           let sel = document.getElementById("selectLocation");

           if (!fromLocalStorage) {
               $(location).attr('href', 'Home.aspx');
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

       function scanBarcode(scanned_barcode) {
           var request = new XMLHttpRequest();
           var data = JSON.stringify({ scanned_barcode: scanned_barcode });
           request.open('POST', 'ROISWebService.asmx/ScanOutgoing', true);
           request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

           request.onload = function () {
               if (this.status >= 200 && this.status < 400) {
                   // Success!
                   var subdetails = JSON.parse(this.responseText);

                   if (subdetails.length != 0) {
                       document.getElementById("txtRefNo").value = subdetails[0].referenceno;
                       document.getElementById("txtProdCode").value = subdetails[0].prodcode;
                       document.getElementById("txtFileNo").value = subdetails[0].filenumber;
                       document.getElementById("txtBundleNo").value = subdetails[0].bundlenumber;
                       //document.getElementById("txtLocID").value = subdetails[0].locationcode;
                       document.getElementById("txtQty").value = subdetails[0].quantity;
                       $('#btnSend').prop("disabled", false);

                   } else {
                       swal("Scan Failed!", "Data does not exist from source records. Please try again.", "error");
                       $('#btnSend').prop("disabled", true);
                       clearForm();
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
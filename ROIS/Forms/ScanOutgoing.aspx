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
                            <%--<input type="text" class="form-control form-co-lg m-input m--icon-font-size-sm2 align-items-lg-start" id="txtSWIV" placeholder="Scan SWIV" />--%>
                            <%--<asp:TextBox ID="txtSWIV"  class="form-control form-co-lg m-input m--icon-font-size-sm2 align-items-lg-start" placeholder="Scan SWIV" AutoPostBack="true" ></asp:TextBox>--%>
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
                        <label for="example-qty-input" class="col-3 col-form-label">Tonnage:</label>
                        <div class="col-5">
                            <input type="number" class="form-control m-input" id="txtTonnage">
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <button type="button" class=" col-3 btn btn-accent" id="btnSend">SEND OUT</button>
                        <div class="col-5">
                        </div>
                    </div>

                </div>
            </div>

            <!--end::Portlet-->
        </div>

        <div class="col-md-6">

            <!--begin::Portlet-->
            <div class="m-portlet m-portlet--tab" style="visibility: hidden;">
                <div class="m-portlet__head">
                    <div class="m-portlet__head-caption">
                        <div class="m-portlet__head-title">

                            <h3 class="m-portlet__head-text m--align-center">Capture Image
                            </h3>

                        </div>
                    </div>
                </div>

                <div class="m-portlet__body font">
                    <form id="form1">
                        <div class="form-group m-form__group row">

                            <input type="file" name="customFile" id="customFile" />

                            <input class="btn btn-primary btn-block" type="button" id="btnUpload" name="btnUpload" value="Upload" />
                        </div>
                        <div class="form-group m-form__group row">

                            <%--<progress id="fileProgress" style="display: none" class="progress-bar progress-bar-striped progress-bar-animated " aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></progress>--%>
                        </div>
                        <div class="m-section__content">
                            <div class="progress">
                                <div class="progress-bar progress-bar-striped progress-bar-animated bg-success" role="progressbar" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                        <div class="form-group m-form__group row">
                            <span id="lblMessage" style="color: Green"></span>
                        </div>
                    </form>

                    <div class="form-group m-form__group row">

                        <div id="thumb-output"></div>
                    </div>
                    <div class="form-group m-form__group row">
                        <button class="btn btn-primary btn-block" id="btnViewImage">View Images</button>

                    </div>
                </div>
            </div>
            <!--end::Portlet-->

        </div>

    </div>


    <!--begin::Modal-->
    <div class="modal fade" id="m_modal_5" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Image Viewer</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <%--        <div class="form-group m-form__group row">--%>
                    <div class="popup-gallery">
                        <div class="popup-gallery" id="lightb">
                        </div>
                    </div>
                    <%--</div>--%>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!--end::Modal-->

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
                    <%--      <div class="controls">
                        <fieldset class="input-group">
                            <button class="stop">Stop</button>
                        </fieldset>
                        <fieldset class="reader-config-group">
                            <label>
                                <span>Barcode-Type</span>
                                <select name="decoder_readers">
                                    <option value="code_128" selected="selected">Code 128</option>
                                    <option value="code_39">Code 39</option>
                                    <option value="code_39_vin">Code 39 VIN</option>
                                    <option value="ean">EAN</option>
                                    <option value="ean_extended">EAN-extended</option>
                                    <option value="ean_8">EAN-8</option>
                                    <option value="upc">UPC</option>
                                    <option value="upc_e">UPC-E</option>
                                    <option value="codabar">Codabar</option>
                                    <option value="i2of5">Interleaved 2 of 5</option>
                                    <option value="2of5">Standard 2 of 5</option>
                                    <option value="code_93">Code 93</option>
                                </select>
                            </label>
                            <label>
                                <span>Resolution (width)</span>
                                <select name="input-stream_constraints">
                                    <option selected="selected" value="320x240">320px</option>
    
                                   <option value="640x480">640px</option>
                                    <option value="800x600">800px</option>
                                    <option value="1280x720">1280px</option>
                                    <option value="1600x960">1600px</option>
                                    <option value="1920x1080">1920px</option>
                                </select>
                            </label>
                            <label>
                                <span>Patch-Size</span>
                                <select name="locator_patch-size">
                                    <option value="x-small">x-small</option>
                                    <option value="small">small</option>
                                    <option selected="selected" value="medium">medium</option>
                                    <option value="large">large</option>
                                    <option value="x-large">x-large</option>
                                </select>
                            </label>
                            <label>
                                <span>Half-Sample</span>
                                <input type="checkbox" checked="checked" name="locator_half-sample" />
                            </label>
                            <label>
                                <span>Workers</span>
                                <select name="numOfWorkers">
                                    <option value="0">0</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option selected="selected" value="4">4</option>
                                    <option value="8">8</option>
                                </select>
                            </label>
                            <label>
                                <span>Camera</span>
                                <select name="input-stream_constraints" id="deviceSelection">
                                </select>
                            </label>
                            <label style="display: none">
                                <span>Zoom</span>
                                <select name="settings_zoom"></select>
                            </label>
                            <label style="display: none">
                                <span>Torch</span>
                                <input type="checkbox" name="settings_torch" />
                            </label>
                       </fieldset>
                    </div>
                    <div id="result_strip">
                        <ul class="thumbnails"></ul>
                        <ul class="collector"></ul>
                    </div>--%>
                    <div id="interactive" class="viewport"></div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>


            </div>
        </div>
    </div>

    <!--end::Modal-->

    <!--begin::Modal-->
    <div class="modal fade" id="m_modal_6" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel2" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel2">Truck Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <div class="form-group m-form__group row">
                        <label for="example-radiation-input" class="col-3 col-form-label">Radiation</label>
                        <div class="col-9">
                            <input type="text" class="form-control m-input" id="txtRadiation3" placeholder="WNVicinity">
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <label for="example-radiation-input" class="col-3 col-form-label"></label>
                        <div class="col-9">
                            <input type="text" class="form-control m-input" id="txtRadiation4" placeholder="WNTruck">
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <label for="example-density-input" class="col-3 col-form-label">Density</label>
                        <div class="col-9">
                            <input type="text" class="form-control m-input" id="txtDensity2" placeholder="Density" disabled="disabled">
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <label for="example-length-input" class="col-3 col-form-label">Length</label>
                        <div class="col-9">
                            <input type="number" class="form-control m-input" id="txtLength2" placeholder="Length">
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <label for="example-width-input" class="col-3 col-form-label">Width</label>
                        <div class="col-9">
                            <input type="number" class="form-control m-input" id="txtWidth2" placeholder="Width">
                        </div>
                    </div>

                    <div class="form-group m-form__group row">
                        <label for="example-height-input" class="col-3 col-form-label">Height</label>
                        <div class="col-9">
                            <input type="number" class="form-control m-input" id="txtHeight2" placeholder="Height">
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <%--<button type="button" class="btn btn-danger" id="btnDelete">Delete</button>--%>
                        <button type="button" class="btn btn-primary" id="btnSaveTruckDetails">Save</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--end::Modal-->

   <script>
        $(document).ready(function () {
            $('#btnEdit1').hide();
            $('.progress').hide();
            var employee = sessionStorage.getItem("username");
            var loc = sessionStorage.getItem("location");

            $('#txtBarcode').blur(function () {
                var varBarcodeTag = $('#txtBarcode').val();
                if (varBarcodeTag != '') {
                    scanBarcode(varBarcodeTag);
                }
            });

            function outgoingData(argId, argRefNo, argProdCd, argFileNo, argBundleNo, argQty, argTonnage,argLastUser) {
                var request = new XMLHttpRequest();
                var data = JSON.stringify({ passId: argId, passRefNo: argRefNo, passProdCd: argProdCd, passFileNo: argFileNo, passBundleNo: argBundleNo, passQty: argQty, passTonnage: argTonnage, passLastUser: argLastUser });
                request.open('POST', 'ROISWebService.asmx/InsertReceivingData', true);
                request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

                request.onload = function () {
                    if (this.status >= 200 && this.status < 400) {
                        // Success!
                        swal("Receiving Data Saved");
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
                $('#txtSWIV').val(code);
                $('#modal_scan').modal('hide');
                load_ITRLT_posted_subdetails($('#txtBarcode').val());
                Quagga.stop();
                console.log("Stop camera.");
            });

        });

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

                   } else {
                       document.getElementById("txtRefNo").value = "";
                       document.getElementById("txtProdCode").value = "";
                       document.getElementById("txtFileNo").value = "";
                       document.getElementById("txtBundleNo").value = "";
                       document.getElementById("txtLocID").value = "";
                       document.getElementById("txtQty").value = 0;

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


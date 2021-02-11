<%@ Page Title="" Language="C#" MasterPageFile="~/Forms/Site.Master" AutoEventWireup="true" CodeBehind="Mill_Inventory.aspx.cs" Inherits="ROIS.Forms.Mill_Inventory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="m-portlet m-portlet--mobile">
        <div class="m-portlet__head">
            <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                    <h3 class="m-portlet__head-text">Mill Inventory (For Outgoing)</h3>
                </div>
            </div>
            <div class="m-portlet__head-tools">
                <ul class="m-portlet__nav">
                    <li class="m-portlet__nav-item">
                        <button type="button" class="btn btn-accent" id="btnModal" style="visibility: hidden;">Insert PO</button>
                    </li>
                </ul>
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
                                    <th>Ref No.</th>
                                    <th>Product Code</th>
                                    <th>Product Code</th>
                                    <th>Location ID</th>
                                    <th>File No.</th>
                                    <th>Bundle No.</th>
                                    <th>Qty.</th>
                                    <th>Total Weight</th>
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
    <div class="modal fade" id="m_modal_5" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">CVAL Local Entry</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="txtPONo" class="form-control-label">PO No:</label>
                            <input type="text" class="form-control" id="txtPONo" />
                        </div>
                        <div class="form-group">
                            <label for="txtCVAN" class="form-control-label">CVAN:</label>
                            <textarea class="form-control" id="txtCVAN"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="txtSealNo" class="form-control-label">Seal No:</label>
                            <textarea class="form-control" id="txtSealNo"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="txtWeight" class="form-control-label">Weight:</label>
                             <input type="number" class="form-control form-control-lg m-input" id="txtWeight" name="txtWeight" placeholder="0" value="0">
                        </div>
                        <div class="form-group">
                            <label for="txtBLNo" class="form-control-label">Bill of Ladding:</label>
                            <textarea class="form-control" id="txtBLNo"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="txtBLDate" class="form-control-label">BL Date:</label>
                            <textarea class="form-control" id="txtBLDate"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="txtForwarder" class="form-control-label">Forwarder:</label>
                            <textarea class="form-control" id="txtForwarder"></textarea>
                        </div>

                    </form>

                </div>
                <div class="modal-footer">
                    <%--       <a href="#" class="btn btn-warning m-btn m-btn--custom m-btn--icon">
                        <span>
                            <i class="fa fa-arrow-alt-circle-up"></i>
                            <span>Move Up</span>
                        </span>
                    </a>--%>

                    <div class="row">
                        <button type="button" class="btn btn-primary" id="btnSave">Save</button>
                        <%--<button type="button" class="btn btn-danger" id="btnDelete">Delete</button>--%>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!--end::Modal-->

<script>
    $(document).ready(function () {
        loadGrid();

        function loadGrid() {
            $.ajax({
                url: 'ROISWebService.asmx/GenerateInventoryDt',
                method: 'post',
                contentType: "application/json; charset=utf-8",
                dataType: 'json',
                success: function (data) {
                    $('#dgrid').dataTable({
                        responsive: true,
                        data: data,
                        bDestroy: true,
                        columns: [
                            { 'data': 'RefNo' },
                            { 'data': 'ProdCode' },
                            { 'data': 'LocationId' },
                            { 'data': 'FileNo' },
                            { 'data': 'BundleNo' },
                            { 'data': 'Qty' },
                            { 'data': 'TotalWeight' }
                        ],

                        order: [[0, "asc"]],

                    });
                    //$('#m_table_1').show();
                    //$('#waitmeload').hide();
                } // end success

            }); //end loadGrid
        }

        $('#btnModal').click(function () {
            $('#m_modal_5').modal('show');
            $('#txtPONo').val('');
            $('#txtCVAN').val('');
            $('#txtSealNo').val('');
            $('#txtWeight').val('');
            $('#txtBLNo').val('');
            $('#txtBLDte').val('');
            $('#txtForwarder').val('');
        });

        function insertPO(pono, cvan, sealno, weight, bl, bldate, forwarder) {
            $.ajax({
                url: 'tqs_webservice.asmx/set_cvan_local',
                method: 'post',
                contentType: "application/json; charset=utf-8",
                dataType: 'json',
                data: JSON.stringify({ pono:pono, cvan:cvan, sealno:sealno, weight:weight, bl:bl, bldate:bldate, forwarder:forwarder }),
                success: function (data) {
                    //alert(msg);
                    console.log(data);

                    swal("Save!", "This PO number was successfully saved.", "success");
                    insert_logs('TQS', 'CVAN Import Local', 'Successully inserted PO.', '');
                    $('#m_modal_5').modal('hide');

                    loadGrid();
                    //}
                },
                Error: function (data) {
                    // notif_withtxt('Info', 'Error Please check your data', 'info', 'swing');
                }
            });


        }

        $('#btnSave').click(function () {

            //swal("Warning!", "This plate number is already encoded.", "error");

            var ponumber = $('#txtPONo').val();
            var cvanno = $('#txtCVAN').val();
            var seal = $('#txtSealNo').val();
            var weight = $('#txtWeight').val();
            var blno = $('#txtBLNo').val();
            var bldate = $('#txtBLDate').val();
            var forwarder = $('#txtForwarder').val();
            //console.log("PO :" + ponumber + " CVAN :" + cvanno);

            if (ponumber.trim() === "" || cvanno.trim() === "") {
                swal("Warning!", "Invalid input. Please enter pono no and cvan.", "error");
            }
            else {
                insertPO(ponumber,cvanno,seal,weight,blno,bldate,forwarder);
            }

        });


         function insert_logs(transid, module, form, action) {
                $.ajax({
                    url: 'tqs_webservice.asmx/set_logs',
                    method: 'post',
                    contentType: "application/json; charset=utf-8",
                    dataType: 'json',
                    data: JSON.stringify({ transid: transid, module: module, form: form, action: action, ip: sessionStorage.getItem("ipaddress") }),
                    success: function (data) {
                        //alert(msg);
                        //console.log(data);
                        //swal("Save!", "Transaction has been saved.", "success");
                        //loadSWIV($('#txtSWIV').val());
                        //$('#m_modal_5').modal('hide');

                        //}
                    },
                    Error: function (data) {
                        // notif_withtxt('Info', 'Error Please check your data', 'info', 'swing');
                        //swal("Not Save!", "Error saving.", "warning");
                    }
                });
            }

    });
</script>

</asp:Content>

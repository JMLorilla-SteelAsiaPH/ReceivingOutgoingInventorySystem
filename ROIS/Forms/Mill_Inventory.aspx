<%@ Page Title="" Language="C#" MasterPageFile="~/Forms/Site.Master" AutoEventWireup="true" CodeBehind="Mill_Inventory.aspx.cs" Inherits="ROIS.Forms.Mill_Inventory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="m-portlet m-portlet--mobile">
        <div class="m-portlet__head">
            <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                    <h3 class="m-portlet__head-text">Mill Inventory Summary(For Outgoing)</h3>
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
                                    <th>Product Code</th>
                                    <th>Location</th>
                                    <th>Qty.</th>
                                    <th>Weight</th>
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

<script>
    $(document).ready(function () {
        loadGrid();

        function loadGrid() {
            $.ajax({
                url: 'ROISWebService.asmx/GenerateInventorySummaryDt',
                method: 'post',
                contentType: "application/json; charset=utf-8",
                dataType: 'json',
                success: function (data) {
                    $('#dgrid').dataTable({
                        responsive: true,
                        data: data,
                        bDestroy: true,
                        columns: [
                            { 'data': 'prod_code' },
                            { 'data': 'location' },
                            { 'data': 'quantity' },
                            { 'data': 'weight' }
                        ],

                        order: [[0, "asc"]],

                    });
                    //$('#m_table_1').show();
                    //$('#waitmeload').hide();
                } // end success

            }); //end loadGrid
        }

    });
</script>

</asp:Content>

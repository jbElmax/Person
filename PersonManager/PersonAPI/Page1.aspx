<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Page1.aspx.cs" Inherits="PersonAPI.WebForm1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"/>
    <!-- Bootstrap Font Icon CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"/>
</head>

<body>
    <h1>Manage Person</h1>
    <form id="form1" runat="server">
        <div>

            <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
            <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
                <script>

                    var updatedIDs = [], deletedIDs = [];

                    function requestStart(sender, args) {
                        var type = args.get_type();
                        var transport = sender.get_dataSourceObject().options.transport;
                        switch (type) {
                            case "read":
                                var textBox = $find('<%= RadNumericTextBox1.ClientID %>');
                                var value = textBox.get_value();
                                transport.read.url = "api/person/" + value;
                                break;

                            case "create":
                                transport.create.url = "api/person/";
                                break;

                            case "update":
                                transport.update.url = "api/person/" + updatedIDs.shift();
                                break;

                            case "destroy":
                                transport.destroy.url = "api/person/" + deletedIDs.shift();
                                break;

                            default: break;
                        }

                    }
                    function btnFilterHandler(sender, args) {
                        var grid = $find('<%= RadGrid1.ClientID %>');
                        grid.get_masterTableView().rebind();
                    }

                    function dataSourceCommand(sender, args) {
                        var commandName = args.get_commandName();
                        var id = args.get_commandArgument().id;
                        switch (commandName) {
                            case "update":
                                updatedIDs.push(id);
                                break;
                            case "remove":
                                deletedIDs.push(id);
                                break;
                            default:

                                break;
                        }

                    }

                    function popUp(id) {

                        var url = "Page2.aspx?id=" + id;
                        var windowFeatures = "width=600,height=600,scrollbars=yes,resizable=yes";

                        window.open(url, "_blank", windowFeatures);
                    }

                    function handleButtonClick(event) {
                        event.preventDefault();
                        var button = event.target;
                        var row = button.closest("tr");
                        var firstCell = row.cells[0];
                        var id = firstCell.textContent;

                        popUp(id);

                    }


                </script>

            </telerik:RadCodeBlock>
            <telerik:RadNumericTextBox runat="server" ID="RadNumericTextBox1" Label="Filter by ID: " LabelWidth="65px"></telerik:RadNumericTextBox>
            <telerik:RadButton AutoPostBack="false" runat="server" ID="RadButton1" Text="Filter" OnClientClicked="btnFilterHandler"></telerik:RadButton>
            <br />
            <br />
            <telerik:RadGrid AllowFilteringByColumn="true" AllowSorting="true" AllowPaging="true" runat="server" ID="RadGrid1" AutoGenerateColumns="false"
                ClientDataSourceID="RadClientDataSource1">
                <MasterTableView EditMode="Batch" CommandItemDisplay="Top" ClientDataKeyNames="Id" AllowFilteringByColumn="false" AllowSorting="true">
                    <Columns>
                        <telerik:GridBoundColumn UniqueName="Id" DataField="Id" HeaderText="ID" ReadOnly="true" />
                        <telerik:GridBoundColumn UniqueName="Name" DataField="Name" HeaderText="Name" />
                        <telerik:GridBoundColumn UniqueName="Age" DataField="Age" HeaderText="Age" />
                        <telerik:GridTemplateColumn UniqueName="PersonTypeDesc" HeaderText="Type">
                            <ClientItemTemplate>
                                <span>#=PersonTypeDesc #</span>
                            </ClientItemTemplate>
                            <EditItemTemplate>
                            <telerik:RadDropDownList runat="server" ID="CategoryIDDropDown">
                                <Items>
                                    <telerik:DropDownListItem Text="Teacher" Value="Teacher" />
                                    <telerik:DropDownListItem Text="Student" Value="Student" />
   
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" Reorderable="False" ShowSortIcon="False"><HeaderStyle ForeColor="DimGray" Width="20px" />       
                        <ItemStyle HorizontalAlign="Center"/>
                        </telerik:GridEditCommandColumn>
                        <telerik:GridClientDeleteColumn HeaderText="Actions" ButtonType="ImageButton" HeaderStyle-Width="70px">
                        </telerik:GridClientDeleteColumn>
                        <telerik:GridTemplateColumn>
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="lbFoo" OnClientClick="handleButtonClick(event)" CssClass="btn btn-default">
                                <i class="bi bi-clipboard-data" aria-hidden="true"></i>
                            </asp:LinkButton>

                        </ItemTemplate>
                        </telerik:GridTemplateColumn>

                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <telerik:RadClientDataSource runat="server" ID="RadClientDataSource1">
       
                <ClientEvents OnCommand="dataSourceCommand" OnRequestStart="requestStart"/>

                <DataSource>
                    <WebServiceDataSourceSettings>
                        <Select Url="api/person" RequestType="Get" />
                        <Insert Url="api/person" RequestType="Post" />
                        <Update Url="api/person" RequestType="Put" />
                        <Delete Url="api/person" RequestType="Delete" />
                    </WebServiceDataSourceSettings>
                </DataSource>
                <Schema>
                    <Model ID="Id">
                        <telerik:ClientDataSourceModelField FieldName="Id" DataType="Number" />
                        <telerik:ClientDataSourceModelField FieldName="Name" DataType="String" />
                        <telerik:ClientDataSourceModelField FieldName="Age" DataType="Number" />
                        <telerik:ClientDataSourceModelField FieldName="PersonTypeDesc" DataType="String" />
                    </Model>
                </Schema>
            </telerik:RadClientDataSource>

        </div>
    </form>

</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Formulario1.aspx.cs" Inherits="EjemploListView.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <asp:Button ID="btnOrdenar" runat="server" OnClick="btnOrdenar_Click" Text="Ordenar por nombre" />
            <asp:SqlDataSource ID="SqlDataSourceEmpresa" runat="server" ConnectionString="<%$ ConnectionStrings:EmpresaConnectionString %>" ProviderName="<%$ ConnectionStrings:EmpresaConnectionString.ProviderName %>" SelectCommand="SELECT [Dni], [Nombre], [Apellido], [Edad], [Sexo], [ImagenURL] FROM [Personas]"></asp:SqlDataSource>
            <asp:ListView ID="ListViewEmpresa" runat="server" DataKeyNames="Dni" DataSourceID="SqlDataSourceEmpresa" GroupItemCount="3">
 <%--               <AlternatingItemTemplate>
                    <td runat="server" style="background-color:#FFF8DC;">Dni:
                        <asp:Label ID="DniLabel" runat="server" Text='<%# Eval("Dni") %>' />
                        <br />Nombre:
                        <asp:Label ID="NombreLabel" runat="server" Text='<%# Eval("Nombre") %>' />
                        <br />Apellido:
                        <asp:Label ID="ApellidoLabel" runat="server" Text='<%# Eval("Apellido") %>' />
                        <br />Edad:
                        <asp:Label ID="EdadLabel" runat="server" Text='<%# Eval("Edad") %>' />
                        <br />Sexo:
                        <asp:Label ID="SexoLabel" runat="server" Text='<%# Eval("Sexo") %>' />
                        <br />ImagenURL:
                        <asp:Label ID="ImagenURLLabel" runat="server" Text='<%# Eval("ImagenURL") %>' />
                        <br /></td>
                </AlternatingItemTemplate>--%>
                <EditItemTemplate>
                    <td runat="server" style="background-color:#008A8C;color: #FFFFFF;">Dni:
                        <asp:Label ID="DniLabel1" runat="server" Text='<%# Eval("Dni") %>' />
                        <br />Nombre:
                        <asp:TextBox ID="NombreTextBox" runat="server" Text='<%# Bind("Nombre") %>' />
                        <br />Apellido:
                        <asp:TextBox ID="ApellidoTextBox" runat="server" Text='<%# Bind("Apellido") %>' />
                        <br />Edad:
                        <asp:TextBox ID="EdadTextBox" runat="server" Text='<%# Bind("Edad") %>' />
                        <br />Sexo:
                        <asp:TextBox ID="SexoTextBox" runat="server" Text='<%# Bind("Sexo") %>' />
                        <br />ImagenURL:
                        <asp:TextBox ID="ImagenURLTextBox" runat="server" Text='<%# Bind("ImagenURL") %>' />
                        <br />
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                        <br />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                        <br /></td>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <EmptyItemTemplate>
<td runat="server" />
                </EmptyItemTemplate>
                <GroupTemplate>
                    <tr id="itemPlaceholderContainer" runat="server">
                        <td id="itemPlaceholder" runat="server"></td>
                    </tr>
                </GroupTemplate>
                <InsertItemTemplate>
                    <td runat="server" style="">Dni:
                        <asp:TextBox ID="DniTextBox" runat="server" Text='<%# Bind("Dni") %>' />
                        <br />Nombre:
                        <asp:TextBox ID="NombreTextBox" runat="server" Text='<%# Bind("Nombre") %>' />
                        <br />Apellido:
                        <asp:TextBox ID="ApellidoTextBox" runat="server" Text='<%# Bind("Apellido") %>' />
                        <br />Edad:
                        <asp:TextBox ID="EdadTextBox" runat="server" Text='<%# Bind("Edad") %>' />
                        <br />Sexo:
                        <asp:TextBox ID="SexoTextBox" runat="server" Text='<%# Bind("Sexo") %>' />
                        <br />ImagenURL:
                        <asp:TextBox ID="ImagenURLTextBox" runat="server" Text='<%# Bind("ImagenURL") %>' />
                        <br />
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                        <br />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                        <br /></td>
                </InsertItemTemplate>
                <ItemTemplate>
                    <td runat="server" style="background-color:#DCDCDC;color: #000000;">Dni:
                        <asp:Label ID="DniLabel" runat="server" Text='<%# Eval("Dni") %>' />
                        <br />Nombre:
                        <asp:Label ID="NombreLabel" runat="server" Text='<%# Eval("Nombre") %>' />
                        <br />Apellido:
                        <asp:Label ID="ApellidoLabel" runat="server" Text='<%# Eval("Apellido") %>' />
                        <br />Edad:
                        <asp:Label ID="EdadLabel" runat="server" Text='<%# Eval("Edad") %>' />
                        <br />Sexo:
                        <asp:Label ID="SexoLabel" runat="server" Text='<%# Eval("Sexo") %>' />
                        <br />Imagen:
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("ImagenURL") %>' />
                        <br />
                        <br />
                        <br />
                        <asp:Button ID="BtnSeleccionar" runat="server" CommandArgument='<%# Eval("Nombre")  + "-" + Eval("Apellido") %>' CommandName="eventoSeleccionar" OnCommand="BtnSeleccionar_Command" Text="Seleccionar" />
                        <br />
                        <br />
                        <asp:CheckBox ID="CheckBoxEmpresa" runat="server" />
                        <br /></td>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table id="groupPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                    <tr id="groupPlaceholder" runat="server">
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;">
                                <asp:DataPager ID="DataPager1" runat="server" PageSize="4">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                                    </Fields>
                                </asp:DataPager>
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <td runat="server" style="background-color:#008A8C;font-weight: bold;color: #FFFFFF;">Dni:
                        <asp:Label ID="DniLabel" runat="server" Text='<%# Eval("Dni") %>' />
                        <br />Nombre:
                        <asp:Label ID="NombreLabel" runat="server" Text='<%# Eval("Nombre") %>' />
                        <br />Apellido:
                        <asp:Label ID="ApellidoLabel" runat="server" Text='<%# Eval("Apellido") %>' />
                        <br />Edad:
                        <asp:Label ID="EdadLabel" runat="server" Text='<%# Eval("Edad") %>' />
                        <br />Sexo:
                        <asp:Label ID="SexoLabel" runat="server" Text='<%# Eval("Sexo") %>' />
                        <br />ImagenURL:
                        <asp:Label ID="ImagenURLLabel" runat="server" Text='<%# Eval("ImagenURL") %>' />
                        <br /></td>
                </SelectedItemTemplate>
            </asp:ListView>
            <br />
            <asp:Button ID="btnMostrarSeleccionado" runat="server" OnClick="btnMostrarSeleccionado_Click" Text="MostrarSeleccionado" />
            <br />
            <br />
            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>

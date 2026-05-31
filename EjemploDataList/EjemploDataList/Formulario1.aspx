<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Formulario1.aspx.cs" Inherits="EjemploDataList.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DataList ID="DataList_Empresa" runat="server" DataKeyField="Dni" DataSourceID="SqlDataSourceEmpresa">
                <ItemTemplate>
                    <asp:Button ID="btnPersonas" runat="server" CommandArgument='<%# Eval("Nombre") + " " + Eval("Apellido") + " " + Eval("Dni") %>' CommandName="eventoBoton" OnCommand="btnPersonas_Command" Text='<%# Eval("Nombre") + " " + Eval("Apellido") %>' />
                    <br />
                    <br />
                </ItemTemplate>
            </asp:DataList>

            <br />
            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
            <br />

            <asp:SqlDataSource ID="SqlDataSourceEmpresa" runat="server" ConnectionString="<%$ ConnectionStrings:EmpresaConnectionString %>" ProviderName="<%$ ConnectionStrings:EmpresaConnectionString.ProviderName %>" SelectCommand="SELECT [Dni], [Nombre], [Apellido], [Edad], [Sexo], [ImagenURL] FROM [Personas]"></asp:SqlDataSource>
            <br />
        </div>
        
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SeleccionarSucursales.aspx.cs" Inherits="TP7_Grupo7.SeleccionarSucursales" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="StyleSheet1.css" rel="stylesheet" />
</head>
<body class="body-seleccionar">
    <form id="form1" runat="server">
        <div class="contenedor-wide">
            <div class="nav-bar">
                <asp:HyperLink ID="hl_ListadoSucursales" runat="server" NavigateUrl="~/SeleccionarSucursales.aspx" CssClass="nav-link">Listado de sucursales</asp:HyperLink>
                <asp:HyperLink ID="hl_MostrarSucSelec" runat="server" NavigateUrl="~/ListadoSucursalesSeleccionados.aspx" CssClass="nav-link">Mostrar sucursales seleccionadas</asp:HyperLink>
            </div>

            <h2 class="titulo-seccion">Listado de sucursales</h2>

            <div class="barra-busqueda">
                <asp:Label ID="lbl_Busqueda" runat="server" Text="Búsqueda por nombre: " CssClass="lbl-campo"></asp:Label>
                <asp:TextBox ID="txtBox_Buscar" runat="server" CssClass="input-campo" Width="280px"></asp:TextBox>
                <asp:Button ID="btn_Buscar" runat="server" Text="Buscar" CausesValidation="False" OnClick="btn_Buscar_Click" CssClass="btn-principal" />
                <asp:Button ID="limpiar" runat="server" OnClick="limpiar_Click" Text="Limpiar" CssClass="btn-secundario" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtBox_Buscar" SetFocusOnError="True" ValidationGroup="VG_Buscar" CssClass="validador">* complete el campo</asp:RequiredFieldValidator>
            </div>

            <asp:Panel ID="Pan_Detalle" runat="server" CssClass="panel-detalle">
                <asp:Label ID="lbl_Suc_de" runat="server" CssClass="lbl-detalle"></asp:Label>
                <br />
                <asp:Label ID="Lbl_direccion_de" runat="server" CssClass="lbl-detalle"></asp:Label>
                <br />
                <asp:Label ID="Lbl_Horario_De" runat="server" CssClass="lbl-detalle"></asp:Label>
                <br />
                <asp:Button ID="pan_butt_ocu" runat="server" OnClick="pan_butt_ocu_Click" Text="Ocultar" CssClass="btn-secundario" />
            </asp:Panel>

            <div class="layout-principal">
                <div class="panel-provincias">
                    <asp:Label ID="lblProvinciaSeleccionada" runat="server" Font-Bold="True" CssClass="lbl-provincia" Text="Mostrando: Todas las sucursales"></asp:Label>
                    <br />
                    <asp:DataList ID="dlProvincias" runat="server" CssClass="datalist-provincias" OnItemCommand="dlProvincias_ItemCommand">
                        <ItemTemplate>
                            <asp:Button ID="btnProvincia" runat="server" Text='<%# Eval("DescripcionProvincia") %>' CssClass="btn-provincia" CommandArgument='<%# Eval("Id_Provincia") %>' CommandName="filtrarProvincia" />
                        </ItemTemplate>
                    </asp:DataList>
                </div>

                <div class="panel-listview">
                    <asp:ListView ID="lv_Sucursales" runat="server" DataSourceID="SqlDataSource1" GroupItemCount="3" DataKeyNames="Id_Sucursal">
                        <%--<AlternatingItemTemplate>...</AlternatingItemTemplate>--%>
                        <EditItemTemplate>
                            <td runat="server" style="background-color:#c46a8a;color:#ffffff;">DescripcionSucursal:
                                <asp:TextBox ID="DescripcionSucursalTextBox" runat="server" Text='<%# Bind("DescripcionSucursal") %>' CssClass="input-campo" />
                                <br />NombreSucursal:
                                <asp:TextBox ID="NombreSucursalTextBox" runat="server" Text='<%# Bind("NombreSucursal") %>' CssClass="input-campo" />
                                <br />URL_Imagen_Sucursal:
                                <asp:TextBox ID="URL_Imagen_SucursalTextBox" runat="server" Text='<%# Bind("URL_Imagen_Sucursal") %>' CssClass="input-campo" />
                                <br />Id_Sucursal:
                                <asp:Label ID="Id_SucursalLabel1" runat="server" Text='<%# Eval("Id_Sucursal") %>' />
                                <br />
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar" CssClass="btn-principal" />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" CssClass="btn-secundario" />
                            </td>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <table runat="server">
                                <tr><td class="lbl-mensaje">No se han devuelto datos.</td></tr>
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
                            <td runat="server">DescripcionSucursal:
                                <asp:TextBox ID="DescripcionSucursalTextBox" runat="server" Text='<%# Bind("DescripcionSucursal") %>' CssClass="input-campo" />
                                <br />NombreSucursal:
                                <asp:TextBox ID="NombreSucursalTextBox" runat="server" Text='<%# Bind("NombreSucursal") %>' CssClass="input-campo" />
                                <br />URL_Imagen_Sucursal:
                                <asp:TextBox ID="URL_Imagen_SucursalTextBox" runat="server" Text='<%# Bind("URL_Imagen_Sucursal") %>' CssClass="input-campo" />
                                <br />
                                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar" CssClass="btn-principal" />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Borrar" CssClass="btn-secundario" />
                            </td>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <td runat="server" class="item-sucursal">
                                <asp:Label ID="NombreSucursalLabel" runat="server" Text='<%# Eval("NombreSucursal") %>' CssClass="nombre-sucursal" />
                                <br />
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("URL_Imagen_Sucursal") %>' CssClass="img-sucursal" />
                                <br />
                                <asp:Label ID="DescripcionSucursalLabel" runat="server" Text='<%# Eval("DescripcionSucursal") %>' CssClass="desc-sucursal" />
                                <br /><br />
                                <asp:Button ID="btnSeleccionar" runat="server" CommandArgument='<%# Eval("Id_Sucursal") + "|" + Eval("NombreSucursal") + "|" + Eval("DescripcionSucursal") %>' CommandName="eventoSeleccionar" Text="Seleccionar" OnCommand="btnSeleccionar_Command1" CssClass="btn-principal" />
                                <asp:Button ID="but_Detalles" runat="server" CommandArgument='<%# Eval("Id_Sucursal") %>' CommandName="Detalles" OnCommand="Button1_Command" Text="Ver detalles" CssClass="btn-secundario" />
                            </td>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server">
                                <tr runat="server">
                                    <td runat="server">
                                        <table id="groupPlaceholderContainer" runat="server" class="tabla-listview">
                                            <tr id="groupPlaceholder" runat="server"></tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server" class="pager-bar">
                                        <asp:DataPager ID="DataPager1" runat="server" PageSize="6">
                                            <Fields>
                                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                                <asp:NumericPagerField />
                                                <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                            </Fields>
                                        </asp:DataPager>
                                    </td>
                                </tr>
                            </table>
                        </LayoutTemplate>
                        <SelectedItemTemplate>
                            <td runat="server" style="background-color:#c46a8a;font-weight:bold;color:#ffffff;">
                                <asp:Label ID="DescripcionSucursalLabel" runat="server" Text='<%# Eval("DescripcionSucursal") %>' />
                                <br />
                                <asp:Label ID="NombreSucursalLabel" runat="server" Text='<%# Eval("NombreSucursal") %>' />
                                <br />
                                <asp:Label ID="URL_Imagen_SucursalLabel" runat="server" Text='<%# Eval("URL_Imagen_Sucursal") %>' />
                                <br />
                                <asp:Label ID="Id_SucursalLabel" runat="server" Text='<%# Eval("Id_Sucursal") %>' />
                            </td>
                        </SelectedItemTemplate>
                    </asp:ListView>
                </div>
            </div>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BDSucursalesConnectionString %>" SelectCommand="SELECT [DescripcionSucursal], [NombreSucursal], [URL_Imagen_Sucursal], [Id_Sucursal] FROM [Sucursal]"></asp:SqlDataSource>
            <asp:Label ID="lblMensaje" runat="server" CssClass="lbl-mensaje"></asp:Label>
        </div>
    </form>
</body>
</html>
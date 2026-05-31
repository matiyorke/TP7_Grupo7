using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TP7_Grupo7
{
    public partial class SeleccionarSucursales : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        protected void btnSeleccionar_Command1(object sender, CommandEventArgs e)
        {

            // prueba de que anda el evento, mostramos mensaje con el id de la sucursal seleccionada
            if (e.CommandName == "eventoSeleccionar")
            {

                lblMensaje.Text = "Sucursal seleccionada: " + e.CommandArgument.ToString();
                string[] datos = e.CommandArgument.ToString().Split('|');

                DataTable dt;
                if (Session["SUCURSALES_SELECCIONADAS"] == null)
                {
                    dt = new DataTable();
                    dt.Columns.Add("Id_Sucursal");
                    dt.Columns.Add("NombreSucursal");
                    dt.Columns.Add("DescripcionSucursal");
                }
                else
                {
                    dt = (DataTable)Session["SUCURSALES_SELECCIONADAS"];
                }

                DataRow fila = dt.NewRow();
                fila["Id_Sucursal"] = datos[0];
                fila["NombreSucursal"] = datos[1];
                fila["DescripcionSucursal"] = datos[2];
                dt.Rows.Add(fila);

                Session["SUCURSALES_SELECCIONADAS"] = dt;

            }
        }
        

        protected void btn_Buscar_Click(object sender, EventArgs e)
        {
            string busqueda = txtBox_Buscar.Text.Trim();

            if (string.IsNullOrEmpty(busqueda))
            {
                // Si está vacío, mostramos todas
                SqlDataSource1.SelectCommand = "SELECT [DescripcionSucursal], [NombreSucursal], [URL_Imagen_Sucursal], [Id_Sucursal] FROM [Sucursal]";
                SqlDataSource1.SelectParameters.Clear();
            }
            else
            {
                // Filtramos por nombre parcial o completo
                SqlDataSource1.SelectCommand = "SELECT [DescripcionSucursal], [NombreSucursal], [URL_Imagen_Sucursal], [Id_Sucursal] FROM [Sucursal] WHERE [NombreSucursal] LIKE @Nombre";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("Nombre", "%" + busqueda + "%");
            }

            lv_Sucursales.DataBind();
        }

        protected void limpiar_Click(object sender, EventArgs e)
        {
            txtBox_Buscar.Text = "";
            SqlDataSource1.SelectCommand = "SELECT [DescripcionSucursal], [NombreSucursal], [URL_Imagen_Sucursal], [Id_Sucursal] FROM [Sucursal]";
            SqlDataSource1.SelectParameters.Clear();
            lv_Sucursales.DataBind();
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TP7_Grupo7
{
    public partial class ListadoSucursalesSeleccionados : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SUCURSALES_SELECCIONADAS"] != null)
            {
                DataTable tabla = (DataTable)Session["SUCURSALES_SELECCIONADAS"];

                if (tabla.Rows.Count > 0)
                {
                    gvSucursales.DataSource = tabla;
                    gvSucursales.DataBind();
                    lblMensaje.Text = "Total de sucursales seleccionadas: " + tabla.Rows.Count;
                }
            }
            else
            {
                lblMensaje.Text = "No se han seleccionado sucursales.";
            }


        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session["SUCURSALES_SELECCIONADAS"] = null;
            Response.Redirect("ListadoSucursalesSeleccionados.aspx");
        }
    }
}
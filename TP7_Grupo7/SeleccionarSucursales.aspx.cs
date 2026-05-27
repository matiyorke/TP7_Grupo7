using System;
using System.Collections.Generic;
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

            }
        }
    }
}
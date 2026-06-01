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
            if (!IsPostBack)
            {
                dlProvincias.DataSource = Provincias.ObtenerTodas();
                dlProvincias.DataBind();
                Pan_Detalle.Visible = false;
            }
        }

        protected void btnSeleccionar_Command1(object sender, CommandEventArgs e)
        {
            // Prueba de que anda el evento, mostramos mensaje con el id de la sucursal seleccionada
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
                    // Se agregan columnas de direccion 
                    dt.Columns.Add("DireccionSucursal");
                    // Agregamos tambien la columnas de horario que faltaban
                    dt.Columns.Add("DescripcionHorario");
                }
                else
                {
                    dt = (DataTable)Session["SUCURSALES_SELECCIONADAS"];
                }

                // Validamos duplicados, si ya existe la sucursal en la tabla, mostramos mensaje y no la agregamos
                DataRow[] filaExistente = dt.Select("Id_Sucursal = '" + datos[0] + "'");
                if (filaExistente.Length > 0)
                {
                    lblMensaje.Text = "La sucursal ya fue seleccionada.";
                    return;
                }

                DataTable detalles = AccederDatos.EjecutarConsulta(
                    "SELECT DireccionSucursal, DescripcionHorario " +
                    "FROM Sucursal " +
                    "LEFT JOIN Horario ON Id_HorarioSucursal = Id_Horario " +
                    "WHERE Id_Sucursal = " + datos[0]);

                string direccion = detalles.Rows.Count > 0 && detalles.Rows[0]["DireccionSucursal"] != DBNull.Value
                    ? detalles.Rows[0]["DireccionSucursal"].ToString() : "";
                string horario = detalles.Rows.Count > 0 && detalles.Rows[0]["DescripcionHorario"] != DBNull.Value
                    ? detalles.Rows[0]["DescripcionHorario"].ToString() : "Sin horario asignado";

                DataRow fila = dt.NewRow();
                fila["Id_Sucursal"] = datos[0];
                fila["NombreSucursal"] = datos[1];
                fila["DescripcionSucursal"] = datos[2];
                // Guardamos la direccion 
                fila["DireccionSucursal"] = direccion;
                // Guardamos el horario
                fila["DescripcionHorario"] = horario;
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
            // Resetea el label de provincia al limpiar
            lblProvinciaSeleccionada.Text = "Mostrando: Todas las sucursales";
        }

        // Filtro por provincia al hacer clic en el DataList
        protected void dlProvincias_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "filtrarProvincia")
            {
                string idProvincia = e.CommandArgument.ToString();
                // Muestra la provincia seleccionada actualmente
                lblProvinciaSeleccionada.Text = "Mostrando: " + ((Button)e.Item.FindControl("btnProvincia")).Text;
                SqlDataSource1.SelectCommand = "SELECT [DescripcionSucursal], [NombreSucursal], [URL_Imagen_Sucursal], [Id_Sucursal] FROM [Sucursal] WHERE [Id_ProvinciaSucursal] = @IdProvincia";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("IdProvincia", idProvincia);
                lv_Sucursales.DataBind();
            }
        }

        protected void Button1_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Detalles")
            {
                DataTable detalles = AccederDatos.EjecutarConsulta("SELECT NombreSucursal, DireccionSucursal, DescripcionHorario FROM Sucursal INNER JOIN Horario ON Id_HorarioSucursal = Id_Horario WHERE Id_Sucursal = " + e.CommandArgument.ToString());

                lbl_Suc_de.Text = "Sucursal: " + detalles.Rows[0]["NombreSucursal"].ToString();
                Lbl_direccion_de.Text = "Dirección: " + detalles.Rows[0]["DireccionSucursal"].ToString();
                Lbl_Horario_De.Text = "Horario: " + detalles.Rows[0]["DescripcionHorario"].ToString();
                Pan_Detalle.Visible = true;
            }
        }

        protected void pan_butt_ocu_Click(object sender, EventArgs e)
        {
            Pan_Detalle.Visible = false;
        }
    }
}
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
            // Se mueve al IsPostBack para evitar inconsistencias al eliminar filas
            if (!IsPostBack)
            {
                CargarGrilla();
            }
        }

        private void CargarGrilla()
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
                else
                {
                    lblMensaje.Text = "No se han seleccionado sucursales.";
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

        protected void gvSucursales_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            DataTable dt = (DataTable)Session["SUCURSALES_SELECCIONADAS"];

            // e.RowIndex te da el índice de la fila clickeada
            dt.Rows.RemoveAt(e.RowIndex);

            Session["SUCURSALES_SELECCIONADAS"] = dt;

            // Se verifica si quedan sucursales y se muestra mensaje correspondiente
            if (dt.Rows.Count == 0)
            {
                lblMensaje.Text = "No se han seleccionado sucursales.";
                Session["SUCURSALES_SELECCIONADAS"] = null;
                gvSucursales.DataSource = null;
                gvSucursales.DataBind();
            }
            else
            {
                gvSucursales.DataSource = dt;
                gvSucursales.DataBind();
                lblMensaje.Text = "Total de sucursales seleccionadas: " + dt.Rows.Count;
            }
        }

        protected void gvSucursales_Sorting(object sender, GridViewSortEventArgs e) 
        {
            DataTable dt = (DataTable)Session["SUCURSALES_SELECCIONADAS"];
            if (dt != null)
            {
                dt.DefaultView.Sort = e.SortExpression;
                gvSucursales.DataSource = dt;
                gvSucursales.DataBind();
            }
        }
    }
}
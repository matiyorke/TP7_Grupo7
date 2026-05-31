using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace EjemploListView
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                DataSet dataSet = new DataSet();
                SqlConnection sqlConnection = new SqlConnection(@"Data Source=.\SQLEXPRESS;Initial Catalog=Empresa;Integrated Security=True;TrustServerCertificate=True");
                sqlConnection.Open();

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter("SELECT [Dni], [Nombre], [Apellido], [Edad], [Sexo], [ImagenURL] FROM [Personas] ORDER BY [Nombre]", sqlConnection);

                sqlDataAdapter.Fill(dataSet, "Personas");
                ListViewEmpresa.DataSource = dataSet.Tables["Personas"];
                ListViewEmpresa.DataBind();
            }
        }

        protected void BtnSeleccionar_Command(object sender, CommandEventArgs e)
        {
            if(e.CommandName == "eventoSeleccionar")
            {
                lblMensaje.Text = e.CommandArgument.ToString();
            }
        }

        protected void btnMostrarSeleccionado_Click(object sender, EventArgs e)
        {
            string nombre, apellido;

            lblMensaje.Text = string.Empty;

            foreach(ListViewItem item in ListViewEmpresa.Items)
            {
                CheckBox checkBox = (CheckBox)(item.FindControl("CheckBoxEmpresa"));

                if (checkBox.Checked)
                {
                    nombre = ((Label)item.FindControl("NombreLabel")).Text;
                    apellido = ((Label)item.FindControl("ApellidoLabel")).Text;

                    lblMensaje.Text = lblMensaje.Text + nombre + " " + apellido + "<br>";
                } 
            }
        }

        protected void btnOrdenar_Click(object sender, EventArgs e)
        {
            SqlDataSourceEmpresa.SelectCommand = "SELECT [Dni], [Nombre], [Apellido], [Edad], [Sexo], [ImagenURL] FROM [Personas] ORDER BY [Nombre]"; 
        }
    }
}
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace TP7_Grupo7
{
    public class AccederDatos
    {

        private static string cadena = ConfigurationManager.ConnectionStrings["BDSucursalesConnectionString"].ConnectionString;

        public static DataTable EjecutarConsulta(string consulta)
        {
            DataTable dt = new DataTable();
            using (SqlConnection cn = new SqlConnection(cadena))
            {
                SqlDataAdapter da = new SqlDataAdapter(consulta, cn);
                da.Fill(dt);
            }
            return dt;
        }

        public static DataTable EjecutarConsulta(string consulta, SqlParameter[] parametros)
        {
            DataTable dt = new DataTable();
            using (SqlConnection cn = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand(consulta, cn);
                cmd.Parameters.AddRange(parametros);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            return dt;
        }
    }
}
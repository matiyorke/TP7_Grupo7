using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

namespace TP7_Grupo7
{
    public class Provincias
    {
        public static DataTable ObtenerTodas()
        {
            string consulta = "SELECT DescripcionProvincia FROM Provincia";
            return AccederDatos.EjecutarConsulta(consulta);
        }

    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace PekaraWeb
{
    public class UtilityClass
    {
        SqlConnection conn = new SqlConnection();
        string CS = ConfigurationManager.ConnectionStrings["CS"].ConnectionString;
        SqlCommand comm = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        DataSet ds = new DataSet();


        public int Provera_Korisnika(string email, string lozinka)
        {           
            int rezultat;
            conn.ConnectionString = CS;
            comm.Connection = conn;
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "dbo.Korisnik_Email";
            comm.Parameters.Add(new SqlParameter("@email", SqlDbType.NVarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, email));
            comm.Parameters.Add(new SqlParameter("@loz", SqlDbType.NVarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, lozinka));
            comm.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Current, null));
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();

            int Re = (int)comm.Parameters["@RETURN_VALUE"].Value ;
            return Re;
                
        }
        public void Upis_korisnika(string email, string pass)
        {
            conn.ConnectionString = CS;
            comm.Connection = conn;
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "Korisnik_Insert";
            comm.Parameters.Add(new SqlParameter("@email", SqlDbType.NVarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, email));
            comm.Parameters.Add(new SqlParameter("@loz", SqlDbType.NVarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, pass));
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
        }
        public void Update_korisnika(string email, string pass)
        {
            conn.ConnectionString = CS;
            comm.Connection = conn;
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "dbo.Korisnik_Update";
            comm.Parameters.Add(new SqlParameter("@email", SqlDbType.NVarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, email));
            comm.Parameters.Add(new SqlParameter("@loz", SqlDbType.NVarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, pass));
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
        }
        public void Proizvod_insert(string ime, int cena)
        {
            conn.ConnectionString = CS;
            comm.Connection = conn;
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "Proizvod_insert";
            comm.Parameters.Add(new SqlParameter("@ime", SqlDbType.NVarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, ime));
            comm.Parameters.Add(new SqlParameter("@cena", SqlDbType.Int, 4, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, cena));
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
        }
        public void Proizvod_apdejt(string ime, string tip, int cena, int kalorije)
        {
            conn.ConnectionString = CS;
            comm.Connection = conn;
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "Proizvod_update";
            comm.Parameters.Add(new SqlParameter("@ime", SqlDbType.NVarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, ime));
            comm.Parameters.Add(new SqlParameter("@tip", SqlDbType.NVarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, tip));
            comm.Parameters.Add(new SqlParameter("@cena", SqlDbType.Int, 4, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, cena));
            comm.Parameters.Add(new SqlParameter("@kalorije", SqlDbType.Int, 4, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, kalorije));
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
        }
        public void Proizvodjac_insert(string ime, int PIB)
        {
            conn.ConnectionString = CS;
            comm.Connection = conn;
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "Proizvodjac_insert";
            comm.Parameters.Add(new SqlParameter("@ime", SqlDbType.NVarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, ime));
            comm.Parameters.Add(new SqlParameter("@PIB", SqlDbType.Int, 4, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, PIB));
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
        }
        public void Proizvodjac_update(int id, string ime, int PIB)
        {
            conn.ConnectionString = CS;
            comm.Connection = conn;
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "Proizvodjac_update";
            comm.Parameters.Add(new SqlParameter("@id", SqlDbType.Int, 4, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, id));
            comm.Parameters.Add(new SqlParameter("@ime", SqlDbType.NVarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, ime));
            comm.Parameters.Add(new SqlParameter("@PIB", SqlDbType.Int, 4, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, PIB));
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
        }
        public void Kupovina(int id_proizvoda, int id_lokacija , int kolicina)
        {
            conn.ConnectionString = CS;
            comm.Connection = conn;
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "Kupovina";
            comm.Parameters.Add(new SqlParameter("@id_proizvoda", SqlDbType.Int, 4, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, id_proizvoda));
            comm.Parameters.Add(new SqlParameter("@id_lokacija", SqlDbType.Int, 4, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, id_lokacija));
            comm.Parameters.Add(new SqlParameter("@kolicina", SqlDbType.Int, 300, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, kolicina));
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
        }
        public void Uvoz(int id_proizvoda, int id_lokacija, int kolicina)
        {
            conn.ConnectionString = CS;
            comm.Connection = conn;
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "uvoz_kolicina";
            comm.Parameters.Add(new SqlParameter("@id_proizvoda", SqlDbType.Int, 4, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, id_proizvoda));
            comm.Parameters.Add(new SqlParameter("@id_lokacija", SqlDbType.Int, 4, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, id_lokacija));
            comm.Parameters.Add(new SqlParameter("@kolicina", SqlDbType.Int, 300, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, kolicina));
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
        }        
        public void Promena_radnog_mesta(int id_radnik, int id_lokacija)
        {
            conn.ConnectionString = CS;
            comm.Connection = conn;
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "Promena_radnog_mesta";
            comm.Parameters.Add(new SqlParameter("@id_radnik", SqlDbType.Int, 4, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, id_radnik));
            comm.Parameters.Add(new SqlParameter("@id_lokacija", SqlDbType.Int, 4, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, id_lokacija));
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
        }
    }

}
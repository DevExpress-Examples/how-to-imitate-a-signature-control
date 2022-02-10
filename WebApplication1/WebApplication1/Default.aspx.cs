using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1 {
    public partial class Default : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {

        }

        protected void ASPxButton2_Click(object sender, EventArgs e) {
            SaveToDataBase(FirstName.Text, LastName.Text);
            GetDataFormDatabase();
            ClearEditors();
        }
        private void ClearEditors() {
            FirstName.Value = null;
            LastName.Value = null;
        }
        public void SaveToDataBase(string fn, string ln) {
            string connectionString = System.Configuration.ConfigurationManager
                         .ConnectionStrings["SignatureDBConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = connection.CreateCommand()) {
                command.CommandText = "Update SignatureTable SET FirstName = @fn, LastName=@ln Where Id='1'";

                command.Parameters.AddWithValue("@fn", fn);
                command.Parameters.AddWithValue("@ln", ln);

                connection.Open();

                command.ExecuteNonQuery();

                connection.Close();
            }
        }
        public void GetDataFormDatabase() {
            string connectionString = System.Configuration.ConfigurationManager
                         .ConnectionStrings["SignatureDBConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = connection.CreateCommand()) {
                command.CommandText = "Select Signature, FirstName,LastName From SignatureTable Where Id='1'";
                connection.Open();

                command.ExecuteNonQuery();
                using (SqlDataReader reader = command.ExecuteReader()) {
                    if (reader.Read()) {
                        SignatureLabel.Text = "Signature: ";
                        binaryImage.ContentBytes = reader["Signature"] as byte[];
                        FirstNameReadOnly.Text = "First Name: " + reader["FirstName"].ToString();
                        LastNameReadOnly.Text = "Last Name: " + reader["LastName"].ToString();
                    }
                }

                connection.Close();
            }

        }
    }

}

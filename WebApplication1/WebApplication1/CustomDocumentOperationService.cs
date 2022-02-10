using DevExpress.XtraReports.Web.WebDocumentViewer;
using DevExpress.XtraReports.Web.WebDocumentViewer.DataContracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DevExpress.XtraPrinting;
using DevExpress.XtraPrinting.Drawing;
using System.Drawing;
using System.Data.SqlClient;


namespace WebApplication1 {
    public class CustomDocumentOperationService : DocumentOperationService {

        public override bool CanPerformOperation(DocumentOperationRequest request) {
            return true;
        }
        public override DocumentOperationResponse PerformOperation(DocumentOperationRequest request, PrintingSystemBase initialPrintingSystem, PrintingSystemBase printingSystemWithEditingFields) {
            ImageSource imageSource = printingSystemWithEditingFields.EditingFields[0].EditValue as ImageSource;
            if (imageSource != null) {
                var img = imageSource.Image;
                byte[] arr = ImageToByte(img);
                SaveToDataBase(arr);
            }
            return base.PerformOperation(request, initialPrintingSystem, printingSystemWithEditingFields);
        }

        public static byte[] ImageToByte(Image img) {
            ImageConverter converter = new ImageConverter();
            return (byte[])converter.ConvertTo(img, typeof(byte[]));
        }
        public void SaveToDataBase(byte[] arr) {
            string connectionString = System.Configuration.ConfigurationManager
                         .ConnectionStrings["SignatureDBConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = connection.CreateCommand()) {
                command.CommandText = "Update SignatureTable SET Signature = @arr Where Id='1'";

                command.Parameters.AddWithValue("@arr", arr);

                connection.Open();

                command.ExecuteNonQuery();

                connection.Close();
            }
        }

    }
}
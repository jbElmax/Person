
using Newtonsoft.Json;
using PersonAPI.Models;
using PersonAPI.Static;
using System;
using System.Collections.Generic;
using System.Net;

namespace PersonAPI
{
    public partial class Page2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                string id = Request.QueryString["id"];

                GetPersonData(id);
            }
        }
        public void GetPersonData(string id) {
            string baseEndPoint = ApiEndpoints.PersonEndpoint;

            using (WebClient client = new WebClient())
            {
                try
                {
                    string url = baseEndPoint + id;
                    string response = client.DownloadString(url);

                    PersonViewModel person = JsonConvert.DeserializeObject<PersonViewModel>(response);
                    string title = $"{person.Name}|{person.Age}|{person.PersonTypeDesc}";

                    titleField.Value = title;
                }
                catch (Exception ex)
                {
                    string errorMessage = "An error occurred while fetching person data.";
                    string script = $@"<script>alert('{errorMessage}');</script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "ErrorPopup", script);
                }
            }
        }

    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PekaraWeb
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UtilityClass klasa = new UtilityClass();
            klasa.Update_korisnika("jala@gmail.com", "1234");
        }
    }
}
using SoSACAD.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace SoSACAD.Controllers
{
    public class RegistrationController : ApiController
    {
        Database_Access_Layer.Db dblayer = new Database_Access_Layer.Db();

        [HttpPost]
        public IHttpActionResult LEO([FromBody]Registration.LEO LEORegInfo)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                var response = dblayer.RegisterLEO(LEORegInfo);
                return Ok(response);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }
    }
}

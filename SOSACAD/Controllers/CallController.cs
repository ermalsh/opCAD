using SoSACAD.Models;
using System;
using System.Web.Http;

namespace SoSACAD.Controllers
{
    public class CallController : ApiController
    {
        Database_Access_Layer.Db dblayer = new Database_Access_Layer.Db();

        [HttpPost]
        public IHttpActionResult GetCallData([FromBody]Calls pID)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                var response = dblayer.Call_Data(pID);
                return Ok(response);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }

        [HttpPost]
        public IHttpActionResult GetAllCallData()
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                var response = dblayer.All_Call_Data();
                return Ok(response);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }
    }
}


using SoSACAD.Models;
using System;
using System.Web.Http;

namespace SoSACAD.Controllers
{
    public class UnitController : ApiController
    {
        Database_Access_Layer.Db dblayer = new Database_Access_Layer.Db();

        [HttpPost]
        public IHttpActionResult GetUnitData([FromBody]GetUnitNumber Unit)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                var response = dblayer.Unit_Data(Unit);
                return Ok(response);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }

        [HttpPost]
        public IHttpActionResult UpdateIdentifier([FromBody]IdentifierSetting Identifier)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                dblayer.Update_ID(Identifier);
                return Ok();
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }
    }
}

using SoSACAD.Models;
using System;
using System.Web.Http;

namespace SoSACAD.Controllers
{
    public class VehicleController : ApiController
    {
        Database_Access_Layer.Db dblayer = new Database_Access_Layer.Db();

        [HttpPost]
        public IHttpActionResult GetAllVehicles()
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                var response = dblayer.Get_Veh();
                return Ok(response);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }

        [HttpPost]
        public IHttpActionResult VehicleLookup([FromBody]VehicleLookup Vehicle)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                var response = dblayer.Lookup_Veh(Vehicle);
                return Ok(response);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }
    }
}

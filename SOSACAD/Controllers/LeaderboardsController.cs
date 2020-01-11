using Newtonsoft.Json.Linq;
using SoSACAD.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace SoSACAD.Controllers
{
    public class LeaderboardsController : ApiController
    {
        Database_Access_Layer.Db dblayer = new Database_Access_Layer.Db();
        [HttpPost]
        public IHttpActionResult GetLeaderboard([FromBody]int Modifier)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                var response = dblayer.Get_Score(Modifier);
                return Ok(response);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }
    }
}

using SoSACAD.Models;
using System;
using System.Web.Http;

namespace SoSACAD.Controllers
{
    public class CivilianController : ApiController
    {
        Database_Access_Layer.Db dblayer = new Database_Access_Layer.Db();

        [HttpPost]
        public IHttpActionResult GetAllCivilians()
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                var response = dblayer.Get_Civs();
                return Ok(response);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }

        [HttpPost]
        public IHttpActionResult CivilianLookup([FromBody] GetCivs Civilian)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                var response = dblayer.Search_Civ(Civilian);
                return Ok(response);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }

        [HttpPost]
        public IHttpActionResult AddWarning([FromBody]WarningData Warning)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                dblayer.Unit_Data(Warning);
                return Ok(Warning.licenseNumber);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }

        [HttpPost]
        public IHttpActionResult LoadTickets([FromBody]TicketData CivTickets)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                var response = dblayer.Load_Tickets(CivTickets);
                return Ok(response);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }

        [HttpPost]
        public IHttpActionResult AddTicket([FromBody]TicketData Ticket)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                dblayer.Add_Ticket(Ticket);
                return Ok(Ticket.licenseNumber);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }

        [HttpPost]
        public IHttpActionResult LoadArrests([FromBody]ArrestData CivArrests)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                var response = dblayer.Load_Arrests(CivArrests);
                return Ok(response);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }

        [HttpPost]
        public IHttpActionResult AddArrest([FromBody]ArrestData Arrest)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                dblayer.Add_Arrest(Arrest);
                return Ok(Arrest.licenseNumber);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }

        [HttpPost]
        public IHttpActionResult AddWarrant([FromBody]WarrantData Warrant)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                dblayer.Add_Warrant(Warrant);
                return Ok(Warrant.licenseNumber);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }

        [HttpPost]
        public IHttpActionResult LoadWarrants([FromBody]WarrantData CivWarrants)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                var response = dblayer.Load_Warrants(CivWarrants);
                return Ok(response);
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }
    }
}

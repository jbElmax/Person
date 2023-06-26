using PersonAPI.Data;
using PersonAPI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Cors;
using static Telerik.Web.UI.OrgChartStyles;

namespace PersonAPI.Controllers
{

    public class PersonController : ApiController
    {
        static readonly IPersonRepository PersonRepository = new PersonRepository();
        // GET api/person
        [HttpGet]
        public IHttpActionResult GetPersons()
        {
            var personList = PersonRepository.GetPersons();

            return Ok(personList);
  
        }
        [HttpGet]
        // GET api/person/5
        public IHttpActionResult GetPerson(int id)
        {
            var person = PersonRepository.GetPerson(id);
            if (person == null) { 
                return NotFound();
            }
            return Ok(person);
        }
        
        [HttpPost]

        // POST api/person
        public async Task<IHttpActionResult> CreatePerson([FromBody]PersonViewModel personCreate)
        {
            if (personCreate != null) {

                var id = await PersonRepository.CreatePerson(personCreate);
                return CreatedAtRoute("DefaultApi", new { id = id }, personCreate);
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpPut]
        // PUT api/person/5
        public async Task <IHttpActionResult> UpdatePerson(int id, [FromBody] PersonViewModel personUpdateData)
        {
            var person = PersonRepository.GetPerson(id);
            if(person != null) {
                var task = await PersonRepository.UpdatePerson(personUpdateData);
                if (task != null) {
                    return Ok(task);
                }
                return BadRequest();
            }
            return BadRequest();
            
        }
        [HttpDelete]
        // DELETE api/person/5
        public async Task<IHttpActionResult> DeletePerson(int id)
        {
            var taskDelete =await PersonRepository.DeletePerson(id);
            if (!taskDelete) { 
                return BadRequest();
            }
            return Ok();

        }
        [HttpGet]
        [Route("api/persontypes")]
        public IHttpActionResult GetPersonTypes()
        {
            var personTypes = PersonRepository.GetPersonTypes();
            return Ok(personTypes);
        }

    }
}

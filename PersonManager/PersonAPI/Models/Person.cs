using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;

namespace PersonAPI.Models
{
    public class Person
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Age {get; set; }
        public int PersonTypeId { get; set; }
        public PersonType PersonType { get; set; }
    }
}
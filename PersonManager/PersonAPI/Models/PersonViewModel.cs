using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PersonAPI.Models
{
    public class PersonViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Age { get; set; }
        public string PersonTypeDesc { get; set; }
    }
}
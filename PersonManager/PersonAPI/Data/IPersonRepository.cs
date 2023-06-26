using PersonAPI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PersonAPI.Data
{
    internal interface IPersonRepository
    {
        List<PersonViewModel> GetPersons();
        PersonViewModel GetPerson(int id);

        Task<int> CreatePerson(PersonViewModel item);

        Task<bool> DeletePerson(int id);

        Task<PersonViewModel> UpdatePerson(PersonViewModel item);

        List<PersonType> GetPersonTypes();
    }
}

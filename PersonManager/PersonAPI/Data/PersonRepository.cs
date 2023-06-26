using PersonAPI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
namespace PersonAPI.Data
{
    public class PersonRepository : IPersonRepository
    {
        public List<PersonViewModel> GetPersons()
        {
            List<Person> persons = DataManager.Instance.Persons;
            List<PersonType> personTypes = DataManager.Instance.PersonTypes;
            List<PersonViewModel> personViews = persons.Select(person => new PersonViewModel
            {
                Id = person.Id,
                Name = person.Name,
                Age = person.Age,
                PersonTypeDesc = personTypes.FirstOrDefault(pt => pt.Id == person.PersonTypeId)?.Description

            }).ToList();
            return personViews;
        }

        public PersonViewModel GetPerson(int id)
        {
            List<PersonType> personTypes = DataManager.Instance.PersonTypes;
            var person = DataManager.Instance.Persons.FirstOrDefault(x => x.Id == id);
            if (person != null) { 
            PersonViewModel personView = new PersonViewModel
            {
                Id = person.Id,
                Name = person.Name,
                Age = person.Age,
                PersonTypeDesc = personTypes.FirstOrDefault(pt => pt.Id == person.PersonTypeId)?.Description
            };
            return personView;
            }
            return null;
        }
        private int GenerateNewPersonId()
        {
            int maxId = DataManager.Instance.Persons.Max(p => p.Id);
            return maxId + 1;
        }

        public async Task<int> CreatePerson(PersonViewModel personCreate)
        {
          
            int newId = GenerateNewPersonId();
            List<PersonType> personTypes = DataManager.Instance.PersonTypes;
            Person person = new Person
            {
                Id = newId,
                Name = personCreate.Name,
                Age = personCreate.Age,
                PersonTypeId = personTypes.FirstOrDefault(pt => pt.Description == personCreate.PersonTypeDesc).Id

            };


            DataManager.Instance.Persons.Add(person);

            await DataManager.Instance.SavePersonsAsync();

            return newId;
            
        }



        public async Task<bool> DeletePerson(int id)
        {
            var person = DataManager.Instance.Persons.FirstOrDefault(x => x.Id == id);
            if (person == null)
            {
                return false;
            }
            DataManager.Instance.Persons.Remove(person);
            await DataManager.Instance.SavePersonsAsync();
            return true;
        }

        public async Task<PersonViewModel> UpdatePerson(PersonViewModel personUpdateData)
        {
            var person = DataManager.Instance.Persons.FirstOrDefault(x => x.Id == personUpdateData.Id);
            if (person == null)
            {
                return null;
            }

            List<PersonType> personTypes = DataManager.Instance.PersonTypes;
            person.Name = personUpdateData.Name;
            person.Age = personUpdateData.Age;
            person.PersonTypeId = personTypes.FirstOrDefault(pt => pt.Description == personUpdateData.PersonTypeDesc).Id;

            await DataManager.Instance.SavePersonsAsync();

            return personUpdateData;
        }

        public List<PersonType> GetPersonTypes()
        {
            List<PersonType> personTypes = DataManager.Instance.PersonTypes;
            return personTypes;
        }
    }
}
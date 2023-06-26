using Newtonsoft.Json;
using PersonAPI.Models;

using System.Collections.Generic;

using System.Web;
using System.IO;

using System.Threading.Tasks;

namespace PersonAPI.Data
{
    public class DataManager
    {
        private static readonly string DatabaseFilePath = Path.Combine(HttpContext.Current.Server.MapPath("~/Data"), "persons.json");

        private static DataManager _instance;
        private static readonly object _lockObject = new object();

        public List<Person> Persons { get; private set; }
        public List<PersonType> PersonTypes { get; private set; }

        private DataManager()
        {

            Persons = new List<Person>();
            PersonTypes = new List<PersonType>();

            PersonTypes = new List<PersonType>
                {
                    new PersonType { Id = 1, Description = "Teacher" },
                    new PersonType { Id = 2, Description = "Student" }
                };

            LoadPerson();
        }
        public void LoadPerson() {
            string jsonData = File.ReadAllText(DatabaseFilePath);
            Persons = JsonConvert.DeserializeObject<List<Person>>(jsonData);
        }

        private async Task WriteJsonDataToFileAsync(string filePath, string jsonData)
        {
            using (StreamWriter writer = new StreamWriter(filePath))
            {
                await writer.WriteAsync(jsonData);
            }
        }
        public async Task SavePersonsAsync()
        {

            string jsonData = JsonConvert.SerializeObject(Persons);
            await WriteJsonDataToFileAsync(DatabaseFilePath, jsonData);
        }

        public static DataManager Instance
        {
            get
            {
                if (_instance == null)
                {
                    lock (_lockObject)
                    {
                        if (_instance == null)
                        {
                            _instance = new DataManager();
                        }
                    }
                }
                return _instance;
            }
        }
    }
}
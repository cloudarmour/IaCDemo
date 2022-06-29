using Newtonsoft.Json; 

namespace Company.Function
{
    public class Counter
    {   
        [JsonProperty(PropertyName="id")] //This is to make sure our properties matchup to container attributes
        public string Id {get; set;}

        [JsonProperty(PropertyName="count")]
        public int Count {get; set;}

    }
}


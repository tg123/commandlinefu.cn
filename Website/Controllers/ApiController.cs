using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Linq;
using Commandlinefu.CommandData;
using Microsoft.AspNetCore.Mvc;

namespace Commandlinefu.Website.Controllers
{
    [Produces("application/json")]
    public class ApiController : Controller
    {
        private readonly IReadOnlyDictionary<long, CommandlinefuInfo> _data;

        public ApiController(DataHolder dataHolder)
        {
            _data = dataHolder.Data;
        }

        [HttpGet]
        public IActionResult Get(long id)
        {
            if (_data.TryGetValue(id, out var cmd))
            {
                return Ok(cmd);
            }

            return NotFound();
        }

        [HttpGet]
        public IActionResult Search(string str)
        {
            return Ok(_data.Values.Where(info => info.Command.Contains(str)).Take(10));
        }

        [HttpGet]
        public IActionResult Random(int count = 1)
        {
            count = Math.Min(count, 10);
            count = Math.Max(count, 1);

            return Ok(RandomValues(_data).Take(count));
        }

        // http://stackoverflow.com/questions/1028136/random-entry-from-dictionary
        public static IEnumerable<TValue> RandomValues<TKey, TValue>(IReadOnlyDictionary<TKey, TValue> dict)
        {
            var rand = new Random();
            var values = dict.Values.ToList();
            var size = dict.Count;
            if (size == 0)
            {
                yield break;
            }

            for(;;)
            {
                yield return values[rand.Next(size)];
            }
        }
    }
}
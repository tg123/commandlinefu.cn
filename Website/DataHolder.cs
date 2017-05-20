using System.Collections.Generic;
using System.Collections.Immutable;
using System.Linq;
using Commandlinefu.CommandData;

namespace Commandlinefu.Website
{
    public class DataHolder
    {
        public DataHolder(ICommandInfoProvider provider)
        {
            Data = provider
                .ListAll()
                .Where(c => c.Hide != true)
                .ToDictionary(c => c.CommandlinefuId, c => c).ToImmutableDictionary();
        }

        public IReadOnlyDictionary<long, CommandlinefuInfo> Data { get; }
    }
}
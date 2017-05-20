using System.Collections.Generic;

namespace Commandlinefu.CommandData
{
    public interface ICommandInfoProvider
    {
        IEnumerable<CommandlinefuInfo> ListAll();
    }
}
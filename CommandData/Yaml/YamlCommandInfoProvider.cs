using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text;
using YamlDotNet.RepresentationModel;

namespace Commandlinefu.CommandData.Yaml
{
    public class YamlCommandInfoProvider : ICommandInfoProvider
    {
        private readonly string _path;

        public YamlCommandInfoProvider(string path)
        {
            _path = path;
        }

        public IEnumerable<CommandlinefuInfo> ListAll()
        {
            foreach (var file in Directory.EnumerateFiles(_path).Where(entry => entry.EndsWith(".yaml")))
            {
                var yaml = new YamlStream();
                yaml.Load(new StreamReader(File.OpenRead(file)));

                var mapping = (YamlMappingNode) yaml.Documents[0].RootNode;


                var commandlinefuId = Convert.ToInt64(mapping.Children[new YamlScalarNode("commandlinefu_id")].ToString());
                var hide = mapping.Children.TryGetValue(new YamlScalarNode("hide"), out var hide0) && Convert.ToBoolean(hide0.ToString());
                var command = mapping.Children[new YamlScalarNode("command")].ToString();
                var summary = mapping.Children[new YamlScalarNode("summary")].ToString();

                yield return new CommandlinefuInfo
                {
                    FileName = Path.GetFileName(file),
                    CommandlinefuId = commandlinefuId,
                    Hide = hide,
                    Command = command,
                    Summary = summary
                };
            }
        }
    }
}
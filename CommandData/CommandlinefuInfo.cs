namespace Commandlinefu.CommandData
{
    public class CommandlinefuInfo
    {
        public long CommandlinefuId { get; set; }

        public string FileName { get; set; }

        public bool? Hide { get; set; }

        public bool Shown => Hide != true;

        public string Command { get; set; }

        public string Summary { get; set; }
    }
}
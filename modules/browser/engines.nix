{ ... }:

{
  force = true;
  default = "ddg";
  engines = {
    amazondotcom-us.metaData.hidden = true;
    bing.metadata.hidden = true;
    ebay.metadata.hidden = true;
    startpage = {
      name = "StartPage";
      urls = [ { template = "https://www.startpage.com/sp/search?query={searchTerms}"; } ];
      iconMapObj."32" = "https://www.startpage.com/favicon.ico";
      definedAliases = [ "@sp" ];
    };
  };
}

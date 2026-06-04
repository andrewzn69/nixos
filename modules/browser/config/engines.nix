{ pkgs, ... }:

{
  force = true;
  default = "ddg";
  engines = {
    amazondotcom-us.metadata.hidden = true;
    bing.metadata.hidden = true;
    ebay.metadata.hidden = true;
    startpage = {
      name = "StartPage";
      urls = [ { template = "https://www.startpage.com/sp/search?query={searchTerms}"; } ];
      iconMapObj."32" = "https://www.startpage.com/favicon.ico";
      definedAliases = [ "@sp" ];
    };
    nix-packages = {
      name = "Nix Packages";
      urls = [ { template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}"; } ];
      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = [ "@np" ];
    };
    terraform-registry = {
      name = "Terraform Registry";
      urls = [ { template = "https://registry.terraform.io/search?q={searchTerms}"; } ];
      iconMapObj."32" = "https://registry.terraform.io/favicon.ico";
      definedAliases = [ "@tr" ];
    };
  };
}

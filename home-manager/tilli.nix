{
  inputs,
  pkgs,
  config,
  age,
  ...
}: {
  imports = [
    ./tilli
  ];

  age.secrets = {
    vpn-password = {
      file = ../secrets/vpn-password.age;
    };
  };
  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "tilli";
    homeDirectory = "/home/tilli";

    packages = with pkgs; [
      cloak
      openvpn
      vial
      qmk
      via
      terraform
      terraform-providers.openstack
      (pkgs.writers.writePython3Bin
        "ofx-fix"
        {libraries = [python312Packages.ofxparse];}
        ''
          import argparse
          import codecs
          from ofxparse import OfxParser
          from ofxparse import OfxPrinter

          parser = argparse.ArgumentParser()
          parser.add_argument("input", help="input filename")
          parser.add_argument("output", help="output filename")
          args = parser.parse_args()


          with codecs.open(args.input) as fileobj:
              ofx = OfxParser.parse(fileobj)
              for transaction in ofx.account.statement.transactions:
                  if not transaction.id:
                      transaction.id = '{}-{}-{}-{}'.format(transaction.date,
                                                            transaction.payee,
                                                            transaction.type,
                                                            transaction.amount)
                      print('Fixed transaction {}'.format(transaction.id))
              printer = OfxPrinter(ofx=ofx, filename=args.output)
              printer.write(tabs=1)
        '')
    ];
  };
  programs.openstackclient.enable = true;

  programs.git.enable = true;
  programs.git.userEmail = "tilman@baumann.name";
  programs.git.userName = "Tilman Baumann";
  programs.git.aliases = {
    pr = "pull --rebase";
  };
  home.file.".face" = {
    source = ./tilli/tilli-face.png;
  };

  /*
  # Default desktop environment
  xsession = {
    enable = true;
    windowManager.command = "Hyprland";
  };

    programs.thunderbird.enable = true;
    programs.thunderbird.profiles =
    {
      "defo" = {
        name = "defo";
        isDefault = true;
        settings = {
          "mail.spellcheck.inline" = false;
        };
      };
    };
    accounts.email.accounts = {
      name = {
        address = "tilman.baumann@tilman.baumann.name";
        primary = true;
        realName = "Tilman Baumann";
        imap.host = "imap.migadu.com";
        smtp.host = "smtp.migadu.com";
        userName = "tilman.baumann@tilman.baumann.name";
  #      thunderbird.enable = true;
  #      thunderbird.profiles = ["def"];
      };
    };
  */
}

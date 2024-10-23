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
  programs.ssh.matchBlocks.grafanacbx = {
    hostname = "212.87.48.34";
    user = "stack_baumann";
    localForwards = [
      {
        bind.port = 12345;
        host.address = "10.172.4.100";
        host.port = 3000;
      }
    ];
  };

  programs.git.enable = true;
  programs.git.userEmail = "tilman@baumann.name";
  programs.git.userName = "Tilman Baumann";
  programs.git.aliases = {
    pr = "pull --rebase";
  };
  home.file.".face" = {
    source = ./tilli/tilli-face.png;
  };
}

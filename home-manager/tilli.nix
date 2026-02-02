{
  inputs,
  pkgs,
  config,
  age,
  ...
}:
{
  imports = [
    ./tilli
  ];

  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "tilli";
    homeDirectory = "/home/tilli";

    packages = with pkgs; [
      cloak
      vial
      qmk
      via
      (pkgs.writers.writePython3Bin "ofx-fix" { libraries = [ python312Packages.ofxparse ]; } ''
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
  programs.git.enable = true;
  programs.git.settings = {
    user = {
      email = "tilman@baumann.name";
      name = "Tilman Baumann";
    };
    aliases = {
      pr = "pull --rebase";
    };
    push.autoSetupRemote = true;
  };
  home.file.".face" = {
    source = ./tilli/tilli-face.png;
  };
}

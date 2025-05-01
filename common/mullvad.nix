{config, ...}: {
  imports = [
    ../modules/mullvad.nix
  ];
  mullvad = {
    enable = true;
    privateKeyFile = config.sops.secrets.mullvad-key.path;
    locations = {
      de-fra = {
        servers = [
          {
            endpoint = "185.213.155.73:51820";
            publicKey = "HQHCrq4J6bSpdW1fI5hR/bvcrYa6HgGgwaa5ZY749ik=";
          }
          {
            endpoint = "185.213.155.74:51820";
            publicKey = "s1c/NsfnqnwQSxao70DY4Co69AFT9e0h88IFuMD5mjs=";
          }
          {
            endpoint = "185.209.196.73:51820";
            publicKey = "vVQKs2TeTbdAvl3sH16UWLSESncXAj0oBaNuFIUkLVk=";
          }
          {
            endpoint = "185.209.196.74:51820";
            publicKey = "tzYLWgBdwrbbBCXYHRSoYIho4dHtrm+8bdONU1I8xzc=";
          }
          {
            endpoint = "185.209.196.75:51820";
            publicKey = "tpobOO6t18CzHjOg0S3RlZJMxd2tz4+BnRYS7NrjTnM=";
          }
          {
            endpoint = "185.209.196.76:51820";
            publicKey = "nAF0wrLG2+avwQfqxnXhBGPUBCvc3QCqWKH4nK5PfEU=";
          }
          {
            endpoint = "185.209.196.77:51820";
            publicKey = "mTmrSuXmTnIC9l2Ur3/QgodGrVEhhIE3pRwOHZpiYys=";
          }
          {
            endpoint = "185.213.155.72:51820";
            publicKey = "flq7zR8W5FxouHBuZoTRHY0A0qFEMQZF5uAgV4+sHVw=";
          }
        ];
      };
      uk-lon = {
        servers = [
          {
            endpoint = "141.98.252.130:51820";
            publicKey = "IJJe0TQtuQOyemL4IZn6oHEsMKSPqOuLfD5HoAWEPTY=";
          }
          {
            endpoint = "141.98.252.222:51820";
            publicKey = "J57ba81Q8bigy9RXBXvl0DgABTrbl81nb37GuX50gnY=";
          }
          {
            endpoint = "185.195.232.66:51820";
            publicKey = "VZwE8hrpNzg6SMwn9LtEqonXzSWd5dkFk62PrNWFW3Y=";
          }
          {
            endpoint = "185.195.232.67:51820";
            publicKey = "PLpO9ikFX1garSFaeUpo7XVSMrILrTB8D9ZwQt6Zgwk=";
          }
          {
            endpoint = "185.195.232.68:51820";
            publicKey = "bG6WulLmMK408n719B8nQJNuTRyRA3Qjm7bsm9d6v2M=";
          }
          {
            endpoint = "185.195.232.69:51820";
            publicKey = "INRhM0h4T1hi9j28pcC+vRv47bp7DIsNKtagaFZFSBI=";
          }
          {
            endpoint = "185.195.232.70:51820";
            publicKey = "MVqe9e9aDwfFuvEhEn4Wd/zWV3cmiCX9fZMWetz+23A=";
          }
          {
            endpoint = "141.98.252.138:51820";
            publicKey = "uHkxYjfx6yzPHSdyqYqSEHsgFNFV8QCSV6aghuQK3AA=";
          }
        ];
      };
    };
  };
}

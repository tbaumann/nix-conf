let
  zuse-tilli = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD06odwjYayF8YNuuzVydz5/aA8oo7HuPi/S1L7spbxRDU9h+QnSgOlrQkky1g8s+x39MHMLUF/6SZOOQHinBCecTmpGUF/QpPjWSQHafIURjat3L4dScsupVc+IwmbDgLkUxMux/PLkfzxk2YdqpojzcILI5kvGNR2PPEs/vYp2+nqry9TjDfz4OCv4b+FtjqzlZalrSbt9wkTTWK/Sd7AlAQegkOLKB+IrBORIEKknYC+UnyCr5HH+aAD0qgKp3cxh2dIUUEDu3wSyCzv/nus1NqHIaNSfCxwNNrUd53XJOg2wwIV8NQZ0R7md4wYwdWR/I5DM9iH8ckj8kkj/isyKC49vfuOucsQhApQErM4TYVbO5Ckym72TzUUJYzaRVgVAOfOnCsrjW9ihh/RSYWTFnjq6X8QUp6NX3BdUYyoKtxvbKzFdggNPEr4hLpSfOJzHqFJCdH2lyC8Apd1Y56Km+eBz/46kbvaUCvwfgSbQr/lOQzWq63w3S7lnB597/c= tilli@zuse";
  zuse-root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHt8WgsMjrt+0FVzxAjv+5FwHfMZuSMfFdJy7Hr5X5sV root@zuse";
  klappi-root = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCFj8KQiKdv7do5srBQIkN0Y2/M+n4oB0n6WdVqBHvgSE3vtuR60wV59KOGcm0bW1UWpMJk3XoOpXT8K7ep/pPjUPVtifuk2qHUuA1xb/BAydQCjawHuQfzYtAhg1j3Rc0yC/EKFLAdqRm1D8s4BnHodLH1M9fkCUrxm9K1sklyPPZIS2AR6h4ADh3AQgi4OBgxuicV6Wdj39/bCF+ve9gvlEqev0VCF9eYPSDgEe+npZa71GpvDtKSwWFYzzOtGFR4PVGWRmcYZgAjtSesMZu4n/E52Do5r3MaM7C1xRtonhfyef1ktwP6UHSARRuIVB5j0nXifZb7+TeCdQh8LveXgB0iVP+KEAxZ8dQptG24BGQgA7AAcn6SVz+onnsMuGL3P+qrN1EADpZfL2dpVYf7D5clDDEpVCqAf2UoLkbCr8TbBA8BGPl1EA7c50O9YSY8NnwczfxY0/fBLqOHzhuRNl4XuvktY4jsHLdl9NF+kuE0pC9P9+IHtuOkpIr0jGU= root@zuse-klappi";
  klappi-tilli = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHV2grChMteVSJYEfW4mHagZlcyAtTszKd2AfK++/6l5FLpPMdP+Ly8kLP2YO8jc3ThDBxMxhNO/SuALkcS3A/3NkswE/khyqYJFgR5gIbMNwFPerrDc7jEmSzHFIbsGOv73OEjnjiyDklYWHZYl/S5gKMLIKJEP+ou8OmmqAWmhFtd3kpkzkKgt9TMwLqcUvskyA4qzRtG0Sc9ED70lLMsLD2ymbYMDLkZTb4+KPtqJl+RTHaex6zG+WYKSWJ0J+jof4SaeITiIUaTAICx0LFYctEzwKEJ0skoDkhmi5N+UJloOIjvtdH0jNFgeju5rYFCOzmYoqiPdzAxn3Rp1Ffo9qIYDcoSWI0/K+ETw0YymoKlZS7vk4Q7kj+GiLcqCipjiMd+eKvHGdZe/6zP984DDxZo25vHRZ15VhmpEGQn4TmNcaPZTJBvy6S2RHmcnfbna/0KS2WjdEfR04x941iChDxAOi88YisT0SKBi4F8iE+pRdpydd8gdfYRQbFUnk= tilli@zuse-klappi";
  users = [zuse-tilli zuse-root klappi-root klappi-tilli];

  zuse = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtvIX2sEwAsNUau/+vKoMNcMbuqWH5zgueqEhoMzSJTjLh6ot5a2JDCavH1JAoIsmurXayas6LmkH/Ye/QJudNGzghpOlK806EAQrlE4Bm1JCehi2htTAFTXORUnvfW6xeBVVHYEMV03EBDs9n4Eg7XZ9rjlKAv/UodBeAPUb33kySpIhuIcSW0FKW5L/KrrN5HrOyf4XHfLna/8f8fL0zchcF3rb7aPtJCpK7jmFaEUo+PcZ3gwIn7tjjc2TtzKw7APn9Ysr3ihuX3lRwFRj8dQ9nuds+jAYLGCGR+Y3SeB5B/JaPU7Wy71aKOj8MK/eS1CV4i3+o2uknzNK5EA0C9kV201DkXRz7ZvFIUKTVeKvy7mYHF4HR4nSlPnvSJWGieFIUX2YXiXqE26c9OUFWgoKdvvGkyvK7oFFcIjkm1bNKOCm55P24YYdv5LEPY6sLfw7sDlLNfmg3d+qDNfgxpfbM9HjDkqMhQ3uoTjSmBIE2/oc+OuOvr9r0JTU9Q8uqhd5PV71gjotEdKFoqON/1RemiTxdzll9XDArcPwRo+hDuIjoMuAgJA9bHC2TjD1T1N/YesOtyfmlgVbnwtPvB2gk1qox11pewz+E0lfSm4Jle0aYKurefZJD3UICw44R3EKR+sKzS1GXgh1+3Hs5KkM1qYA3VXHr5XhXSuxnvQ== root@zuse";
  klappi = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCxIxDnFpb4nnYUOWipTR2+6zbI52/QLIkMYaWjMfuvSVTppQu0JREQsA3PA7StOGx8HbcQi9YimDzkOc5akMHnq3SJ4jN4RlrBQYUgfD9jORb8RFI6+UkGU0HzH2itypzZ/OVMHilE8T2LwTY6o8NIyPWe2i5tXEdQ3kFzEHfziHAMmMm/Pa85LRh6cellVRXloz4GO5YNyQ5z4+YWC8v2meG+nhC9QvTzyOtu++tT0SGx1V4mKE6ppHnvB6JVsKMiGg5b6VMDBE92AfWnldRugs6zgNDzWZbFc1Bhc+tseuuK0rkeCohqVSjeL4YvZCS2fGmOxnL0yYhXDMWG2IJMAdRv5tSWzbOOjZIWTwOYeIirCeOxeT3ploBMGLorKcL6fL9gJXU7FdUJUHqHDxPAnLOOwNKJDcj/HU6lCryW93s3+91+H+IWfHjbtGgXwXqe6fNSn35Ql2T9wYBsJ0cZ57l2rgh0A5Drg+a+AO85UU7BV1HxkUntapeH0IyPTx8fIXrnjXqZUZQkFabzZZMBDbw3L0Lt686TMrYt4vrkP4Yuk8ko9bg2IXQgmJcd+Achl6LJkHfWYKrce1ry0PcmFtFITVs+J8xfBG5PCZjlMjX/DdySr9Eh0cmvavZTtwGtVgNVY6QWpdAa8PXf92p1phueLKwKbHGn5a4HGsXnQQ== root@zuse-klappi";
  nas = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnZhxtjILjyF9nrD3+sUu0qjnc3OqI/fGOpXrdXbl3trYxugXch3aywo42MZn2kKaEIyf6Ig63IcDq9bsKxi2oQOiC9OawiXWAegBRa6uPdwA3HGkyYAz9Nqd9R5InUe1Xw33Jf0yRwAbYgrL5hd6I5KVSheOjF4m6854ybs8r72CM19sMmCTBhri5W84VmgnWu/7PpNjygsnRR+Xw2OgoW1y+qDanftvKEobPvbmhJVO/fmgFwXDh/S6ep/cZKik7rwWPDw59pKU/DjOpTNWMeWXDCeczsDZM7v40HSapofB6jDmgpKFuZXk0kDprLl+cSVHPtFbiHFyI0b/EZCje3lgYaht7W34h9/UFGb0IHGNg/W+TntBtaAm9T/XzQwdLs9ofJWpG2x5vKgPZQFc5tX+39Dk5vwlOIWEQEu3wBuRefH2oi24tgytursAkuj5C7Ux2jkZDP7JnHyCsaqHa0MdVQhS2wW+fxceBDasf4GSzCXWKqoEvoksq2+cQw/KOVFqHL6+uYMlmpi/nmzd6fdzSOtGI/2shxIY2RIBMuON8NfN/oNHXQPJDyGxTg/mC/YYkJT+vDtm+pU4WIfo+xePROslPQ+Xa9ooB4tFtvVIm9xxVuz/PpT0IeiWHvdl/V/NgX9DLwm9GeS+8eUPyxVNX8UREErgipdK2Ntx01w== root@nas";
  systems = [zuse klappi nas];
in {
  "cloak-accounts.age".publicKeys = users ++ systems;
  "vpn-password.age".publicKeys = users ++ systems;
  "restic-password.age".publicKeys = users ++ systems;
  "restic-garage-credentials.age".publicKeys = users ++ systems;
  "tilli-id_rsa.age".publicKeys = users ++ systems;
  "direnv-backup-garage.age".publicKeys = users ++ systems;
  "direnv-backup-rsync-net.age".publicKeys = users ++ systems;
  "tailscale-key.age".publicKeys = users ++ systems;
  "openrc-fs.stackxperts.com.age".publicKeys = users ++ systems;
  "stack_baumann-cbxgate.cbxnet.de.ovpn.age".publicKeys = users ++ systems;
  "stack_baumann-cbxgate_cbxnet_de-password.age".publicKeys = users ++ systems;
  "nix-access-tokens-github.age".publicKeys = users ++ systems;
  "gist-cli.age".publicKeys = users ++ systems;
  "arr-api-key.age".publicKeys = users ++ systems;
  "grafana-password.age".publicKeys = users ++ systems;
  "grafana-secret.age".publicKeys = users ++ systems;
}

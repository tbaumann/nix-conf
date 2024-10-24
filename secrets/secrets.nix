let
  zuse-tilli = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD06odwjYayF8YNuuzVydz5/aA8oo7HuPi/S1L7spbxRDU9h+QnSgOlrQkky1g8s+x39MHMLUF/6SZOOQHinBCecTmpGUF/QpPjWSQHafIURjat3L4dScsupVc+IwmbDgLkUxMux/PLkfzxk2YdqpojzcILI5kvGNR2PPEs/vYp2+nqry9TjDfz4OCv4b+FtjqzlZalrSbt9wkTTWK/Sd7AlAQegkOLKB+IrBORIEKknYC+UnyCr5HH+aAD0qgKp3cxh2dIUUEDu3wSyCzv/nus1NqHIaNSfCxwNNrUd53XJOg2wwIV8NQZ0R7md4wYwdWR/I5DM9iH8ckj8kkj/isyKC49vfuOucsQhApQErM4TYVbO5Ckym72TzUUJYzaRVgVAOfOnCsrjW9ihh/RSYWTFnjq6X8QUp6NX3BdUYyoKtxvbKzFdggNPEr4hLpSfOJzHqFJCdH2lyC8Apd1Y56Km+eBz/46kbvaUCvwfgSbQr/lOQzWq63w3S7lnB597/c= tilli@zuse";
  zuse-root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHt8WgsMjrt+0FVzxAjv+5FwHfMZuSMfFdJy7Hr5X5sV root@zuse";
  klappi-root = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCFj8KQiKdv7do5srBQIkN0Y2/M+n4oB0n6WdVqBHvgSE3vtuR60wV59KOGcm0bW1UWpMJk3XoOpXT8K7ep/pPjUPVtifuk2qHUuA1xb/BAydQCjawHuQfzYtAhg1j3Rc0yC/EKFLAdqRm1D8s4BnHodLH1M9fkCUrxm9K1sklyPPZIS2AR6h4ADh3AQgi4OBgxuicV6Wdj39/bCF+ve9gvlEqev0VCF9eYPSDgEe+npZa71GpvDtKSwWFYzzOtGFR4PVGWRmcYZgAjtSesMZu4n/E52Do5r3MaM7C1xRtonhfyef1ktwP6UHSARRuIVB5j0nXifZb7+TeCdQh8LveXgB0iVP+KEAxZ8dQptG24BGQgA7AAcn6SVz+onnsMuGL3P+qrN1EADpZfL2dpVYf7D5clDDEpVCqAf2UoLkbCr8TbBA8BGPl1EA7c50O9YSY8NnwczfxY0/fBLqOHzhuRNl4XuvktY4jsHLdl9NF+kuE0pC9P9+IHtuOkpIr0jGU= root@zuse-klappi";
  klappi-tilli = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHV2grChMteVSJYEfW4mHagZlcyAtTszKd2AfK++/6l5FLpPMdP+Ly8kLP2YO8jc3ThDBxMxhNO/SuALkcS3A/3NkswE/khyqYJFgR5gIbMNwFPerrDc7jEmSzHFIbsGOv73OEjnjiyDklYWHZYl/S5gKMLIKJEP+ou8OmmqAWmhFtd3kpkzkKgt9TMwLqcUvskyA4qzRtG0Sc9ED70lLMsLD2ymbYMDLkZTb4+KPtqJl+RTHaex6zG+WYKSWJ0J+jof4SaeITiIUaTAICx0LFYctEzwKEJ0skoDkhmi5N+UJloOIjvtdH0jNFgeju5rYFCOzmYoqiPdzAxn3Rp1Ffo9qIYDcoSWI0/K+ETw0YymoKlZS7vk4Q7kj+GiLcqCipjiMd+eKvHGdZe/6zP984DDxZo25vHRZ15VhmpEGQn4TmNcaPZTJBvy6S2RHmcnfbna/0KS2WjdEfR04x941iChDxAOi88YisT0SKBi4F8iE+pRdpydd8gdfYRQbFUnk= tilli@zuse-klappi";
  users = [zuse-tilli zuse-root klappi-root klappi-tilli];

  zuse = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2tuzqmM0R7WRXiTAbb6r712ujECDsj9/qrGbEx1Wph root@zuse-klappi";
  zuse2 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDbIBUkR3kYC62GTpzgXSmv79TolRcReXwPs385cf6ndwRBLOz98imcHnspNQPw8RN5sKHoKBfR6WOLNxwwtHbbo1Kjn8gpUKKNU8VXPuA0hMfgqCxu+VLfkFXJz7NP9cBeItKxUBXq44e7r9qGF5b7nrN6KxH8eWsCe4K86MQj2vLdpF6x4K6NKUs1LHdGCMfQLpu7QY8F7cNleFrMihl4Gvo/13NFF/BgfWJo6niukmV4PVy1vvfKLqY9o/cwNyUxEMpO5pqinM2dDbyax3yOqCKjEFsxBy+tC8ggbrXKNOxa9OcyPO44B054jrjBZp+jjryR/raiTnunk9OKUUWaaiReVV404x7zJYBQih3mtEgt8xMATCDLoirogU3SuVMQIxe447xWvALZ5EEMFv1CE0vqgBJ6bvgy9f9P+6yWAX7TfuKimrGDP0/S+++kUrzFVl87FIg2sfJF6y0CNpwtkTCL6GryjTjkQNRHZDkUQ3GgghKRxJUJP6UdhxPoGZHmQWfm/7ag6QX3bsuQF54SptzJS50f2pYW+Ckq8EHmAxAkkyEHRp8rNSOtiwyNrnk6fvCZre36s9XjPJXgptUMr4cICQokT4+fwZ1Y99iMRiTiGknyr7E7YVKcEltsLHrGFQBmgPjVPGDcuBFvSNDe2b9vF6CEch2ITSeXGAM80w== root@zuse-klappi";
  klappi1 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCTtHvCTeYb/Ck4aKA4yA5Do6P9hz0qZZ0Gte+3HaOZ8lX4UdKh/E3BkHxY2uYhh6LVWfMt7Q+1GfSgW+cKqFoDRoZoTsPpzmJBxpM/hbzJzXTVLe1Z04j2nAkSqj2mduPuL7OXuvGEosdEXufrQ5iDeUNMK8CO1ohCLroURO4JEbjokWjXR+a//vy4uNXnzCfYhG+qSgi/K9TvNQqSKQ4Umua8VT2uCJJJVDtonHqQdrxDTTGz28MT8OnM7LirxV7sYLaXL56H+dfzm3Wbch1Eb4OWpXgDHgExmKmuBWRYMPE+vqvMLlsyGfeg3VJAmm4+G9Oxj/CGjukEtdZz+cEoSL412WdfsfYJG9y4cZ5G+JdGomP0+0IF+fUx6hH96MOZsBkmQ/YbEUrsKqh5HpNIDxlAMSI82myzJK+vyleWeRpsHEvWqg/51Uip+EFYuA+Na0/qsrJ5WSnK7g0YmWkPgj7yFRZ0Kl7GrHSgvRTy9vfmIZvElY34elPg3zYPKhKGu0OhrikZX9o1p49bLhDCDb8yxKTU66xn8mM0vFPChegBxksveAierI42JrV6YEutQx+LJkVaUF9VH8BPFo7F08ZTXZEGwQy19S33eS9kZn/uSK2hXc/JyQ0NorcMZgTWlKkgof3ZKwh73iRzN521RyIpQARmtixAHQCwp0+mFw==";
  klappi2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGYb/dfkEbFjZGTbHkf0+/crW4EFehuA3JnZiy5rlooB";
  nas = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnZhxtjILjyF9nrD3+sUu0qjnc3OqI/fGOpXrdXbl3trYxugXch3aywo42MZn2kKaEIyf6Ig63IcDq9bsKxi2oQOiC9OawiXWAegBRa6uPdwA3HGkyYAz9Nqd9R5InUe1Xw33Jf0yRwAbYgrL5hd6I5KVSheOjF4m6854ybs8r72CM19sMmCTBhri5W84VmgnWu/7PpNjygsnRR+Xw2OgoW1y+qDanftvKEobPvbmhJVO/fmgFwXDh/S6ep/cZKik7rwWPDw59pKU/DjOpTNWMeWXDCeczsDZM7v40HSapofB6jDmgpKFuZXk0kDprLl+cSVHPtFbiHFyI0b/EZCje3lgYaht7W34h9/UFGb0IHGNg/W+TntBtaAm9T/XzQwdLs9ofJWpG2x5vKgPZQFc5tX+39Dk5vwlOIWEQEu3wBuRefH2oi24tgytursAkuj5C7Ux2jkZDP7JnHyCsaqHa0MdVQhS2wW+fxceBDasf4GSzCXWKqoEvoksq2+cQw/KOVFqHL6+uYMlmpi/nmzd6fdzSOtGI/2shxIY2RIBMuON8NfN/oNHXQPJDyGxTg/mC/YYkJT+vDtm+pU4WIfo+xePROslPQ+Xa9ooB4tFtvVIm9xxVuz/PpT0IeiWHvdl/V/NgX9DLwm9GeS+8eUPyxVNX8UREErgipdK2Ntx01w== root@nas";
  systems = [zuse zuse2 klappi1 klappi2 nas];
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
}

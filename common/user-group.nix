{pkgs, ...}: {
  nix.settings.trusted-users = ["tilli"];

  users.users = {
    root = {
      # the hashed password with salt is generated by run `mkpasswd`.
      #hashedPassword = "$y$j9T$E1RZJFBWTPAgrarxekptP1$sS1TvTbcfd05eQcrR/aysAcHQiw4dgGv5kZ5Y2c/ykB";
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD06odwjYayF8YNuuzVydz5/aA8oo7HuPi/S1L7spbxRDU9h+QnSgOlrQkky1g8s+x39MHMLUF/6SZOOQHinBCecTmpGUF/QpPjWSQHafIURjat3L4dScsupVc+IwmbDgLkUxMux/PLkfzxk2YdqpojzcILI5kvGNR2PPEs/vYp2+nqry9TjDfz4OCv4b+FtjqzlZalrSbt9wkTTWK/Sd7AlAQegkOLKB+IrBORIEKknYC+UnyCr5HH+aAD0qgKp3cxh2dIUUEDu3wSyCzv/nus1NqHIaNSfCxwNNrUd53XJOg2wwIV8NQZ0R7md4wYwdWR/I5DM9iH8ckj8kkj/isyKC49vfuOucsQhApQErM4TYVbO5Ckym72TzUUJYzaRVgVAOfOnCsrjW9ihh/RSYWTFnjq6X8QUp6NX3BdUYyoKtxvbKzFdggNPEr4hLpSfOJzHqFJCdH2lyC8Apd1Y56Km+eBz/46kbvaUCvwfgSbQr/lOQzWq63w3S7lnB597/c= tilli@zuse"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHV2grChMteVSJYEfW4mHagZlcyAtTszKd2AfK++/6l5FLpPMdP+Ly8kLP2YO8jc3ThDBxMxhNO/SuALkcS3A/3NkswE/khyqYJFgR5gIbMNwFPerrDc7jEmSzHFIbsGOv73OEjnjiyDklYWHZYl/S5gKMLIKJEP+ou8OmmqAWmhFtd3kpkzkKgt9TMwLqcUvskyA4qzRtG0Sc9ED70lLMsLD2ymbYMDLkZTb4+KPtqJl+RTHaex6zG+WYKSWJ0J+jof4SaeITiIUaTAICx0LFYctEzwKEJ0skoDkhmi5N+UJloOIjvtdH0jNFgeju5rYFCOzmYoqiPdzAxn3Rp1Ffo9qIYDcoSWI0/K+ETw0YymoKlZS7vk4Q7kj+GiLcqCipjiMd+eKvHGdZe/6zP984DDxZo25vHRZ15VhmpEGQn4TmNcaPZTJBvy6S2RHmcnfbna/0KS2WjdEfR04x941iChDxAOi88YisT0SKBi4F8iE+pRdpydd8gdfYRQbFUnk= tilli@zuse-klappi"
      ];
      shell = pkgs.bash;
    };
    tilli = {
      # the hashed password with salt is generated by run `mkpasswd`.
      hashedPassword = "$y$j9T$E1RZJFBWTPAgrarxekptP1$sS1TvTbcfd05eQcrR/aysAcHQiw4dgGv5kZ5Y2c/ykB";
      isNormalUser = true;
      description = "Tilman Baumann";
      extraGroups = [
        "adbusers"
        "cdrom"
        "dialout"
        "docker"
        "input"
        "kvm"
        "libusb"
        "libvirtd"
        "lp"
        "networkmanager"
        "plugdev"
        "podman"
        "scanner"
        "users"
        "wheel"
        "wireshark"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD06odwjYayF8YNuuzVydz5/aA8oo7HuPi/S1L7spbxRDU9h+QnSgOlrQkky1g8s+x39MHMLUF/6SZOOQHinBCecTmpGUF/QpPjWSQHafIURjat3L4dScsupVc+IwmbDgLkUxMux/PLkfzxk2YdqpojzcILI5kvGNR2PPEs/vYp2+nqry9TjDfz4OCv4b+FtjqzlZalrSbt9wkTTWK/Sd7AlAQegkOLKB+IrBORIEKknYC+UnyCr5HH+aAD0qgKp3cxh2dIUUEDu3wSyCzv/nus1NqHIaNSfCxwNNrUd53XJOg2wwIV8NQZ0R7md4wYwdWR/I5DM9iH8ckj8kkj/isyKC49vfuOucsQhApQErM4TYVbO5Ckym72TzUUJYzaRVgVAOfOnCsrjW9ihh/RSYWTFnjq6X8QUp6NX3BdUYyoKtxvbKzFdggNPEr4hLpSfOJzHqFJCdH2lyC8Apd1Y56Km+eBz/46kbvaUCvwfgSbQr/lOQzWq63w3S7lnB597/c= tilli@zuse"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHV2grChMteVSJYEfW4mHagZlcyAtTszKd2AfK++/6l5FLpPMdP+Ly8kLP2YO8jc3ThDBxMxhNO/SuALkcS3A/3NkswE/khyqYJFgR5gIbMNwFPerrDc7jEmSzHFIbsGOv73OEjnjiyDklYWHZYl/S5gKMLIKJEP+ou8OmmqAWmhFtd3kpkzkKgt9TMwLqcUvskyA4qzRtG0Sc9ED70lLMsLD2ymbYMDLkZTb4+KPtqJl+RTHaex6zG+WYKSWJ0J+jof4SaeITiIUaTAICx0LFYctEzwKEJ0skoDkhmi5N+UJloOIjvtdH0jNFgeju5rYFCOzmYoqiPdzAxn3Rp1Ffo9qIYDcoSWI0/K+ETw0YymoKlZS7vk4Q7kj+GiLcqCipjiMd+eKvHGdZe/6zP984DDxZo25vHRZ15VhmpEGQn4TmNcaPZTJBvy6S2RHmcnfbna/0KS2WjdEfR04x941iChDxAOi88YisT0SKBi4F8iE+pRdpydd8gdfYRQbFUnk= tilli@zuse-klappi"
      ];
    };
    chaimae = {
      # the hashed password with salt is generated by run `mkpasswd`.
      hashedPassword = "$y$j9T$RrQMJvvrcjk6ULZ4tWaym.$EtN2VcOJGS6TYclrRGWfIEjaALoavmfYq5BU35t9j46";
      isNormalUser = true;
      description = "Chaimae Nouina";
      extraGroups = [
        "cdrom"
        "input"
        "lp"
        "networkmanager"
        "plugdev"
        "scanner"
        "users"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD06odwjYayF8YNuuzVydz5/aA8oo7HuPi/S1L7spbxRDU9h+QnSgOlrQkky1g8s+x39MHMLUF/6SZOOQHinBCecTmpGUF/QpPjWSQHafIURjat3L4dScsupVc+IwmbDgLkUxMux/PLkfzxk2YdqpojzcILI5kvGNR2PPEs/vYp2+nqry9TjDfz4OCv4b+FtjqzlZalrSbt9wkTTWK/Sd7AlAQegkOLKB+IrBORIEKknYC+UnyCr5HH+aAD0qgKp3cxh2dIUUEDu3wSyCzv/nus1NqHIaNSfCxwNNrUd53XJOg2wwIV8NQZ0R7md4wYwdWR/I5DM9iH8ckj8kkj/isyKC49vfuOucsQhApQErM4TYVbO5Ckym72TzUUJYzaRVgVAOfOnCsrjW9ihh/RSYWTFnjq6X8QUp6NX3BdUYyoKtxvbKzFdggNPEr4hLpSfOJzHqFJCdH2lyC8Apd1Y56Km+eBz/46kbvaUCvwfgSbQr/lOQzWq63w3S7lnB597/c= tilli@zuse"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHV2grChMteVSJYEfW4mHagZlcyAtTszKd2AfK++/6l5FLpPMdP+Ly8kLP2YO8jc3ThDBxMxhNO/SuALkcS3A/3NkswE/khyqYJFgR5gIbMNwFPerrDc7jEmSzHFIbsGOv73OEjnjiyDklYWHZYl/S5gKMLIKJEP+ou8OmmqAWmhFtd3kpkzkKgt9TMwLqcUvskyA4qzRtG0Sc9ED70lLMsLD2ymbYMDLkZTb4+KPtqJl+RTHaex6zG+WYKSWJ0J+jof4SaeITiIUaTAICx0LFYctEzwKEJ0skoDkhmi5N+UJloOIjvtdH0jNFgeju5rYFCOzmYoqiPdzAxn3Rp1Ffo9qIYDcoSWI0/K+ETw0YymoKlZS7vk4Q7kj+GiLcqCipjiMd+eKvHGdZe/6zP984DDxZo25vHRZ15VhmpEGQn4TmNcaPZTJBvy6S2RHmcnfbna/0KS2WjdEfR04x941iChDxAOi88YisT0SKBi4F8iE+pRdpydd8gdfYRQbFUnk= tilli@zuse-klappi"
      ];
    };
  };
}

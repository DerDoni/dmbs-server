{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./disk-config.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  time.timeZone = "Europe/Berlin";
  networking.hostName = "alucard";

   users.users.vincenzo = {
     isNormalUser = true;
     extraGroups = [ "wheel" "docker" ];
     openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDj2dxqVTVKEzFUBw4Ol8G2XBwTHEwxFquzYNIelKBOzDQLE2WNvjfBko1iQkUNHrVfr3GiAuxdsE+O3hltDvo4UsQqsEqCSu/HEWRfyXDJrcLSm7ogkOAGBZtrmIr73YfGhpzRqcfnoAqSJOkX6PFmaFJ+YgoOuJLH6KbQo3xv0r5RqFkZhfnOiD5gwMtEExP4uawycb9mrsqxOWoMANR870qYq6JERxcGZU4m0UcvnpB01EbvTuWMIACL11cCylkcCPoDnv9KD94k0nhqGOE5/UB6mxRPBBJdQk3Dd3KXe2u2s++Enpu2WKdqOFywxxvXZ2PHBh4Oy8eJpytzMWxSUcLNcNk54JgAgaUCYYN0s3CmKh2r+z6pGSo5xUuJxyl13TfsSzCTsx3dkUOAaRpQAIHDseIDKX983zDS831GZA1d4xiOOtC7ct8F8z3qMokHU+N8OB0ys2T7cS29Q9BKSgaPSBlM0YTWQwD0R2Tf+D74VQnSYPgNNGFByZwV8bc= vincenzo@nixos"
  ];

   };

   users.users.kyrill = {
     isNormalUser = true;
     extraGroups = [ "wheel" "docker" ];
     openssh.authorizedKeys.keys = [
       "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJtziDwyaqKfBPL1dDEM6kMdA+KTL+d0810PzAbOsWHn kyrill@kyrill-ThinkPad-T495"
     ];
   };

   users.users.overleaf = {
     isNormalUser = true;
     extraGroups = [ "wheel" "docker" ];
   };

   users.users.jellyfin = {
     isNormalUser = true;
     extraGroups = [ "wheel" "docker" ];
     openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDj2dxqVTVKEzFUBw4Ol8G2XBwTHEwxFquzYNIelKBOzDQLE2WNvjfBko1iQkUNHrVfr3GiAuxdsE+O3hltDvo4UsQqsEqCSu/HEWRfyXDJrcLSm7ogkOAGBZtrmIr73YfGhpzRqcfnoAqSJOkX6PFmaFJ+YgoOuJLH6KbQo3xv0r5RqFkZhfnOiD5gwMtEExP4uawycb9mrsqxOWoMANR870qYq6JERxcGZU4m0UcvnpB01EbvTuWMIACL11cCylkcCPoDnv9KD94k0nhqGOE5/UB6mxRPBBJdQk3Dd3KXe2u2s++Enpu2WKdqOFywxxvXZ2PHBh4Oy8eJpytzMWxSUcLNcNk54JgAgaUCYYN0s3CmKh2r+z6pGSo5xUuJxyl13TfsSzCTsx3dkUOAaRpQAIHDseIDKX983zDS831GZA1d4xiOOtC7ct8F8z3qMokHU+N8OB0ys2T7cS29Q9BKSgaPSBlM0YTWQwD0R2Tf+D74VQnSYPgNNGFByZwV8bc= vincenzo@nixos"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJtziDwyaqKfBPL1dDEM6kMdA+KTL+d0810PzAbOsWHn kyrill@kyrill-ThinkPad-T495"
  ];

   };

   environment.systemPackages = with pkgs; [
     vim
     wget
     curl
     git
     btop
     eza
     yazi
     mullvad-vpn
     file
     which
     tree
     gnused
     gnutar
     gawk
     zstd
     gnupg
     zip
     xz
     unzip
     p7zip


   ];

   services = {
     openssh = {
       enable = true;
       settings.PasswordAuthentication = false;
       settings.KbdInteractiveAuthentication = false;
       settings.PermitRootLogin = "no";

     };

     syncthing = {
       enable = true;
       user = "vincenzo";
       openDefaultPorts = true;
       dataDir = "/home/vincenzo/";
       configDir = "/home/vincenzo/.config/syncthing";
       settings = {
        devices = {
        "dracula" = {
          id = "7FC5NNG-7XWTJH6-62MYNGC-ZY2WMTU-2XDIAD3-5IEBLD6-ALEN7NX-5HAQSAF";
          autoAcceptFolders = true;
        };
        "asgar" = {
          id = "H5KT7VJ-OFUH3PD-6HH4KRI-VKOOOMY-Z5KNIQL-DVTBCAN-PQ44EAY-AAAS7AO";
          autoAcceptFolders = true;
        };
      };
       folders = {
        "documents" = {
          id = "baqfs-svyhe";
          path = "/home/vincenzo/documents";
          devices = [ "dracula" "asgar" ];
          type = "sendreceive";
          enable = true;
          versioning = {
            type = "simple";
            params.keep = 5;
          };
        };
      "org" = {
          id = "cccdk-miidx";
          path = "/home/vincenzo/org";
          devices = [ "dracula" "asgar" ];
          type = "sendreceive";
          enable = true;
          versioning = {
            type = "simple";
            params.keep = 5;
          };
        };
      "code" = {
          id = "wnku3-6n7g5";
          path = "/home/vincenzo/code";
          devices = [ "dracula" "asgar" ];
          type = "sendreceive";
          enable = true;
          versioning = {
            type = "simple";
            params.keep = 5;
          };
        };
     };
   };
  };

  paperless = {
    enable = true;
    address = "0.0.0.0";
    port = 58080;
    extraConfig.PAPERLESS_OCR_LANGUAGE = "deu+eng";
  };
 };

  nix = {
    settings = {
      sandbox = true;
      max-jobs = 10; # should be 1 per CPU logical core
      auto-optimise-store = true;
      substituters = [
      "https://cache.nixos.org/"
      "https://ghcide-nix.cachix.org"
      "https://hercules-ci.cachix.org"
      "https://iohk.cachix.org"
      "https://nix-tools.cachix.org"
    ];
      trusted-public-keys = [
      "ghcide-nix.cachix.org-1:ibAY5FD+XWLzbLr8fxK6n8fL9zZe7jS+gYeyxyWYK5c="
      "hercules-ci.cachix.org-1:ZZeDl9Va+xe9j+KqdzoBZMFJHVQ42Uu/c/1/KMC5Lw0="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
      "nix-tools.cachix.org-1:ebBEBZLogLxcCvipq2MTvuHlP7ZRdkazFSQsbs0Px1A="
    ];
    };
    gc = {
      automatic = true;
      dates = "23:00";
      options = "--delete-older-than 30d";
    };
  };

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  system.stateVersion = "23.05";

}

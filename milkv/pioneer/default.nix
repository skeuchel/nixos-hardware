{ config, pkgs,  ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackagesFor (pkgs.callPackage ./linux.nix {
      inherit (config.boot) kernelPatches;
    });
    kernelParams = [
      "earlycon"
      "console=ttyS0,115200"
      "console=tty1"
      "nvme_core.io_timeout=600"
      "nvme_core.admin_timeout=600"
      "cma=512M"
      "swiotlb=65536"
      "fsck.mode=force"
    ];
  };
  hardware.deviceTree = {
    enable = true;
    name = "sophgo/mango-milkv-pioneer.dtb";
  };
}

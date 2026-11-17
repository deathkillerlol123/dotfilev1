{self, ...}: {
  flake.nixosModules.nixboom = {...}: {
    imports = with self.nixosModules; [gaming bluetooth sound touch intel lime];
    boot.kernelParams = ["snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" "8250.nr_uarts=1"];
    gaming.xbox.enable = true;
    boot.loader.limine.extraEntries = ''
      /Windows 10
        protocol: efi
        path: uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };
}

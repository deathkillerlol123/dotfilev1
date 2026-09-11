{self, ...}: {
  flake.nixosModules.nixboom = {...}: {
    imports = with self.nixosModules; [gaming bluetooth sound touch intel lime];
    boot.kernelParams = ["snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" "8250.nr_uarts=1"];

    environment.variables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json";
    environment.variables.VK_ICD_FILENAMES_32 = "/run/opengl-driver-32/share/vulkan/icd.d/intel_icd.i686.json";
    environment.variables.WLR_DRM_DEVICES = "/dev/dri/card0";
    environment.variables.MESA_LOADER_DRIVER_OVERRIDE = "iris";
    environment.variables.VK_DEVICE_SELECT = "Intel(R) Iris(R) Xe Graphics (TGL GT2)";
  };
}

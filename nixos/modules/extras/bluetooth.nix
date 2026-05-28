{inputs,self,...}:{
  flake.nixosModules.bluetooth = {config,lib,packages,inputs,...}:
  {
    hardware = {
      bluetooth = {
        enable = true;
	powerOnBoot = true;
	settings = {
          General = {
            Experimental = true;
            FastConnectable = true;
          };
          Policy = {
            AutoEnable = true;
          };
	};
      };
    };
  };
}
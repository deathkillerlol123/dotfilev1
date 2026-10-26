{inputs,moduleWithSystem,...}:{
   flake.nixosModules.<name> = moduleWithSystem ({pkgs,self',...}: { });
   perSystem = {pkgs,lib,...}: { };
   }

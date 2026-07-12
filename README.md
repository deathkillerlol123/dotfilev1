Nixos Config

I have currently written it using the dendritic pattern and tried to make it modular as possible. Instead of Declaring every config file for every user/host I wrote some code for a "helper function" in the home-manager configuration so that it takes the dots/{user} directory and uses the files for that specific user and makes symblinks to .config . I created 3 options so far: Creating multiple users, home-manager and 1 for using limine as a boot loader that also takes in a UUID for windows as I am dual booting.

I am currently using jj(Jujutsu) for my github repo.
Idk what else to write bro.
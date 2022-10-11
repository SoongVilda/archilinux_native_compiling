# Achilinux Native Compiling

This repository contains a script and a couple of tips for compiling native packages.

## !!! Requirements before you use this script !!!
### You need following packages
```
sudo pacman -S --needed pacman-contrib diffutils findutils mlocate sudo vim bs
```

### Know your CPU architecture
You need to know your CPU architecture to get the advantages of compiling. You can find out by the following command.
```
gcc -Q -march=native --help=target | grep march | awk '{print $2}' | head -1
```

Your output can looks for example like this:
```
$ gcc -Q -march=native --help=target | grep march | awk '{print $2}' | head -1
tigerlake
```

### Adjust your config file
You know the CPU architecture of your computer, let's adjust the file in ```etc/makepkg.conf```, find out section with ```CFLAGS=```, you can see that section below:
```
#-- Compiler and Linker Flags
#CPPFLAGS=""
CFLAGS="-march=x86-64 -mtune=generic -O2 -pipe -fno-plt -fexceptions \
        -Wp,-D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security \
        -fstack-clash-protection -fcf-protection"
```

You need to remove ```-mtune=generic``` and add your CPU architecture, in my case it's ```tigerlake``` in your case, you need add output from the terminal on your computer. My config file for tigerlake CPU looks like this: 
```
#-- Compiler and Linker Flags
#CPPFLAGS=""
CFLAGS="-march=tigerlake -O2 -pipe -fno-plt -fexceptions \
        -Wp,-D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security \
        -fstack-clash-protection -fcf-protection"
```

You can also use the ```native``` flag, which will automatically detect all flags compatible with your architecture.
Use this solution when the result from the previous one is ambiguous or you suspect that the information may be wrong. 
```

#-- Compiler and Linker Flags
#CPPFLAGS=""
CFLAGS="-march=native -O2 -pipe -fno-plt -fexceptions \
        -Wp,-D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security \
        -fstack-clash-protection -fcf-protection"
```
## !!! Remember not to share packages compiled in this way, as they are unlikely to work for other users !!!
## Dependencies
Script depends on two packages, impossible to run correctly without the following packages.
- ```bc``` https://archlinux.org/packages/extra/x86_64/bc/
- ```paru``` https://aur.archlinux.org/packages/paru
- If you are more familiar with ```yay``` don't worry, you can use both ```yay``` or ```paru```, the choice depends on your decision.

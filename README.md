# Guix System or NixOS system test

I plan to replace LEAP 16 with Xfce/X11 with something else, because SUSE now intentionally cripples, breaks
packages (I already use Guix package manager to replace broken/missing `audacious`, `keepass`, `wine`, `virt-viewer`... in LEAP 16)

I'm unable to decide, what is better, so I decided to spin 2 VMs

1. VM Guix System (formerly known as GuixSD) with Xfce using ISO: `guix-system-install-1.5.0.x86_64-linux.iso`
2. VM NixOS System with Xfce using ISO: `latest-nixos-graphical-x86_64-linux.iso`

Let's start!

# After installation

Problem: NixOS had not enable sshd (Guix installer offered that as option). So I had to:
- login locally to NixOS
- run `sudo nano /etc/nixos/configuration.nix`
- uncomment `services.openssh.enable = true;`
- next apply this change with: `sudo nixos-rebuild switch`
- right after that command I was able to login remotely via SSH (no reboot needed!)



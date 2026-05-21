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

# Important differencies

* NixOS uses `ligthdm` Session Manager (I like it) while Guix sticks to GDM (which is actually Gnome Shell
  with `--gdm` switch). I will handle that later...

# Adding essential CLI packages

Now I will add system-wide important packages: `git mc tmux vim` and for Guix also `rsync`

For Guix I have to run first (otherwise really bad things will happen - as `root` - it has its own cache!):

Edit `/etc/config.scm` and apply changes from commit: [b861cd5](https://github.com/hpaluch/guix-or-nix/commit/b861cd5ae196467799c28367c0699682a1401351)

Then:

```shell
sudo bash
# as root:
guix pull
# after 1st pull you have to run:
source ~/.bash_profile
hash guix
```

To apply changes:
```shell
# as root:
source ~/.bash_profile
guix system reconfigure /etc/config.scm

# commands should start working immediatelly (as long as you have loaded profile)
$ git --version
git version 2.54.0
# Note: should run "reboot" to apply all changes...
```




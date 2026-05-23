;; /etc/config.scm for VM guix-home (Xfce)
(use-modules (gnu) (guix packages) (srfi srfi-1))
(use-service-modules cups desktop lightdm networking sddm ssh xorg)
(use-package-modules linux mc tmux rsync version-control vim)

(operating-system
  (locale "en_US.utf8")
  (timezone "Europe/Berlin")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "guix-home")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "user")
                  (comment "User")
                  (group "users")
                  (home-directory "/home/user")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; add system wide package
  (packages (append (list git mc rsync strace tmux vim) %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (cons* (service xfce-desktop-service-type)
                 (service lightdm-service-type)

                 ;; To configure OpenSSH, pass an 'openssh-configuration'
                 ;; record as a second argument to 'service' below.
                 (service openssh-service-type)
                 (service cups-service-type)
                 ;; (set-xorg-configuration (xorg-configuration (keyboard-layout keyboard-layout)))

                 ;; from gnu/system/examples/plasma.tmpl
                 ;; Remove GDM if it's among %DESKTOP-SERVICES; on other
                 ;; architectures, %DESKTOP-SERVICES contains SDDM instead.
                 (remove (lambda (service)
                       (memq (service-kind service)
                             (list gdm-service-type sddm-service-type)))
                     %desktop-services)))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "85aac587-82e7-453a-9a5d-0221801078ab")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "4ff928c5-1e02-443c-aea3-9e6a219d1c69"
                                  'btrfs))
                         (type "btrfs"))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "127E-F135"
                                       'fat32))
                         (type "vfat")) %base-file-systems)))

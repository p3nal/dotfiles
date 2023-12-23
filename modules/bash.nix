{
  pkgs,
  inputs,
  ...
}: {
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      lah = "ls -laht";
      ".." = "cd ..";
      msnw = "mount /mnt/snw";
      usnw = "umount /mnt/snw";
      snw = "cd /mnt/snw";
      bkup = "ionice -c 3 rsync -auvhP /home/penal/Sync /home/penal/.dotfiles /home/penal/Movies /mnt/snw";
      projbkup = "ionice -c 3 rsync -auvhP /home/penal/Playground /home/penal/Projects /mnt/snw --include='**.gitignore' --filter=':- .gitignore' --delete-after";
      scan = "iwctl station wlan0 scan && iwctl station wlan0 get-networks";
      connect = "iwctl station wlan0 connect";
      up = "systemctl start";
      down = "systemctl stop";
      z = "zathura";
      duh = "du . -h --max-depth 0 | awk '{print(\$1)}'";
      # see https://github.com/russelltg/wl-screenrec
      record = ''wl-screenrec -f Videos/screenrec-"`date +%a-%d-%b-%H-%M-%S`".mp4'';
      recordarea = ''wl-screenrec -g "`slurp -w 0`" -f Videos/screenrec-"`date +%a-%d-%b-%H-%M-%S`".mp4'';
    };
    enableCompletion = true;
    profileExtra = ''
      if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec Hyprland
      fi
      export XDG_DATA_DIRS="''$HOME/.nix-profile/share:''${XDG_DATA_DIRS}"
    '';
    bashrcExtra = ''
      # Enable school proxy
      function pe() {
      	export http_proxy="http://10.23.201.11:3128/"
      	export https_proxy=$http_proxy
      	export ftp_proxy=$http_proxy
      	export rsync_proxy=$http_proxy
      	export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
      	export HTTP_PROXY=$http_proxy
      	export HTTPS_PROXY=$http_proxy
      	export FTP_PROXY=$http_proxy
      	export RSYNC_PROXY=$http_proxy
      	echo -e "Proxy environment variables set."
      }

      # Disable school proxy
      function pd() {
      	unset http_proxy https_proxy ftp_proxy rsync_proxy \
      		  HTTP_PROXY HTTPS_PROXY FTP_PROXY RSYNC_PROXY \
      		  no_proxy
      	echo -e "Proxy environment variables removed."
      }
    '';
  };
}

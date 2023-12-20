{ inputs, pkgs, config, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;

        modules-left = [ "custom/nixos-logo" "temperature" "hyprland/workspaces" "hyprland/submap" "custom/media" ];
        modules-center = [ "idle_inhibitor" "clock" ];
        modules-right = [ "pulseaudio" "network" "disk" "backlight" "battery#bat0" "battery#bat1" "tray" ];


        "custom/nixos-logo" = {
          format = " 󱄅 ";
          tooltip = false;
          on-click = "chpaper";
        };

        keyboard-state = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          on-click = "activate";
        };
        "hyprland/submap" = {
          "format" = "<span style=\"italic\">{}</span>";
          "tooltip" = false;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          spacing = 10;
        };
        clock = {
          interval = 60;
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          # format-alt = "{:%Y-%m-%d}";
          format-alt = "{:%a, %b %d, %Y (%R)}";
          "calendar" = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "";
            "on-click-right" = "mode";
            "format" = {
              "months" = "<span color='#${config.colorScheme.colors.base0D}'><b>{}</b></span>";
              "days" = "<span color='#${config.colorScheme.colors.base0B}'><b>{}</b></span>";
              "weeks" = "<span color='#${config.colorScheme.colors.base0A}'><b>W{}</b></span>";
              "weekdays" = "<span color='#${config.colorScheme.colors.base0F}'><b>{}</b></span>";
              "today" = "<span color='#${config.colorScheme.colors.base08}'><b><u>{}</u></b></span>";
            };
          };
          "actions" = {
            "on-click-right" = "mode";
            # "on-scroll-up" = "shift_up";
            # "on-scroll-down" = "shift_down";
          };
        };
        disk = {
          format = "{free} 󰋊";
          path = "/";
        };
        backlight = {
          format = "{percent}% {icon}";
          on-scroll-up = "light -A 1";
          on-scroll-down = "light -U 1";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
        };
        "battery#bat0" = {
          adapter = "AC";
          bat = "BAT0";
          states = {
            warning = 30;
            critical = 10;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [ "" "" "" "" "" ];
        };
        "battery#bat1" = {
          bat = "BAT1";
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [ "" "" "" "" "" ];
        };
        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        pulseaudio = {
          states = {
            high = 80;
          };
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = "󰝟 {icon} {format_source}";
          format-muted = "󰝟 {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
        };
      };
    };

    style = ''
                * {
                  border: none;
                  font-family: JetBrainsMono, Font Awesome, Roboto, Arial, sans-serif;
                  font-size: 13px;
                  color: #${config.colorScheme.colors.base07};
                  border-radius: 20px;
                }

                window {
                  font-weight: bold;
                }

                window#waybar {
                  background: rgba(0, 0, 0, 0);
                }

                /*-----module groups----*/
                .modules-right {
                  background-color: @theme_base_color;
                  color: @theme_text_color;
                  margin: 4px 10px 0 0;
                }
                .modules-center {
                  background-color: @theme_base_color;
                  color: @theme_text_color;
                  margin: 4px 0 0 0;
                }
                .modules-left {
                  margin: 4px 0 0 10px;
                  background-color: @theme_base_color;
                  color: @theme_text_color;
                }
                /*-----modules indv----*/
                  #workspaces button {
                    padding: 1px 5px;
                    background-color: transparent;
                  }
                  #workspaces button:hover {
                    box-shadow: inherit;
                    background-color: #${config.colorScheme.colors.base0B};
                  }
                  #custom-nixos-logo button:hover {
                    box-shadow: inherit;
                    background-color: #${config.colorScheme.colors.base0B};
                  }

                  #workspaces button.focused {
                    background-color: #${config.colorScheme.colors.base09};
                    color: #${config.colorScheme.colors.base01};
                  }

                  #workspaces button.focused {
                      background-color: #64727D;
                      box-shadow: inset 0 -3px #ffffff;
                  }


                  #clock,
                  #backlight,
                  #disk,
                  #battery,
                  #cpu,
                  #memory,
                  #temperature,
                  #network,
                  #pulseaudio,
                  #custom-media,
                  #tray,
                  #idle_inhibitor {
                    padding: 0 10px;
                  }
                  /*-----Indicators----*/
                  #idle_inhibitor.activated {
                    color: #${config.colorScheme.colors.base0B};
                  }
                  #pulseaudio.muted {
                    color: #${config.colorScheme.colors.base08};
                  }
                  #pulseaudio:not(.high) {
                    color: #${config.colorScheme.colors.base09};
                  }
                  #battery.charging {
                    color: #${config.colorScheme.colors.base0C};
                  }
                  #battery.warning:not(.charging) {
                    color: #${config.colorScheme.colors.base0A};
                  }
                  #battery.critical:not(.charging) {
                    color: #${config.colorScheme.colors.base08};
                  }
                  #clock.calendar {
                    font-size: 8px;
                  }
            	  '';
  };
}

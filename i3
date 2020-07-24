###############################################################################
# i3-gaps config file for the Regolith Desktop Environment
#
# Please see http://i3wm.org/docs/userguide.html for a complete reference!
# 
###############################################################################
#
# In this config file, may values are taken from Xresources with the directive 
# set_from_resource:
#
# set_from_resource <i3 variable name> <Xresources key> <default value>
# 
# This configuration file utilizes Xresource variables to enable users to
# change the configuration without having to make a copy of this config file.
# The benefit to not copying this file is easier upgrading in the future.
# To update a value in this config without making a copy, update the Xresource 
# value in the file ~/.config/regolith/Xresources.
# 
# For example, to change the bar position to the top of the screen this is the
# i3 config entry:
# set_from_resource $i3-wm.bar.position i3-wm.bar.position bottom
#
# So add this line to ~/.config/regolith/Xresources to change it's value:
# i3-wm.bar.position: top
#
# Reload i3 after making Xresource changes.  Learn more at 
# https://regolith-linux.org/docs/howto/override-xres/
#
###############################################################################
#
# This file uses a machine-parsable format for comments. The schema:
# ## <Category> // <Action> // <Keybinding> ##
# Learn more at https://github.com/regolith-linux/remontoire
#
###############################################################################

###############################################################################
# Meta Key Mappings
# Alt key is Mod1, and Windows key is Mod4
###############################################################################

set_from_resource $mod  i3-wm.mod Mod4
set_from_resource $alt  i3-wm.alt Mod1

###############################################################################
# Workspace Names
# These are the labels which define each i3 workspace.
###############################################################################

set_from_resource $ws1  i3-wm.workspace.01.name "1"
set_from_resource $ws2  i3-wm.workspace.02.name "2"
set_from_resource $ws3  i3-wm.workspace.03.name "3"
set_from_resource $ws4  i3-wm.workspace.04.name "4"
set_from_resource $ws5  i3-wm.workspace.05.name "5"
set_from_resource $ws6  i3-wm.workspace.06.name "6"

###############################################################################
# Launcher dialogs
###############################################################################

## Launch // Terminal // <> Enter ##
bindsym $mod+Return exec /usr/bin/x-terminal-emulator

## Launch // Browser // <><Shift> Enter ##
bindsym $mod+Shift+Return exec gtk-launch $(xdg-settings get default-web-browser)

## Launch // Browser // <><Shift> Enter ##
bindsym $mod+Ctrl+Return exec /usr/bin/slack

set_from_resource $rofiTheme rofi.theme /etc/regolith/styles/lascaille/rofi.rasi

## Launch // Application // <> Space ##
set_from_resource $i3-wm.program.launcher.app i3-wm.program.launcher.app rofi -show drun -theme $rofiTheme
bindsym $mod+space exec $i3-wm.program.launcher.app

## Launch // Command // <><Shift> Space ##
set_from_resource $i3-wm.program.launcher.cmd i3-wm.program.launcher.cmd rofi -show run -theme $rofiTheme
bindsym $mod+Shift+space exec $i3-wm.program.launcher.cmd

## Navigate // Window by Name // <><Ctrl> Space ##
set_from_resource $i3-wm.program.launcher.window i3-wm.program.launcher.window rofi -show window -theme $rofiTheme
bindsym $mod+Ctrl+space exec $i3-wm.program.launcher.window

## Launch // This Dialog // <><Shift> ? ##
set_from_resource $i3-wm.program.help i3-wm.program.help /usr/bin/remontoire-toggle
bindsym $mod+Shift+question exec --no-startup-id $i3-wm.program.help

## Launch // File Search // <><Alt> Space ##
set_from_resource $i3-wm.program.file_search i3-wm.program.file_search rofi -show find -modi find:/usr/share/rofi/modi/finder.sh
bindsym $mod+$alt+space exec $i3-wm.program.file_search

###############################################################################
# Window and Workspace Navigation
###############################################################################

## Navigate // Relative Window // <> k j h l ##
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

## Modify // Window Position // <><Shift> k j h l ##
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

## Navigate // Workspaces 1-10 // <> 0..9 ##
bindsym $mod+1 workspace number $ws1
bindsym $mod+2 workspace number $ws2
bindsym $mod+3 workspace number $ws3
bindsym $mod+4 workspace number $ws4
bindsym $mod+b workspace " Brave "
bindsym $mod+s workspace " Slack "
bindsym $mod+o workspace " Org Mode "

## Navigate // Next Workspace // <> Tab ##
bindsym $mod+Tab workspace next
bindsym $mod+Shift+Tab workspace prev

## Navigate // Next Workspace // <><Alt> → ##
bindsym $mod+$alt+Right workspace next
bindsym $mod+$alt+Left workspace prev

###############################################################################
# Window and Workspace Configuration
###############################################################################

## Modify // Containing Workspace // <><Ctrl><Shift> ↑ ↓ ← → ##
bindsym $mod+Left move workspace to output left
bindsym $mod+Down move workspace to output down
bindsym $mod+Up move workspace to output up
bindsym $mod+Right move workspace to output right

## Modify // Next Window Orientation // <> Backspace ##
bindsym $mod+v split toggle

## Modify // Window Fullscreen Toggle // <> f ##
bindsym $mod+f fullscreen toggle

## Modify // Window Floating Toggle // <><Shift> f ##
bindsym $mod+Shift+f floating toggle

## Modify // Move Window to Workspace 1 - 10 // <><Shift> 0..9 ##
bindsym $mod+Shift+1 move container to workspace number $ws1
bindsym $mod+Shift+2 move container to workspace number $ws2
bindsym $mod+Shift+3 move container to workspace number $ws3
bindsym $mod+Shift+4 move container to workspace number $ws4
bindsym $mod+Shift+b move container to workspace " Brave "
bindsym $mod+Shift+s move container to workspace " Slack "
bindsym $mod+Shift+o move container to workspace " Org Mode "

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod
hide_edge_borders smart

###############################################################################
# Session Management
###############################################################################

## Session // Exit App // <><Shift> q ##
bindsym $mod+q [con_id="__focused__"] kill

## Session // Reload i3 Config // <><Shift> c ##
bindsym $mod+Shift+c reload

## Session // Refresh Session // <><Shift> r ##
set_from_resource $i3-wm.program.refresh_ui i3-wm.program.refresh_ui /usr/bin/regolith-look refresh
bindsym $mod+Shift+r exec --no-startup-id $i3-wm.program.refresh_ui

## Session // Restart i3 // <><Ctrl> r ##
bindsym $mod+Ctrl+r restart

## Session // Lock Screen // <> Escape ##
set_from_resource $i3-wm.program.lock i3-wm.program.lock dbus-send --type=method_call --dest=org.gnome.ScreenSaver /org/gnome/ScreenSaver org.gnome.ScreenSaver.Lock
bindsym $mod+Escape exec $i3-wm.program.lock

###############################################################################
# System Management
###############################################################################

## Launch // File Browser // <><Shift> n ##
set_from_resource $i3-wm.program.files i3-wm.program.files /usr/bin/nautilus --new-window
bindsym $mod+Shift+v exec $i3-wm.program.files

## Launch // Notification Viewer // <> n ##
set_from_resource $i3-wm.program.notification_ui i3-wm.program.notification_ui /usr/bin/rofication-gui
bindsym $mod+Shift+n exec $i3-wm.program.notification_ui

###############################################################################
# Workspace Management
###############################################################################
#
# Cause Settings app to float above tiled windows
floating_maximum_size -1 x -1
for_window [class="Gnome-control-center"] floating enable

###############################################################################
# Window Resize and Gaps
###############################################################################

## Resize // Enter Resize Mode // <> r ##
mode "Resize Mode" {
        # These bindings trigger as soon as you enter the resize mode

        ## Resize // Resize Window // ↑ ↓ ← → ##
        bindsym Left resize shrink width 6 px or 6 ppt
        bindsym Down resize grow height 6 px or 6 ppt
        bindsym Up resize shrink height 6 px or 6 ppt
        bindsym Right resize grow width 6 px or 6 ppt

        bindsym Shift+Left resize shrink width 12 px or 12 ppt
        bindsym Shift+Down resize grow height 12 px or 12 ppt
        bindsym Shift+Up resize shrink height 12 px or 12 ppt
        bindsym Shift+Right resize grow width 12 px or 12 ppt

        ## Resize // Resize Window // k j h l ##
        bindsym h resize shrink width 6 px or 6 ppt
        bindsym k resize grow height 6 px or 6 ppt
        bindsym j resize shrink height 6 px or 6 ppt
        bindsym l resize grow width 6 px or 6 ppt

        bindsym Shift+h resize shrink width 12 px or 12 ppt
        bindsym Shift+k resize grow height 12 px or 12 ppt
        bindsym Shift+j resize shrink height 12 px or 12 ppt
        bindsym Shift+l resize grow width 12 px or 12 ppt

        ## Resize // Window Gaps // + - ##
        bindsym minus gaps inner current minus 5
        bindsym plus gaps inner current plus 5
        bindsym Shift+minus gaps inner current minus 10
        bindsym Shift+plus gaps inner current plus 10

        ## Resize // Exit Resize Mode // Escape or Enter ## 
        bindsym Return mode "default"
        bindsym Escape mode "default"
        bindsym $mod+r mode "default"
}
bindsym $mod+r mode "Resize Mode"

###############################################################################
# i3 Appearance and Behavior
###############################################################################

# Disable titlebar
set_from_resource $i3-wm.window.border.size i3-wm.window.border.size 5
set_from_resource $i3-wm.floatingwindow.border.size i3-wm.floatingwindow.border.size 5
default_border pixel $i3-wm.window.border.size
default_floating_border pixel $i3-wm.floatingwindow.border.size

# Specify the distance between windows in pixels. (i3-gaps)
set_from_resource $i3-wm.gaps.inner.size i3-wm.gaps.inner.size 0
set_from_resource $i3-wm.gaps.outer.size i3-wm.gaps.outer.size 0
gaps inner 20
gaps outer 0

# Only enable gaps on a workspace when there is at least one container
set_from_resource $i3-wm.gaps.smart i3-wm.gaps.smart on
smart_gaps $i3-wm.gaps.smart

# Enable popup during fullscreen
set_from_resource $i3-wm.gaps.popup_during_fullscreen i3-wm.gaps.popup_during_fullscreen smart
popup_during_fullscreen $i3-wm.gaps.popup_during_fullscreen

# window focus follows your mouse movements as the mouse crosses window borders
set_from_resource $i3-wm.gaps.focus_follows_mouse i3-wm.gaps.focus_follows_mouse yes
focus_follows_mouse $i3-wm.gaps.focus_follows_mouse

###############################################################################
# i3 Colors and Fonts
###############################################################################

# Create variables from Xresources for i3's look.
set_from_resource $focused.color.border i3-wm.client.focused.color.border "#002b36"
set_from_resource $focused.color.background i3-wm.client.focused.color.background "#586e75"
set_from_resource $focused.color.text i3-wm.client.focused.color.text "#fdf6e3"
set_from_resource $focused.color.indicator i3-wm.client.focused.color.indicator "#268bd2"
set_from_resource $focused.color.child_border i3-wm.client.focused.color.child_border

set_from_resource $focused_inactive.color.border i3-wm.client.focused_inactive.color.border "#002b36"
set_from_resource $focused_inactive.color.background i3-wm.client.focused_inactive.color.background "#073642"
set_from_resource $focused_inactive.color.text i3-wm.client.focused_inactive.color.text "#839496"
set_from_resource $focused_inactive.color.indicator i3-wm.client.focused_inactive.color.indicator "#073642"
set_from_resource $focused_inactive.color.child_border i3-wm.client.focused_inactive.color.child_border

set_from_resource $unfocused.color.border i3-wm.client.unfocused.color.border "#002b36"
set_from_resource $unfocused.color.background i3-wm.client.unfocused.color.background "#073642"
set_from_resource $unfocused.color.text i3-wm.client.unfocused.color.text "#839496"
set_from_resource $unfocused.color.indicator i3-wm.client.unfocused.color.indicator "#073642"
set_from_resource $unfocused.color.child_border i3-wm.client.unfocused.color.child_border

set_from_resource $urgent.color.border i3-wm.client.urgent.color.border "#002b36"
set_from_resource $urgent.color.background i3-wm.client.urgent.color.background "#dc322f"
set_from_resource $urgent.color.text i3-wm.client.urgent.color.text "#fdf6e3"
set_from_resource $urgent.color.indicator i3-wm.client.urgent.color.indicator "#002b36"
set_from_resource $urgent.color.child_border i3-wm.client.urgent.color.child_border


# Window Border color
# class                 border                             background                         text                               indicator                                child_border
client.focused          $focused.color.border              $focused.color.background          $focused.color.text                $focused.color.child_border              $focused.color.child_border
client.focused_inactive $focused_inactive.color.border     $focused_inactive.color.background $focused_inactive.color.text       $focused_inactive.color.child_border     $focused_inactive.color.child_border
client.unfocused        $unfocused.color.border            $unfocused.color.background        $unfocused.color.text              $unfocused.color.child_border            $unfocused.color.child_border
client.urgent           $urgent.color.border               $urgent.color.background           $urgent.color.text                 $urgent.color.child_border               $urgent.color.child_border

# Create variables from Xresources for i3bars's look.
set_from_resource $i3-wm.bar.background.color i3-wm.bar.background.color "#002b36"
set_from_resource $i3-wm.bar.statusline.color i3-wm.bar.statusline.color "#93a1a1"
set_from_resource $i3-wm.bar.separator.color i3-wm.bar.separator.color "#268bd2"

set_from_resource $i3-wm.bar.workspace.focused.border.color i3-wm.bar.workspace.focused.border.color "#073642"
set_from_resource $i3-wm.bar.workspace.focused.background.color i3-wm.bar.workspace.focused.background.color "#073642"
set_from_resource $i3-wm.bar.workspace.focused.text.color i3-wm.bar.workspace.focused.text.color "#eee8d5"

set_from_resource $i3-wm.bar.workspace.active.border.color i3-wm.bar.workspace.active.border.color "#073642"
set_from_resource $i3-wm.bar.workspace.active.background.color i3-wm.bar.workspace.active.background.color "#073642"
set_from_resource $i3-wm.bar.workspace.active.text.color i3-wm.bar.workspace.active.text.color "#586e75"

set_from_resource $i3-wm.bar.workspace.inactive.border.color i3-wm.bar.workspace.inactive.border.color "#002b36"
set_from_resource $i3-wm.bar.workspace.inactive.background.color i3-wm.bar.workspace.inactive.background.color "#002b36"
set_from_resource $i3-wm.bar.workspace.inactive.text.color i3-wm.bar.workspace.inactive.text.color "#586e75"

set_from_resource $i3-wm.bar.workspace.urgent.border.color i3-wm.bar.workspace.urgent.border.color "#dc322f"
set_from_resource $i3-wm.bar.workspace.urgent.background.color i3-wm.bar.workspace.urgent.background.color "#dc322f"
set_from_resource $i3-wm.bar.workspace.urgent.text.color i3-wm.bar.workspace.urgent.text.color "#fdf6e3"

# Sets i3 font for dialogs
set_from_resource $i3-wm.font i3-wm.font pango:Source Code Pro Medium 13
font $i3-wm.font

###############################################################################
# i3 Bar
###############################################################################

set_from_resource $i3-wm.bar.position i3-wm.bar.position bottom
set_from_resource $i3-wm.bar.font i3-wm.bar.font pango:Source Code Pro Medium 13, Material Design Icons 13
set_from_resource $i3-wm.bar.separator i3-wm.bar.separator " "
set_from_resource $i3-wm.bar.trayoutput i3-wm.bar.trayoutput none
set_from_resource $i3-wm.bar.stripworkspacenumbers i3-wm.bar.stripworkspacenumbers yes

# i3xrocks config file. Override this for custom status indicators on the bar.
set_from_resource $i3-wm.bar.status_command i3-wm.bar.status_command i3xrocks -u ~/.config/regolith/i3xrocks/conf.d -d /etc/regolith/i3xrocks/conf.d

# The bar configuration
bar {
  position $i3-wm.bar.position
  font $i3-wm.bar.font
  separator_symbol $i3-wm.bar.separator
  status_command $i3-wm.bar.status_command
  tray_output $i3-wm.bar.trayoutput
  strip_workspace_numbers $i3-wm.bar.stripworkspacenumbers

  colors {
      background $i3-wm.bar.background.color
      statusline $i3-wm.bar.statusline.color
      separator  $i3-wm.bar.separator.color

#                        BORDER  BACKGROUND TEXT
      focused_workspace  $i3-wm.bar.workspace.focused.border.color      $i3-wm.bar.workspace.focused.background.color   $i3-wm.bar.workspace.focused.text.color
      active_workspace   $i3-wm.bar.workspace.active.border.color       $i3-wm.bar.workspace.active.background.color    $i3-wm.bar.workspace.active.text.color
      inactive_workspace $i3-wm.bar.workspace.inactive.border.color     $i3-wm.bar.workspace.inactive.background.color  $i3-wm.bar.workspace.inactive.text.color
      urgent_workspace   $i3-wm.bar.workspace.urgent.border.color       $i3-wm.bar.workspace.urgent.background.color    $i3-wm.bar.workspace.urgent.text.color
  }
}

###############################################################################
# External programs launched with i3
###############################################################################

# Start the installed regolith-compositor
set_from_resource $i3-wm.program.compositor i3-wm.program.compositor /usr/share/regolith-compositor/init
exec --no-startup-id $i3-wm.program.compositor

# Start Rofication for notifications
set_from_resource $i3-wm.program.notifications i3-wm.program.notifications /usr/bin/rofication-daemon
exec --no-startup-id $i3-wm.program.notifications

# Launch first time user experience script
set_from_resource $i3-wm.program.ftui i3-wm.program.ftui /usr/bin/regolith-ftue
exec --no-startup-id $i3-wm.program.ftui

# Hide the mouse pointer if unused for a duration
set_from_resource $i3-wm.program.unclutter i3-wm.program.unclutter /usr/bin/regolith-ftue /usr/bin/unclutter -b
exec --no-startup-id $i3-wm.program.unclutter

# User programs from Xresources
# To use, define an Xresource key i3-wm.program.[1-3] with the value of the program to launch.
# See https://regolith-linux.org/docs/howto/override-xres/ for details.
set_from_resource $i3-wm.program.1 i3-wm.program.1 :
exec --no-startup-id $i3-wm.program.1
set_from_resource $i3-wm.program.2 i3-wm.program.2 :
exec --no-startup-id $i3-wm.program.2
set_from_resource $i3-wm.program.3 i3-wm.program.3 :
exec --no-startup-id $i3-wm.program.3

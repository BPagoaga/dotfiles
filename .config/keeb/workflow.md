# Workflow

The goal is to centralize how I navigate through workspaces/windows/terminal within different OSes to have the most consistent workflow possible.
On all OSes, the mainMod is LGui (cmd on MacOS, super on Linux), shiftMod is mainMod + LShift.

## Hyprland

### General Actions

- open terminal: mainMod + return
- open app search: mainMod + space
- close active window: mainMod + q
- open wlogout: mainMod + g
- open file manager: mainMod + f

### Windows

Hyprland is the only case where I need to change the window focus because it's a tiling WM.

- toggle floating: mainMod + v
- toggle fullscreen: shiftMod + return
- cycle through windows on workspace: mainMod + tab (don't know how to navigate through all opened apps for now) and shiftMod + tab
- move focus with mainMod + (hjkl)

## Workspaces

As I usually don't need that many workspaces, 5 keybinds should be enough.

- mainMod + [azert] to switch to workspace
- shiftMod + [azert] to move active window to workspace
- mainMod + u/i to move to left/right workspace

## KDE Plasma

### General Actions

- open terminal: nothing ? => to check
- open app search: mainMod => to change
- close active window: ? => to check
- open wlogout: => wlogout not configured, todo
- open file manager: mainMod nothing => todo

### Windows

By the doc, it should be possible to set the same keybinds as in hyprland.
<https://docs.kde.org/stable5/en/khelpcenter/fundamentals/kbd.html>
However, I don't use tiling windows in KDE

### Workspaces

No keybinds defined ?
By the doc, it should be possible to set the same keybinds as in hyprland.
<https://docs.kde.org/stable5/en/khelpcenter/fundamentals/kbd.html>

## MacOS

### Windows

Not using tiling windows in MacOS.

### Workspaces

- go to previous/next workspace: Ctrl+shift+arrows (can't use hjkl since that would conflict with wezterm)
=> todo use hyprland keybinds: - mainMod + u/i to move to left/right workspace

## Wezterm

The keybinds are the same for all OSes.

- new tab: ctrl+shift+t
- new split: ctrl+shift+s
- move to previous/next tab: ctrl+shift+h/l
- move to left/down/up/right split: super+shift+hjlk
- close current pane: super+w
- close current tab: ctrl+shift+w

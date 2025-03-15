#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Arc.app"
dockutil --no-restart --add "/System/Applications/Mimestream.app"
dockutil --no-restart --add "/System/Applications/Fantastical.app"
dockutil --no-restart --add "/System/Applications/Warp.app"
dockutil --no-restart --add "/System/Applications/System Settings.app"

killall Dock

#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Arc.app"
dockutil --no-restart --add "/Applications/Mimestream.app"
dockutil --no-restart --add "/Applications/Fantastical.app"
dockutil --no-restart --add "/System/Applications/Reminders.app"
dockutil --no-restart --add "/Applications/Warp.app"
dockutil --no-restart --add "/System/Applications/System Settings.app"

killall Dock

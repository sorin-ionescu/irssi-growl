# Irssi Growl Script

This is a [Growl](http://growl.info) script for [Irssi](http://irssi.org/) Internet Relay Chat client.

## Installation

Make sure that **growlnotify** is in your `PATH`. You can find it in the Growl installation disk image, or you can install it via [Homebrew](http://mxcl.github.com/homebrew) or  [MacPorts](http://www.macports.org).

Copy *growl.pl* to *~/.irssi/scripts/autorun/growl.pl*. If you wish to have a pretty icon in the notifications, find a 512x512 PNG then drop it into *~/.irssi/icon.png*.

## Settings

### Notification Settings

`growl_show_message_public`

Notify on public message. (ON/OFF/TOGGLE)

`growl_show_message_private`

Notify on private message. (ON/OFF/TOGGLE)

`growl_show_hilight`

Notify on nick highlight. (ON/OFF/TOGGLE)

`growl_show_notifylist`

Notify on notification list connect and disconnect. (ON/OFF/TOGGLE)

`growl_show_server`

Notify on server connect and disconnect. (ON/OFF/TOGGLE)

`growl_show_channel`

Notify on channel join. (ON/OFF/TOGGLE)

`growl_show_channel_mode`

Notify on channel modes change. (ON/OFF/TOGGLE)

`growl_show_channel_topic`

Notify on channel topic change. (ON/OFF/TOGGLE)

`growl_show_event_notice`

Notify on event notice. (ON/OFF/TOGGLE)

`growl_show_dcc_request`

Notify on dcc request. (ON/OFF/TOGGLE)

### Network Settings

`growl_net_host`

Set the Growl server host.

`growl_net_port`

Set the Growl server port.

`growl_net_pass`

Set the Growl server password.

### Icon Settings

`growl_net_icon`

Set the Growl notification icon path.

### Sticky Settings

`growl_net_sticky`

Set sticky notifications. (ON/OFF/TOGGLE)

`growl_net_sticky_away`

Set sticky notifications only when away. (ON/OFF/TOGGLE)

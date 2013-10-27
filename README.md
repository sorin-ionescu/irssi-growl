# Irssi Growl Script

This is a [Growl](http://growl.info) script for [Irssi](http://irssi.org/) Internet Relay Chat client.

For my [WeeChat](http://weechat.org) Growl plugin, see [WeeChat Growl](https://github.com/sorin-ionescu/weechat-growl).

## Installation

Make sure that you have the [Growl::GNTP](http://search.cpan.org/perldoc?Growl::GNTP) and [IO::Socket::PortState](http://search.cpan.org/perldoc?IO::Socket::PortState) Perl modules installed.

Move *growl.pl* to *~/.irssi/scripts/autorun/growl.pl* and *icon.png* to *~/.irssi/icon.png*.

The network settings **DO NOT** need to be populated for local Growl notifications.

## Settings

### Notification Settings

`growl_show_message_public`

Notify on public message. (ON/OFF/TOGGLE)

`growl_show_message_private`

Notify on private message. (ON/OFF/TOGGLE)

`growl_show_message_action`

Notify on action message. (ON/OFF/TOGGLE)

`growl_show_message_notice`

Notify on notice message. (ON/OFF/TOGGLE)

`growl_show_message_invite`

Notify on channel invitation message. (ON/OFF/TOGGLE)

`growl_show_highlight`

Notify on nick highlight. (ON/OFF/TOGGLE)

`growl_show_notifylist`

Notify on notification list connect and disconnect. (ON/OFF/TOGGLE)

`growl_show_server`

Notify on server connect and disconnect. (ON/OFF/TOGGLE)

`growl_show_channel_topic`

Notify on channel topic change. (ON/OFF/TOGGLE)

`growl_show_dcc`

Notify on DCC chat/file transfer messages. (ON/OFF/TOGGLE)

`growl_channel_filter`

Restrict public/action messages to certain channels. (Regular expression)

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


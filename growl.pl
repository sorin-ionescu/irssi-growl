#!/usr/bin/env perl -w
#
# This is an Irssi script to send out Growl notifications over the network using
# growlnotify. It is based on the original Growl script by Nelson Elhage and Toby Peterson.

use strict;
use vars qw($VERSION %IRSSI);

use Irssi;

$VERSION = '1.0.0';
%IRSSI = (
  authors     =>  'Sorin Ionescu, based on original script by Nelson Elhage and Toby Peterson',
  contact     =>  'sorin.ionescu@gmail.com',
  name        =>  'Growl',
  description =>  'Sends out Growl notifications from Irssi',
  license     =>  'BSD',
  url         =>  'http://github.com/sorin-ionescu/irssi-growl',
);

# Notification Settings
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_message_public', 0);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_message_private', 1);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_hilight', 1);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_notifylist', 1);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_server', 1);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_channel', 0);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_channel_mode', 0);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_channel_topic', 1);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_event_notice', 0);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_dcc_request', 1);

# Network Settings
Irssi::settings_add_str($IRSSI{'name'}, 'growl_net_host', 'localhost');
Irssi::settings_add_str($IRSSI{'name'}, 'growl_net_port', '23053');
Irssi::settings_add_str($IRSSI{'name'}, 'growl_net_pass', 'password');

# Icon Settings
Irssi::settings_add_str($IRSSI{'name'}, 'growl_net_icon', '$HOME/.irssi/icon.png');

# Sticky Settings
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_net_sticky', 0);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_net_sticky_away', 1);

sub cmd_help {
    Irssi::print('Growl can be configured with these settings:');
    Irssi::print('%WNotification Settings%n');
    Irssi::print('  %ygrowl_show_message_public%n : Notify on public message. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_message_private%n : Notify on private message. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_hilight%n : Notify on nick highlight. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_notifylist%n : Notify on notification list connect and disconnect. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_server%n : Notify on server connect and disconnect. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_channel%n : Notify on channel join. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_channel_mode%n : Notify on channel modes change. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_channel_topic%n : Notify on channel topic change. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_event_notice%n : Notify on event notice. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_dcc_request%n : Notify on dcc request. (ON/OFF/TOGGLE)');
    
    Irssi::print('%WNetwork Settings%n');
    Irssi::print('  %ygrowl_net_host%n : Set the Growl server host.');
    Irssi::print('  %ygrowl_net_port%n : Set the Growl server port.');
    Irssi::print('  %ygrowl_net_pass%n : Set the Growl server password.');
    
    Irssi::print('%WIcon Settings%n');
    Irssi::print('  %ygrowl_net_icon%n : Set the Growl notification icon path.');
    
    Irssi::print('%WSticky Settings%n');
    Irssi::print('  %ygrowl_net_sticky%n : Set sticky notifications. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_net_sticky_away%n : Set sticky notifications only when away. (ON/OFF/TOGGLE)');
}

sub get_sticky {
    my ($server);
    $server = Irssi::active_server();
    if (Irssi::settings_get_bool('growl_net_sticky_away')) {
        if (!$server->{usermode_away}) {
            return 0;
        } else {
            return 1;
        }
    } else {
        return Irssi::settings_get_bool('growl_net_sticky');
    }
}

sub growl_notify ($$$$) {
    my $GrowlHost     = Irssi::settings_get_str('growl_net_host');
    my $GrowlPort     = Irssi::settings_get_str('growl_net_port');
    my $GrowlPass     = Irssi::settings_get_str('growl_net_pass');
    my $GrowlIcon     = Irssi::settings_get_str('growl_net_icon');
    my $GrowlSticky   = get_sticky() == 1 ? " --sticky" : "";
    my $AppName       = "Irssi";
    
    my ($event, $title, $message, $priority) = @_;
    
    $message =~ s/(")/\\$1/g;

    system(
        "growlnotify" 
        . " --name \"$AppName\""
        . " --host \"$GrowlHost\""
        . " --port \"$GrowlPort\""
        . " --password \"$GrowlPass\""
        . " --image \"$GrowlIcon\""
        . " --priority \"$priority\""
        . " --identifier \"$event\""
        . " --title \"$title\""
        . " --message \"$message\""
        . "$GrowlSticky"
        . " >> /dev/null 2>&1"
    );
}

sub sig_message_public ($$$$) {
    return unless Irssi::settings_get_bool('growl_show_message_public');
    my ($server, $data, $nick, $address) = @_;
    growl_notify(
        "Channel Notification",
        "Public Message",
        "$nick: $data",
        0
    );
}

sub sig_message_private ($$$$) {
    return unless Irssi::settings_get_bool('growl_show_message_private');
    my ($server, $data, $nick, $address) = @_;
    growl_notify(
        "Message Notification",
        "Private Message",
        "$nick: $data",
        1
    );
}

sub sig_print_text ($$$) {
    return unless Irssi::settings_get_bool('growl_show_hilight');
    my ($dest, $text, $stripped) = @_;
    my $nick;
    my $data;
    if ($dest->{level} & MSGLEVEL_HILIGHT) {
        $stripped =~ /^\s*\b(\w+)\b[^:]*:\s*(.*)$/;
        $nick = $1;
        $data = $2;
        growl_notify(
            "Hilight Notification",
            "Highlighted Message",
            "$nick: $data",
            1
        );
    }
}

sub sig_notifylist_joined ($$$$$$) {
    return unless Irssi::settings_get_bool('growl_show_notifylist');
    my ($server, $nick, $user, $host, $realname, $away) = @_;
    growl_notify(
        "Notify List Notification",
        "Friend Connected",
        ("$realname" || "$nick") . " has connected to $server->{chatnet}.",
        0
    );
}

sub sig_notifylist_left ($$$$$$) {
    return unless Irssi::settings_get_bool('growl_show_notifylist');
    my ($server, $nick, $user, $host, $realname, $away) = @_;
    growl_notify(
        "Notify List Notification",
        "Friend Disconnected",
        ("$realname" || "$nick") . " has disconnected from $server->{chatnet}.",
        0
    );
}

sub sig_server_connected ($$$$$$) {
    return unless Irssi::settings_get_bool('growl_show_server');
    my($server) = @_;
    growl_notify(
        "Server Notification",
        "Server Connected",
        "Connected to network $server->{chatnet}.",
        0
    );
}

sub sig_server_disconnected ($$$$$$) {
    return unless Irssi::settings_get_bool('growl_show_server');
    my($server) = @_;
    growl_notify(
        "Server Notification",
        "Server Disconnected",
        "Disconnected from network $server->{chatnet}.",
        0
    );
}

sub sig_channel_joined ($$$$$$) {
    return unless Irssi::settings_get_bool('growl_show_channel');
    my ($channel) = @_;
    growl_notify(
        "Channel Notification",
        "Channel Joined",
        "Joined channel $channel->{name}.",
        0
    );
}

sub sig_channel_mode_changed ($$$$$$) {
    return unless Irssi::settings_get_bool('growl_show_channel_mode');
    my ($channel) = @_;
    growl_notify(
        "Channel Notification",
        "Channel Modes",
        "$channel->{name}: $channel->{mode}",
        0
    );
}

sub sig_channel_topic_changed ($$$$$$) {
    return unless Irssi::settings_get_bool('growl_show_channel_topic');
    my ($channel) = @_;
    growl_notify(
        "Channel Notification",
        "Channel Topic",
        "$channel->{name}: $channel->{topic}",
        0
    );
}

sub sig_event_notice ($$$$$$) {
    return unless Irssi::settings_get_bool('growl_show_event_notice');
    my ($server, $data, $source) = @_;
    $data =~ s/^[^:]*://;
    growl_notify(
        "Message Notification",
        "Notice Message",
        "$source: $data",
        1
    );
}

sub sig_dcc_request ($$$$$$) {
    return unless Irssi::settings_get_bool('growl_show_dcc_request');
    my ($dcc, $sendaddr) = @_;
   
    if ($dcc->{type} =~ /CHAT/) {
        growl_notify(
            "DCC Notification",
            "DCC Chat Request",
            "$dcc->{nick} wants to chat directly.",
            0
        );
    }

    if ($dcc->{type} =~ /GET/) {
        growl_notify(
            "DCC Notification",
            "DCC File Transfer",
            "$dcc->{nick} wants to send you a file.",
            0
        );
    }
}

Irssi::command_bind('growl', 'cmd_help');

Irssi::signal_add_last('message public', \&sig_message_public);
Irssi::signal_add_last('message private', \&sig_message_private);
Irssi::signal_add_last('dcc request', \&sig_dcc_request);
Irssi::signal_add_last('event notice', \&sig_event_notice);
Irssi::signal_add_last('print text', \&sig_print_text);
Irssi::signal_add_last('notifylist joined', \&sig_notifylist_joined);
Irssi::signal_add_last('notifylist left', \&sig_notifylist_left);
Irssi::signal_add_last('server connected', \&sig_server_connected);
Irssi::signal_add_last('server disconnected', \&sig_server_disconnected);
Irssi::signal_add_last('channel joined', \&sig_channel_joined);
Irssi::signal_add_last('channel mode changed', \&sig_channel_mode_changed);
Irssi::signal_add_last('channel topic changed', \&sig_channel_topic_changed);


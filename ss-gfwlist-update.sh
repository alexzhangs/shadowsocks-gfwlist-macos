#!/bin/bash

SS_PROXY_SETTING=$1

[[ -z $SS_PROXY_SETTING ]] && SS_PROXY_SETTING="SOCKS5 127.0.0.1:1080; SOCKS 127.0.0.1:1080; DIRECT;"

SS_GFWLIST_URL="https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt"
SS_CONFIG_DIR=~/.ShadowsocksX

# Download GFWList
/usr/bin/curl -s "$SS_GFWLIST_URL" -o "$SS_CONFIG_DIR/gfwlist.txt" || exit $?

# Backup original PAC if not exist
SS_PAC_BACKUP="$SS_CONFIG_DIR/gfwlist-backup-by-${0##*/}.js"
if [[ ! -f $SS_PAC_BACKUP ]]; then
    /bin/cp -a "$SS_CONFIG_DIR/gfwlist.js" "$SS_PAC_BACKUP" || exit $?
fi

# Generate PAC
gfwlist2pac --proxy "$SS_PROXY_SETTING" \
            --input "$SS_CONFIG_DIR/gfwlist.txt" \
            --user-rule "$SS_CONFIG_DIR/user-rule.txt" \
            --file "$SS_CONFIG_DIR/gfwlist.js"

exit $?

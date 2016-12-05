#!/bin/bash -e

if [[ $DEBUG -ge 1 ]]; then
    set -x
else
    set +x
fi

SS_GFWLIST_URL="https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt"
SS_CONFIG_DIR=~/.ShadowsocksX

usage () {
    printf "${0##*/}\n"
    printf "\t[-c]\n"
    printf "\t[-p]\n"
    printf "\t[-h]\n\n"

    printf "OPTIONS\n"
    printf "\t[-c]\n\n"
    printf "\tUse cached GFW list file.\n\n"

    printf "\t[-p]\n\n"
    printf "\tProxy setting, default is: 'SOCKS5 127.0.0.1:1080; SOCKS 127.0.0.1:1080; DIRECT;'.\n\n"

    printf "\t[-h]\n\n"
    printf "\tThis help.\n\n"
    exit 255
}


while getopts cs:h opt; do
    case $opt in
        c)
            cache=1
            ;;
        p)
            proxy=$OPTARG
            ;;
        h|*)
            usage
            ;;
    esac
done

[[ -z $proxy ]] && proxy="SOCKS5 127.0.0.1:1080; SOCKS 127.0.0.1:1080; DIRECT;"

if [[ $cache -eq 1 ]]; then
    echo "Using cached GFW list file."
else
    # Download GFWList
    /usr/bin/curl --compressed -s "$SS_GFWLIST_URL" -o "$SS_CONFIG_DIR/gfwlist.txt" || exit $?
fi

# Backup original PAC if not exist
backup="$SS_CONFIG_DIR/gfwlist-backup-by-${0##*/}.js"
if [[ ! -f $backup ]]; then
    /bin/cp -a "$SS_CONFIG_DIR/gfwlist.js" "$backup" || exit $?
fi

# Generate PAC
gfwlist2pac --proxy "$proxy" \
            --input "$SS_CONFIG_DIR/gfwlist.txt" \
            --user-rule "$SS_CONFIG_DIR/user-rule.txt" \
            --file "$SS_CONFIG_DIR/gfwlist.js"

echo "Done"

exit

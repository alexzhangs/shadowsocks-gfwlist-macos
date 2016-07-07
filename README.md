# shadowsocks-macos-gfwlist-update
Shadowsocks for OSX 2.6.3 has an issue of updating GFWList PAC, that
returns error 404. The URL used during the update is hardcoded in the
application and can not be changed easily.

This script get GFWList with a new URL and use gfwlist2pac to generate
PAC and put it into the configuration directory of Shadowsocks.

This script is tested only with Max OS X.

## Dependence
### gfwlist2pac
pip install gfwlist2pac

OR

pip install gfwlist2pac==1.1.3

## Installation
git clone https://github.com/alexzhangs/shadowsocks-macos-gfwlist-update

sudo sh ./shadowsocks-macos-gfwlist-update/install.sh

## Manually Update GFWList
update-gfwlist.sh

## Setup a cron job run hourly
crontab -e

0 * * * * /usr/local/bin/update-gfwlist.sh > /var/log/update-gfwlist-error.log 2>&1

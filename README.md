# shadowsocks-gfwlist-macos

Shadowsocks for OSX 2.6.3 has an issue of updating GFWList PAC, that
returns error 404. The URL used during the update is hardcoded in the
application and can not be changed easily.

This script get GFWList with a new URL and use gfwlist2pac to generate
PAC and put it into the configuration directory of Shadowsocks.

This script is tested only with Max OS X.

## Dependence

### gfwlist2pac

```
pip install gfwlist2pac
```

OR

```
pip install gfwlist2pac==1.1.3
```

## Installation

```
git clone https://github.com/alexzhangs/shadowsocks-gfwlist-macos

sudo sh ./shadowsocks-gfwlist-macos/install.sh
```

## Manually Update GFWList

```
ss-gfwlist-update.sh
```

OR

```
/usr/local/bin/ss-gfwlist-update.sh
```

## Setup cron job to automatically update GFWList

```
crontab -e
```

Add entry (without virtualenv):

```
*/5 * * * * /usr/local/bin/ss-gfwlist-update.sh >> /tmp/ss-gfwlist-update-error.log 2>&1
```

OR (with virtualenv, replace YOUR_VIRTUALENV with your virtualenv name)

```
*/5 * * * * { . ~/.bash_profile; pyenv activate YOUR_VIRTUALENV; /usr/local/bin/ss-gfwlist-update; } >> /tmp/ss-gfwlist-update-error.log 2>&1
```

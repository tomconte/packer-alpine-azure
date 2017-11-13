#!/bin/sh

/usr/sbin/useradd $*

# if success...
if [ $? == 0 ]; then
        # was the passwd set in the command?
        passwd_set=
        for i in "$@"; do
                if [ $i == "-p" -o $i == "--password" ]; then
                        passwd_set=0
                fi
        done
        # if the passwd was set, don't mess with it
        # if no passwd was set, replace the default "!" with "*"
        # (still invalid password, but the account is not locked for ssh)
        if [ $passwd_set ]; then
                echo "useradd: password was set, doing nothing"
        else
                echo "useradd: force default password"
                for login; do true; done
                usermod -p "*" $login
        fi
fi

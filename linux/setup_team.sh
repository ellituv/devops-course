#!/bin/bash

set -e

for g in dev ops;do
    if getent group "$g" > /dev/null;then
        echo "group $g already exists"
    else
        groupadd "$g"
    fi
done

for u in alice bob  carol;do
   if id "$u" > /dev/null 2>&1; then
        echo "user $u already exists"
   else
        useradd -m "$u"
   fi
done

PROJECT_DIR=/srv/project
usermod -aG dev alice
usermod -aG dev bob
usermod -aG ops carol


mkdir -p "$PROJECT_DIR"
chown :dev "$PROJECT_DIR"
chmod 2770 "$PROJECT_DIR"
echo "dir group project is dev in $PROJECT_DIR"


setfacl -m g:ops:rx "$PROJECT_DIR"
setfacl -d -m g:ops:rx "$PROJECT_DIR"
echo "mission isdone 1. group dev is owner.  2. group ops only rx"

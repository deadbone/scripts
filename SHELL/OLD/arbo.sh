#!/bin/sh
dir=${1:-.}
cd ${dir};
pwd
find ${dir} -type d -print | \
     sort -f | \
     sed -e "s,^${dir},," \
         -e "/^$/d" \
         -e "s,[^/]*/\([^/]*\)$,\-----\1," \
         -e "s,[^/]*/, |     ,g";

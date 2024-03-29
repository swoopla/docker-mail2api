#!/bin/sh

# Exit codes from <sysexits.h>
EX_TEMPFAIL=75
EX_UNAVAILABLE=69

# Clean up when done or when aborting.
trap "rm -f in.$$" 0 1 2 3 15

cat >/tmp/in.$$ || { 
    echo Cannot save mail to file; exit $EX_TEMPFAIL; }

url=$(egrep ^https?:// /tmp/in.$$ |tail -1)
url="${url/http:/https:}"
url="$(echo ${url} |sed -e 's#/[a-z][a-z].#/www.#')"

test -z "${url}" && exit
curl -X POST --data-urlencode "url=${url}" ${YOUTUBEDL_URL}

exit $?

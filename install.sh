#!/bin/bash

dir=$(dirname "$0") || exit $?

echo ">>Copying scripts to /usr/local/bin/"
find "$dir" -maxdepth 1 -type f -not -name $(basename "$0") -and \( -name "*.sh" -or -name "*.py" \) |\
    while read f; do
        echo "  $f"
        fn=$(basename "$f") && \
            /bin/cp -a "$f" /usr/local/bin/ && \
            /bin/chmod 755 /usr/local/bin/$fn && \
            ( if echo "$fn" | grep -q '\.sh$'; then /bin/ln -sf "$fn" /usr/local/bin/${fn%.sh}; fi )
    done

ret=$(( PIPESTATUS + $? ))

echo ">>DONE."
exit $ret

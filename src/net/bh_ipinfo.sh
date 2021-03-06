bh_ipinfo()
{
    local ipaddress="${1:-`bh_myip`}"
    local ua='Mozilla/5.0 (Windows NT 6.1; WOW64; rv:28.0) Gecko/20100101 Firefox/28.0'
    local url="http://ipinfo.io"

    local company="$(wget -T 30 -q -O - "$url/$ipaddress/org")" 
    local asreg="${company%% *}"

    echo "$company" 
    
    if [ ! -z "$company" ] 
    then 
        wget --user-agent="$ua" -T 30 -q -O - "$url/$asreg" \
            | grep "$asreg/" \
            | sed 's/<[^>]*>//g; s/^ *//g'
    fi 
}

#!/usr/bin/env sh

if [ "$#" -ne 1 ]; then
    echo "USAGE: $0 DESTINATION"
    exit 1
fi

destination="$1"

if [ -d "$destination" ]; then
    rm -ri "$destination"
fi

ps aux | grep Podcasts | grep -v 'grep' > /dev/null

if [ $? -eq 0 ]; then
    echo "Please close Podcasts before running this script."
    exit 2
fi

mkdir "$destination"

database="$(find "$HOME/Library/Group\ Containers" -type f -name 'MTLibrary.sqlite' 2>&1 | grep -v 'not permitted')"
entries="$(sqlite3 "$database" "select ZMTPODCAST.ZTITLE, ZMTEPISODE.ZTITLE, ZASSETURL from ZMTPODCAST join ZMTEPISODE on ZMTPODCAST.Z_PK = ZMTEPISODE.ZPODCAST where ZASSETURL != '';")"

echo "$entries" | while read -r line
do
    directory="$(echo "$line" | cut -d '|' -f 1)"
    title="$(echo "$line" | cut -d '|' -f 2)"
    source="${$(echo "$line" | cut -d '|' -f 3 | sed 's/\%20/ /g')#"file://"}"

    mkdir -p "$destination/$directory"
    cp -r "$source" "$destination/$directory/$title.mp3"
done

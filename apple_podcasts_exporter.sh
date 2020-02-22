#!/usr/bin/env sh

if [ "$#" -ne 1 ]; then
    echo "USAGE: $0 DESTINATION"
    exit 1
fi

destination="$1"

if [ -d "$destination" ]; then
    while true; do
	echo "Do you want to remove the '$destination' directory? "
	read -r yn
	case $yn in
	    [Yy]*) rm -r "$destination"; break;;
	    [Nn]*) echo "Please choose another directory and re-run this program"; exit;;
	    * ) echo "Please answer yes or no";;
	esac
    done
fi

# SQLite database can't be accessed if Podcasts is open.
if [ "$(pgrep Podcasts > /dev/null)" ]; then
    echo "Please close Podcasts before running this script."
    exit 2
fi

mkdir "$destination"

database="$(find "$HOME/Library/Group Containers" -type f -name 'MTLibrary.sqlite' 2>&1 | grep -v 'not permitted')"
entries="$(sqlite3 "$database" "select ZMTPODCAST.ZTITLE, ZMTEPISODE.ZTITLE, ZASSETURL from ZMTPODCAST join ZMTEPISODE on ZMTPODCAST.Z_PK = ZMTEPISODE.ZPODCAST where ZASSETURL != '';")"

echo "$entries" | while read -r line
do
    directory="$(echo "$line" | cut -d '|' -f 1)"
    title="$(echo "$line" | cut -d '|' -f 2)"
    filepath="$(echo "$line" | cut -d '|' -f 3 | sed 's/\%20/ /g')"
    source="$(echo "$filepath" | sed 's|^file://||g')"

    mkdir -p "$destination/$directory"
    cp -r "$source" "$destination/$directory/$title.mp3"
done

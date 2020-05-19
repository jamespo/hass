#!/bin/bash

# spotcon.sh - control spotify through Home Assistant integration
# (c) jamespo [at] gmail [dot] com / 2020

USAGE="USAGE: spotcon.sh [prev|next|playpause]"

# get URL & auth details
# example contents:
# HATOKEN="eyJ0eXAiOiJKV1QiLasdawerkKLJIUOW897987uoiHNkjlhn89798"
# URL=http://192.168.0.10:8199
. $HOME/.private/.ha-spotify

ARG=$1

callha () {
    HACMD=$1
    # optionally set $SPOTCONLOUD to pass args to curl / disable silent
    if [[ -z "$SPOTCONLOUD" ]]; then
	curl -s -H "Content-Type: application/json" -H "Authorization: Bearer $HATOKEN" \
	     -d '{"entity_id": "media_player.spotify"}' \
	     "$URL/api/services/media_player/$HACMD" > /dev/null
    else
       	curl -H "Content-Type: application/json" -H "Authorization: Bearer $HATOKEN" \
	     -d '{"entity_id": "media_player.spotify"}' \
	     "$URL/api/services/media_player/$HACMD"
    fi

}

case $ARG in
    prev)
	callha media_previous_track
	;;
    next)
	callha media_next_track
	;;
    playpause)
	callha media_play_pause
	;;
    *)
	echo $USAGE
	;;
esac

exit

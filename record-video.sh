#!/bin/bash
slop=$(slop -f "%x %y %w %h %g %i") || exit 1
count=$(cat ~/other/screen_capture/counter)
read -r X Y W H G ID <<< $slop
ffmpeg -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y -f alsa -i pulse ~/Videos/video-"$count".webm
echo $(( $count + 1 )) > ~/other/screen_capture/counter

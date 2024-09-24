#!/bin/bash
slop=$(slop -f "%x %y %w %h %g %i") || exit 1
counter_path=~/other/screen_capture/counter
cat $counter_path
count=$(cat $counter_path)
mkdir -p ~/Gifs
read -r X Y W H G ID <<< $slop
ffmpeg -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y -f alsa -i pulse ~/Videos/video-"$count".webm
echo $(( $count + 1 )) > $counter_path
ffmpeg -i ~/Videos/video-"$count".webm -vf "fps=10,scale=640:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 ~/Gifs/video-"$count".gif

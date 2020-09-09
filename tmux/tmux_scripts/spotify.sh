#! /bin/bash
interval=5

echo -e 'Starting song check...\n';

#Main loop of the script
while true; do
	spotifyid=$(ps -ef | grep '[/]usr/share/spotify' | awk '{print $2}' | head -1)
	#Get the current song by listing all windows and grepping the matching window with the PID

	if [ -z "$spotifyid" ]; then
		currentsong='Spotify not running'
	else
		currentsong=$(wmctrl -l -p | grep $spotifyid | sed -n 's/.*'$HOSTNAME'//p');
		if [ "$(echo $currentsong)" == 'Spotify Free' ]; then
			currentsong='■ Paused';
		else
			currentsong='♫'$currentsong
		fi
	fi
	echo $currentsong;
	sleep $interval;
done
exit 0;

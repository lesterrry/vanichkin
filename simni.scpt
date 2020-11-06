(*
Sorry, I'm not interested
This script automatically joins Microsoft Teams meetings on a specific time.
Ensure you have Google Chrome installed and working normally out of the box.
You will also need to explicitly grant permission in Settings.
To activate script, add new Calendar event in a specific calendar, named "SIMNI". 
As an alert, add "launch app" action, and pass this script.
Manually launch this script at first to try it out.
****************************************************************
COPYRIGHT LESTERRRY, 2020
*)

property link : missing value
--property usrname : "Айдар"
try
	tell application "Calendar"
		tell calendar "SIMNI"
			set link to get url of (first event where its start date is greater than or equal to (current date) - (2 * minutes) and start date is less than or equal to (current date))
		end tell
	end tell
on error
	display dialog "No meeting found, let's just give it a try?" with icon caution
	tell application "Google Chrome"
		activate
		open location "https://ya.ru"
	end tell
	tell application "System Events"
		delay 0.5
		keystroke "We can work! Мы работаем!"
	end tell
	quit me
end try

tell application "Google Chrome"
	activate
	open location link
end tell
delay 1
tell application "System Events"
	repeat 2 times
		keystroke tab
		delay 0.5
	end repeat
	keystroke return
	delay 7
	repeat 2 times
		keystroke tab
		delay 0.5
		keystroke return
		delay 0.5
	end repeat
	repeat 6 times
		keystroke tab
		delay 0.5
	end repeat
	--keystroke usrname
	keystroke tab
	delay 0.5
	keystroke return
end tell

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
try
	tell application "Calendar"
		tell calendar "SIMNI"
			set ev to first event where its start date is greater than or equal to (current date) - (2 * minutes) and start date is less than or equal to (current date)
			set link to get url of ev
			set end_date to get end date of ev
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
	display notification "We can work!" with title "Мы работаем!" sound name "Frog"
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
	repeat 7 times
		keystroke tab
		delay 0.5
	end repeat
	keystroke return
end tell
set exit_delay to end_date - (current date)
display notification "We will leave in " & (exit_delay / 60) & " min" with title "Conference joined"
delay exit_delay
tell application "Google Chrome" to quit
quit me

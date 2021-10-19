(*
Vanichkin
This script automatically joins Microsoft Teams meetings on a specific time.
You will need to explicitly grant permission in Settings.
To activate script, add new Calendar event in a specific calendar, named "SIMNI". 
As an alert, add "launch app" action, and pass this script.
Manually launch this script at first to try it out.
****************************************************************
COPYRIGHT LESTERRRY, 2021
*)

-- Name to join meetings with
global USERNAME
set USERNAME to "Aydar"

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
	tell application "Safari"
		activate
		make new document with properties {URL:"https://ya.ru"}
	end tell
	tell application "System Events"
		delay 0.5
		keystroke "We can work! Мы работаем!"
	end tell
	display notification "We can work!" with title "Мы работаем!" sound name "Frog"
	quit me
end try
tell application "Safari"
	activate
	make new document with properties {URL:link}
	delay 4
	tell application "System Events" to key code 53
	tell document 1
		do JavaScript "document.querySelector('button[data-tid=\"joinOnWeb\"]').click();"
		delay 30
		do JavaScript "document.querySelector('button[track-summary=\"Toggle microphone OFF in meeting pre join screen\"]').click()"
		delay 1
		do JavaScript "document.querySelector('button[track-summary=\"Toggle camera OFF in meeting pre join screen\"]').click()"
		delay 1
		do JavaScript "document.querySelector('input[id=\"username\"]').value = '" & USERNAME & "'"
		delay 1
		do JavaScript "document.querySelector('button[track-summary=\"join meeting from pre-join screen\"]').click()"
	end tell
end tell
set exit_delay to end_date - (current date)
display notification "We will leave in " & (exit_delay / 60) & " min" with title "Conference joined" sound name "Frog"
delay exit_delay
tell application "Safari"
	tell document 1 to close
end tell
quit me

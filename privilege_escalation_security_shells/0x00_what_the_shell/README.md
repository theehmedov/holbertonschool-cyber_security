Overview
This document explains two methods to read the contents of /home/user/flag while bypassing command blacklist restrictions.

Methods
Method 1: Wildcard Bypass
bash
cat /home/user/fla?
How it works:

The ? wildcard matches any single character

fla? resolves to flag (matches the letter g)

Avoids directly writing the filename "flag"

No blacklisted commands used

Method 2: Tab Character Bypass
bash
cat	/home/user/flag
How it works:

Uses a TAB character (\t) instead of a space

Blacklist only blocks spaces (), not tabs

Press Ctrl+V then Tab to insert a literal tab

Works because the shell treats tabs as whitespace

Key Points
Both methods use cat (not blacklisted)

No special characters (|, -, *, ?, {}) are used

No banned commands (grep, awk, find, bash, etc.)

Simple and effective bypass techniques

Usage
Run either command directly in the terminal to read the flag file.

Result: Both commands successfully display the flag content.

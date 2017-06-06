** Small cazautils configuration **

Install:
-------

After you cloned the git, edit the cazautils.conf file.
If that's done, just run cazacore.bash.
Now you should have all scripts in /home/you/bin so you can execute them without path.

Description:
------------

**caza-dl:** 

Youtube-dl frontend. Fixes some bugs and implements youtube-dl easier.
call it with: caza-dl-(a/v) [video link] [file destination] [playlist]
*a means it will only download the audio
*v means video too
*you can place "playlist" at the end of execution if you want the playlist to be downloaded too, if not just leave it empty.

**cazaMC:**

Startup Script for MultiMC. Could be used for the default Java Minecraft Launcher, if you are hacky, but i recommend using MultiMC anyway.
Call it with: minecraft [start,stop,restart]
*start starts MultiMC
*stop kills both MultiMC and minecraft client
*restart kills only client - launcher reopens.


**cazadse**

NOT TESTED!
Documentation will be coming soon

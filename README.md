TL;DR;
-----

```bash

# vomit a bunch of messages into https://www.flowdock.com/app/dojo4/dojo4

~> bundle install

~> ./bin/asana2flowdock run 

```

DEPLOY
------

- this shit runs in a named screenon d0
- it needs to be restarted by hand if you reboot the box

```bash

~> ssh dojo4@d0.dojo4.com

~> cd git/asana2flowdock

~> git pull

~> screen -list # look for the screen yo!

~> screen -d -r asana2flowdock  # or screen -S asana2flowdock

~> ctrl-c

~> ./bin/asana2flowdock run

```




TODO
----

- daemonize
- crontabize
- store processed stories locally?
- cap deploy?



 

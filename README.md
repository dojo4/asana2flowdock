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

dojo4@ip-10-191-128-13:~/git/asana2flowdock$ while true;do ./bin/asana2flowdock run; done
# I, [2014-10-24T07:06:18.952743 #28483]  INFO -- : ago: 2014-10-24 05:32:09 +0000
# I, [2014-10-24T07:06:30.177388 #28483]  INFO -- : relayed https://app.asana.com/0/18611241887243/18611241887251/f
# I, [2014-10-24T07:06:30.178715 #28483]  INFO -- : relayed https://app.asana.com/0/18611241887243/18611241887251/f
# I, [2014-10-24T07:06:30.179640 #28483]  INFO -- : relayed https://app.asana.com/0/18611241887243/18611241887251/f
# I, [2014-10-24T07:06:30.181069 #28483]  INFO -- : relayed https://app.asana.com/0/18611241887243/18611241887251/f

```




TODO
----

- daemonize
- crontabize
- store processed stories locally?
- cap deploy?



 

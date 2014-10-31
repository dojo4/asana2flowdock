TL;DR;
-----

asana2flowdock relays asana events into flowdock.  like this:


  ![](https://s3.amazonaws.com/ss.dojo4.com/RTbL2P5VyYOWhnhDoKsfG.png)


it currently works around asana's lack of webhooks by keeping a teeny sqlite
database of local state: a cursor of which messages have been relayed, and
which have not.  when polling asana for updated tasks it uses this knowledge
to limit the result set via the 'last_modified' support they provide for
querying a project's tasks.

this combination allows the amount of polling and data transfered to be kept
to a minimum.

to install it do:


```bash

  gem install asana2flowdock


```

to get going you'll need a configuration file created.  asana2flowdock will
store it's config file in ~/.asana2flowdock/config.yml, to create one simply
do:


```bash

  asana2flowdock config


```

this should spawn your editor and let you configure both your asana and
flowdock tokens, and also set the workspace in asana you want to pull activity
from.  if this fails for any reason you really just need to create a config
file like so:


```yaml

  # file: ~/.asana2flowdock/config.yml

  asana:
    token: yer_asana_api_token 
    workspace: dojo4.com # probably should be you asana workspace name ;-)

  flowdock:
    token: your_flowdock_api_token


```

after that, you only need run


```bash

~> asana2flowdock


```

to begin relaying messages from asana, to flowdock.  to run this command in
daemon mode you will want to do things like:

```bash

~> asana2flowdock daemon start

~> asana2flowdock daemon pid

~> asana2flowdock daemon tail

~> asana2flowdock daemon stop

```

to learn more type

```bash

~> asana2flowdock help

# OR

~> asana2flowdock daemon usage


```

email to : ara@dojo4.com for help, feedback, or if you want help setting this
up for your flowdock/asana accounts.

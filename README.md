## CheckZilla

CheckZilla is command line tool allowing you to check and be notified of outdated software.
CheckZilla is extensible and already supports multiple "Checkers" (RubyGem, Pacman, Node.js) and "Notifiers" (Console, Email, HipChat).

The main usage currently is to use it as a CRON, notifying you everyday of new softwares.

**Warning** This is Beta Software !

## How to use it

```
$> checkzilla your-config-file
```

The configuration is using a DSL, here's a sample :

```
CheckZilla::Model.new('This is the title of my report') do

  check_updates :rubygem do |rubygem|
    rubygem.path = "/home/mike/code/diaspora"
  end

  notify_by :hipchat do |hipchat|
    hipchat.api_token = '95def4314870443f46b8c4694bd88e'
    hipchat.room = 'test'
    hipchat.username = 'CheckUpdates'
  end

  notify_by :console
end
```

## Checkers

Checkers are defined via a `CheckZilla::Check` class, they need to define 2 methods:

`initialize(&block)` returns self

`perform!` fills @results with @results[software_name] = [software_current_version, software_newer_version]

Here's the list of availables checkers:

### Rubygem

```
check_updates :rubygem do |rubygem|
  rubygem.path = "/home/mike/code/diaspora"
end
```

Tries to find a `Gemfile.lock` if `path` is defined, otherwise will use `gem list` for a system wide ruby installation. It matches your dependencies against the rubygems api to find what's outdated.
  
### Pacman

```
check_updates :pacman
```

Tries to determine your outdated package via:

`sudo pacman -Sy > /dev/null ; package-query -AQu -f '%n %l %V'`

**Warning** You need to execute checkzilla as root as I didn't find a better way to ask pacman to synchronise the db. `package-query` is required (it's a dependency of yaourt).

### Node.js

```
check_updates :npm do |npm|
  npm.path = "/home/mike/code/nodes3"
end
```

It requires `path` and will determine the dependencies via `npm outdated`

## Notifiers

Checkers are defined via a `CheckZilla::Notifier` class, they need to define 2 methods:

`initialize(&block)` returns self

`perform!(checkers)` loop other the checkers, format the `results` and notifies you.

Here's the list of availables notifiers:

### Console

```
notify_by :console
```

Outputs to the console.

### Email

```
notify_by :email do |email|
  email.pony_settings = {
    :to => 'you@gmail.com',
    :subject => 'BOT Report',
    :from => 'you+bot@gmail.com',
    :via => :smtp,
    :via_options => {
      :address              => 'smtp.gmail.com',
      :port                 => '587',
      :enable_starttls_auto => true,
      :user_name            => 'you@gmail.com',
      :password             => 'yourpassword',
      :authentication       => :plain,
      :domain               => "localhost.localdomain"
    }
  }
end
```

Send you an email using [Pony](https://github.com/benprew/pony)

### Hipchat

```
notify_by :hipchat do |hipchat|
  hipchat.api_token = '95def4314870443f46b8c4694bd88e'
  hipchat.room = 'test'
  hipchat.username = 'CheckUpdates'
end
```

Sends you a notification to the [HipChat](http://hipchat.com) room of your choice
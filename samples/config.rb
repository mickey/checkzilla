CheckZilla::Model.new('This is the title of my report') do

  check_updates :rubygem do |rubygem|
    rubygem.path = "/home/mike/code/diaspora"
  end

  check_updates :pacman

  check_updates :npm do |npm|
    npm.path = "/home/mike/code/lic/nods3"
  end

  notify_by :twitter do |twitter|
    twitter.consumer_key = YOUR_CONSUMER_KEY
    twitter.consumer_secret = YOUR_CONSUMER_SECRET
    twitter.oauth_token = YOUR_OAUTH_TOKEN
    twitter.oauth_token_secret = YOUR_OAUTH_TOKEN_SECRET
  end

  notify_by :hipchat do |hipchat|
    hipchat.api_token = '95def4314870443f46b8c4694bd88e'
    hipchat.room = 'test'
    hipchat.username = 'CheckUpdates'
  end

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

  notify_by :console

  notify_by :notify_send

end
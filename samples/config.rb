Updates::Model.new('This is the title of my report') do

  check_updates :rubygem do |rubygem|
    rubygem.path = "/home/mike/code/diaspora"
  end

  check_updates :pacman

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

end
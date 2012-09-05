module Updates

  LIBRARY_PATH        = File.join(File.dirname(__FILE__), 'updates')
  CHECK_UPDATE_PATH   = File.join(LIBRARY_PATH, 'check')
  NOTIFIER_PATH       = File.join(LIBRARY_PATH, 'notifier')

  [CHECK_UPDATE_PATH, NOTIFIER_PATH].each do |ext|
    Dir["#{ext}/*.rb"].each { |lib| require lib }
  end

  %w{
    model
    cli
  }.each {|lib| require File.join(LIBRARY_PATH, lib) }
end
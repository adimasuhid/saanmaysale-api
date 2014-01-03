desc "This task is called by the Heroku cron add-on"
task :load_data do
  require 'open-uri'
  open("http://saanmaysale-api.herokuapp.com")
  puts "Reloaded Files"
end

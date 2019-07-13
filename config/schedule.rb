require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, '/var/www/freemarket_sample_53b/shared/log/crontab.log'
env :PATH, ENV['PATH'] 

every 1.hours do
  command "echo 'hello, whenever world!'"
end

every 1.day at: '11:00 am' do
  runner "ActiveStorage::Blob.unattached.find_each(&:purge_later)"
end

require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, '/var/www/freemarket_sample_53b/shared/log/crontab.log'

every 1.day at: '11:00 am' do
  runner "ActiveStorage::Blob.unattached.find_each(&:purge_later)"
end

require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, 'log/crontab.log'
set :environment, :production

every 1.day at: '11:00 am' do
  runner "ActiveStorage::Blob.unattached.find_each(&:purge_later)"
end

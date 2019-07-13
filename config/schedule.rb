require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, '/var/www/freemarket_sample_53b/shared/log/crontab.log'
env :PATH, ENV['PATH'] 
job_type :rbenv_rake, %q!eval "$(rbenv init -)"; cd :path && :environment_variable=:environment bundle exec rake :task --silent :output!

every 1.hours do
  command "echo 'hello, whenever world!'"
end

every 1.day at: '11:00 am' do
  runner "ActiveStorage::Blob.unattached.find_each(&:purge_later)"
end

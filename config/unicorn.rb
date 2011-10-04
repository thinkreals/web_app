# Sample verbose configuration file for Unicorn (not Rack)
#
# This configuration file documents many features of Unicorn
# that may not be needed for some applications. See
# http://unicorn.bogomips.org/examples/unicorn.conf.minimal.rb
# for a much simpler configuration file.
#
# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.

exuser = 'default_user'
rails_env = ENV["RACK_ENV"]

if rails_env == 'production'
  app_name = "webapp"
  app_dir = "/home/#{exuser}/deploy/#{app_name}/current"
elsif rails_env == 'development'
  app_name = "dev_webapp"
  app_dir = "/home/#{exuser}/deploy/#{app_name}"
elsif rails_env == 'staging'
  app_name = "staging_webapp"
  app_dir = "/home/#{exuser}/deploy/#{app_name}/current"
end

working_directory app_dir
pid "#{app_dir}/tmp/pids/unicorn.pid"
stderr_path "#{app_dir}/log/unicorn.stderr.log"
stdout_path "#{app_dir}/log/unicorn.stdout.log"


worker_processes (rails_env == 'production' ? 4 : 1)

# Help ensure your application will always spawn in the symlinked
# "current" directory that Capistrano sets up.

# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
listen "/tmp/#{app_name}.socket", :backlog => 2048
#listen 8080

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30
user exuser, exuser

# feel free to point this anywhere accessible on the filesystem

before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end 
  end 
  sleep 1
end


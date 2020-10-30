# set lets
$worker  = 2
$timeout = 30
$app_dir = "/mountain_app" 
$listen  = 3000
$pid     = File.expand_path 'tmp/pids/unicorn.pid', $app_dir
# $std_log = File.expand_path 'log/unicorn.log', $app_dir
# set config
listen  $listen
pid $pid
worker_processes  $worker
working_directory $app_dir
stderr_path $stder
stdout_path $stdout
timeout $timeout
# loading booster
preload_app true
# before starting processes
before_fork do |server, worker|
  defined?(ActiveRecord::Base) || ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      Process.kill "QUIT", File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end
# after finishing processes
after_fork do |server, worker|
  defined?(ActiveRecord::Base) || ActiveRecord::Base.establish_connection
end
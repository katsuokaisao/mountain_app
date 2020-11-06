$worker  = 2
$timeout = 30 
$listen  = 3000
$app_dir = "~/mountain_app"
$pid     = File.expand_path 'tmp/pids/unicorn.pid', $app_dir
listen $listen
pid $pid
worker_processes $worker
working_directory $app_dir
stderr_path File.expand_path('tmp/log/stderr.log', $app_dir)
stdout_path File.expand_path('tmp/log/stdout.log', $app_dir)
timeout $timeout
preload_app true

# before starting processes
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
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
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
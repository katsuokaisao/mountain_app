$worker  = 2
$timeout = 30
$app_dir = "/mountain_app" 
$listen  = 3000
$pid     = File.expand_path 'tmp/pids/unicorn.pid', $app_dir

listen  $listen
pid $pid
worker_processes  $worker
working_directory $app_dir
stderr_path File.expand_path 'log/strderr_path', $app_dir
stdout_path File.expand_path 'log/strdout_path', $app_dir
timeout $timeout
preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end
after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
Rails.application.configure do
  # Code is not reloaded between requests.falseにした方が高速になるので本番ではfalseが望ましい
  config.cache_classes = true

  # trueにすると、config.eager_load_namespacesに登録された事前一括読み込み(eager loading)用の名前空間をすべて読み込みます。
  config.eager_load = true

  # このフラグがtrueの場合、どのような種類のエラーが発生した場合にも詳細なデバッグ情報がHTTPレスポンスに出力され、アプリケーションの実行時コンテキストがRails::Infoコントローラによって/rails/info/propertiesに出力されます。
  config.consider_all_requests_local       = false

  # Action Controllerコンポーネントが提供するキャッシュ機能をアプリケーションで使うかどうかを指定します。
  config.action_controller.perform_caching = true

  # master keyが指定されてない状態でサーバ起動を実行しようとするとエラーが発生します。
  # config.require_master_key = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  # config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.public_file_server.enabled = true
  
  # アセットパイプラインを有効にするかどうかを指定します。
  config.assets.enabled = true
  # デバッグ用にアセットの連結と圧縮をやめるかどうかを指定します。
  config.assets.digest = true
  # 動的にコンパイルするかどうか。本番ではfalseでいい
  config.assets.compile = true
  # Compress CSS using a preprocessor.
  config.assets.css_compressor = :sass

  # アセットを置くためのホストを設定します。これは、アセットをホストする場所としてアプリケーションサーバーの代りにCDN(コンテンツ配信ネットワーク)を使いたい場合に便利です。
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # 本番環境(production)の保存先を:localから:amazonに変更
  config.active_storage.service = :amazon

  # Mount Action Cable outside main process or domain.
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

  # ActionDispatch::SSLミドルウェアを用いて、すべてのリクエストをHTTPSプロトコル下で実行するよう強制
  # config.force_ssl = true

  # Railsのログ出力をどのぐらい詳細にするかを指定します。デフォルトではすべての環境で:debugが指定されます。
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Railsでのキャッシュ処理に使われるキャッシュストアを設定します。
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "docker_app_production"

  # メイラーのテンプレートでフラグメントキャッシュを有効にするべきかどうかを指定します。
  config.action_mailer.perform_caching = false

  # メールの配信が完了しなかった場合にエラーを発生させるかどうかを指定します。
  # config.action_mailer.raise_delivery_errors = false

  # 訳文がない場合のフォールバック動作を設定します。
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Railsロガーのフォーマットを定義します。
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # マイグレーション実行時にスキーマダンプ(db/schema.rbまたはdb/structure.sql)を行なうかどうかを指定します。
  config.active_record.dump_schema_after_migration = false

  # Inserts middleware to perform automatic connection switching.
  # The `database_selector` hash is used to pass options to the DatabaseSelector
  # middleware. The `delay` is used to determine how long to wait after a write
  # to send a subsequent read to the primary.
  #
  # The `database_resolver` class is used by the middleware to determine which
  # database is appropriate to use based on the time delay.
  #
  # The `database_resolver_context` class is used by the middleware to set
  # timestamps for the last write to the primary. The resolver uses the context
  # class timestamps to determine how long to wait before reading from the
  # replica.
  #
  # By default Rails will store a last write timestamp in the session. The
  # DatabaseSelector middleware is designed as such you can define your own
  # strategy for connection switching and pass that into the middleware through
  # these configuration options.
  # config.active_record.database_selector = { delay: 2.seconds }
  # config.active_record.database_resolver = ActiveRecord::Middleware::DatabaseSelector::Resolver
  # config.active_record.database_resolver_context = ActiveRecord::Middleware::DatabaseSelector::Resolver::Session

  config.hosts.clear
end

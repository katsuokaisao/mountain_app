Rails.application.configure do
config.after_initialize do
    Bullet.enable        = true
    Bullet.alert         = true
    Bullet.bullet_logger = true
    Bullet.console       = true
  # Bullet.growl         = true
    Bullet.rails_logger  = true
    Bullet.add_footer    = true
  end 
  config.web_console.allowed_ips = '0.0.0.0/0'
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end
  config.active_storage.service = :local
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  # 開発環境ではcompileはオフにする設定
  config.assets.debug = true
  # アセットへのリクエストのログ出力を無効にします。
  config.assets.quiet = true
  # 18nで訳文が見つからない場合にエラーを発生するかどうかを指定します。
  # config.action_view.raise_on_missing_translations = true

  # docker-compose restartしないとコードが反映されない問題の解決
  config.file_watcher = ActiveSupport::FileUpdateChecker
  config.hosts << "unicorn"
end

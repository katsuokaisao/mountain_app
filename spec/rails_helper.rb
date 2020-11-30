# rails generate rspec：installを実行すると、このファイルはspec/ディレクトリにコピーされます。
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# 本番環境のときにデータベースのTRUNCATEを防ぎます。
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
# 追加でrequireする場合はこの下に追加してください。この時点までRailsは読み込まれていません！

# カスタムマッチャやマクロなどを記述したrubyファイルを読み込みたい場合、spec/support/配下に置いてください。spec/配下にある_spec.rbで終わるファイルはbundle exec rspecコマンドを実行すると自動的に走ります。つまり、これをspec/support/内に置くと、読み込み時とテスト時の二回実行されることになります。そのため、spec/support/に_spec.rbで終わるファイルを置くのはやめましょう。この様式はコマンドを打つときに--patternを使うか、~/.rspec, .rspec, .rspec-localで設定できます。

# 以下の行は手間を省くために用意されています。この行を有効にするとspec/support/以下の全てのファイルが自動的に読み込まれるため、起動に時間がかかるという難点もあります。
# 代わりの方法として、それぞれの_spec.rbファイルでrequireを使って必要なファイルだけを読み込む方法もあります。
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# 保留にされている4マイグレーションを確認し、テストを走らせる前にマイグレーションを適用します。ActiveRecordを使わない場合、以下の行（beginからendまで）を削除できます。
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # sign_inヘルパーを提供してくれる
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.include Devise::Test::IntegrationHelpers, type: :request
  # FactoryBotのデータ呼び出しを簡略化できる。
  # (テストデータの呼び出しを、FactoryBot.create(:◯◯) → create(:◯◯)に簡略化出来る)
  # config.include FactoryBot::Syntax::Methods

  # もしActiveRecordやActiveRecordのfixtureを使用しない場合はこの行は必要ありません。
  # （補足）例えばFactoryBotしか使わないというような場合が当てはまりますが、他の人の設定を見たところ、わざわざ削除している人は少ないようです。
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # ActiveRecordを使わない、またはトランザクション内で複数のexampleを走らせたい場合は、この行を削除するかオプションをtrueからfalseにしてください。
  config.use_transactional_fixtures = true
  # デフォルトのtrueの場合、exampleごとにトランザクションが行われる設定になっています。つまり、exampleが始まるときにはきれいなデータベースが用意され、終わると全てのデータを削除します。Database Cleanerなどを使って手動で削除する場合や、特定のSpecでだけトランザクションのロールバックを無効にする場合はfalseにします。

  # この行のコメントを解除して、ActiveRecordサポートを完全にオフにすることができます。
  # config.use_active_record = false

  # RSpec Railsでは、ファイルの場所に応じた動作を使用することができます。例えば、spec/controllers配下のファイルでは、getやpostを使うことができる仕様となっています。
  # 以下の行を削除するとこの仕様が無効になります。代わりに以下のtype: :controllerのように、明示的にタイプを記述することができます。
  config.infer_spec_type_from_file_location!
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # 利用可能なタイプは、以下のサイトに記述しています。
  # https://relishapp.com/rspec/rspec-rails/docs

  # バックトレースをフィルタリングする設定
  config.filter_rails_from_backtrace!
  # 特定のgemをフィルタリングする場合、次の設定をしてください。
  # config.filter_gems_from_backtrace("gem name")
end

# .rspec file
# デフォルトだと--require spec_helperとなっているが、RailsでRSpecを使う場合は、--require rails_helperを使うのがベター。
# 理由としては、後述するrails_helper.rbで既にrequire spec_helperを行なっているため。
# .rspecの設定	シュチュエーション
# --require rails_helper RailsでRSpecを使う時
# --require spec_helper	Ruby単体で使用するとき
# # 出力結果を色分け
# --color
# # rails_helperの読み込み
# --require rails_helper
# # 出力結果をドキュメント風に見やすくする
# --format documentation

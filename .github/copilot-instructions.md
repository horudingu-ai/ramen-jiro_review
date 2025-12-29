# Copilot / AI エージェント用 簡易ガイド

目的: このリポジトリで素早く生産的に動けるよう、アーキテクチャの大枠、重要なファイル、典型的な変更パターンと開発ワークフローを短くまとめる。

- **技術スタック**: Ruby on Rails 8.1, Propshaft (アセット), Importmap/Turbo/Stimulus (フロントエンド), SQLite3 (開発), Active Storage（画像アップロード）。（参照: Gemfile）

- **大局とデータフロー**:
  - 主なリソースは Shop と Review。Review は Shop にネストされる（config/routes.rb を参照）。
  - ユーザーはログインしてレビューを投稿する流れ。Review モデルは `has_many_attached :images` を使い、画像は Active Storage 経由で保存される（app/models/review.rb）。
  - フロントは Turbo + Stimulus を使った軽量なインタラクションを想定（app/javascript/controllers）。

- **主要ファイル / 参照例** (典型的に見る箇所)
  - ルーティング: config/routes.rb — shops と reviews のネスト、写真一覧 (photos) がある。
  - コントローラ: app/controllers/reviews_controller.rb — ネストされたリソースの扱い、strong params で images: [] を受け取る点が重要。
  - モデル: app/models/review.rb, app/models/shop.rb, app/models/user.rb — 関連とバリデーションの慣習を守る。
  - フロント: app/javascript/controllers (Stimulus), views/*（PWA 関連も存在）
  - アセット: app/assets/stylesheets/application.css（グローバルスタイル）
  - マイグレーション: db/migrate — スキーマを変更する際はここを更新

- **プロジェクト特有の慣習 / 注意点**
  - Assets: propshaft を使用しているため、従来の sprockets 前提の変更は避ける（app/assets 配置は維持するがビルドに注意）。
  - JavaScript は importmap ベース。npm や webpack の前提で実装しない（app/javascript/controllers を直接編集する）。
  - `bin/*` に実行スクリプトが揃っている（bin/rails, bin/rake, bin/setup 等）。開発者コマンドはまず bin/ を使うこと。
  - 認証は自前実装（sessions_controller.rb, users_controller.rb）でシンプル。before_action :require_login を見ると挿入点がわかる。

- **セットアップ / 主要コマンド**
  - 依存インストール: `bundle install`
  - 初期セットアップ（可能なら）: `bin/setup`
  - マイグレーション: `bin/rails db:migrate`
  - サーバ起動: `bin/rails server` または `bin/rails s`
  - コンソール: `bin/rails console`
  - テスト: `bin/rails test`（system テストは capybara/selenium を使用するため環境が必要）
  - Docker: Dockerfile がある。コンテナ化や kamal によるデプロイの参照は必要に応じて。

- **変更例（短く具体的）**
  - 画像付きレビューを受け取るフォームを追加する場合: reviews_controller#create に既に images: [] 許可があるため、フォーム側で file_field_tag "review[images][]", multiple: true を使えば良い（app/views/reviews/new.* を参照）。
  - 店舗一覧に写真グリッドを追加する場合: app/assets/stylesheets/application.css の .photo-grid / .photo-card を流用。

- **デバッグ / テスト時の注意**
  - system テストを実行する際はブラウザドライバとヘッドレス設定を確認。Gemfile に selenium-webdriver がある。
  - Windows 環境向けに tzinfo-data が含まれている点を意識する（Gemfile）。

- **実装パターンのチェックポイント（PR/変更時の簡易チェック）**
  - ルーティングの変更は config/routes.rb を更新し、ネスト整合性を確認する。
  - DB スキーマ変更は必ずマイグレーションを追加し、schema.rb をコミットする。
  - JS 追加は app/javascript/controllers に Stimulus controller を置き、importmap 設定を確認する。

フィードバック: 不明点や追加したい具体的なガイド（例: DB シード手順、CI コマンド、Windows 固有設定）があれば教えてください。これを元に追記・修正します。

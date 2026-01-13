# JIRO REVIEW

# 概要
ラーメン店の情報と口コミを共有できるWebアプリです。

# 技術スタック
Ruby on Rails
ActiveStorage
Cloudinary（画像ストレージ）
PostgreSQL
Heroku
HTML / CSS /javascript

# 主な機能
ユーザー登録 / ログイン
店舗の新規登録
店舗写真・メニュー写真のアップロード
口コミ投稿・星評価
# 環境構築
cd jiro_review
bundle install
bin/rails db:create db:migrate
bin/rails s
# 本番環境
https://pacific-tor-87564-ea572241583d.herokuapp.com/
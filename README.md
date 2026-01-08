# JIRO REVIEW

## 概要
ラーメン店の情報と口コミを共有できるWebアプリです。

# 使用技術
- Ruby 3.2.2
- Ruby on Rails 7.1.2
- SQLite3
- ActiveStorage
- HTML / CSS

# 主な機能
- ユーザー登録 / ログイン
- 店舗の新規登録
- 店舗写真・メニュー写真のアップロード
- 口コミ投稿・星評価
- レスポンシブ対応

## 環境構築
```bash
cd jiro_review
bundle install
bin/rails db:create db:migrate
bin/rails s

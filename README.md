#dbの構造
| users    | label      |task         |
|:-----------:|:------------:|:------------:|
| id      | id      | id      |
| name     | user_id      | title       |
| email  | task_id    | content   |
| password |    |        |
#dbの構造テスト
|  TH  |  TH  |
| ---- | ---- |
|  TD  |  TD  |
|  TD  |  TD  |

#Herokuのデプロイ手順 linux command
- step1 Herokuにログイン、アプリ作成、precompile
  - $ heroku login
  - $ heroku create
  - $ rails assets:precompile
- step2 Herokuの環境構築
  - heroku buildpacks:set heroku/ruby
  - heroku buildpacks:add --index 1 heroku/nodejs
- step3 ひとまず　git add,commitした後masterにpush
  - $ heroku login
  - $ heroku create
  - $ rails assets:precompile
- step4 Herokuへデプロイ後、マイグレション後、そのアプリへダイブ！！！
  - $ git push heroku master
  - $ heroku run rails db:migrate
  - $ heroku open

# テスト環境

###
# ユーザー
###

# メインのサンプルユーザーを1人作成する
User.create!(name:  "Admin User",
  email: "admin@example.com",
  password:              "adminpassword",
  password_confirmation: "adminpassword",
  admin: true)

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = (0...24).map{ (65 + rand(26)).chr }.join # ランダム文字列
  User.create!(name:  name,
      email: email,
      password:              password,
      password_confirmation: password)
end

# ゲストユーザー
guestUser = User.create!(name:  "ゲストユーザー",
  email: "guest@example.com",
  password:              "password",
  password_confirmation: "password")


###
# ポスト
###

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

###
# リレーションシップ
###

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# ゲストユーザー
following.each { |followed| guestUser.follow(followed) }
followers.each { |follower| follower.follow(guestUser) }

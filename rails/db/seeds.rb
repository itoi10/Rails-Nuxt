# 環境毎に読み込むファイルを変更する
path = Rails.root.join("db/seeds/#{Rails.env}.rb")

# ファイルが存在しない場合はdevelopmentディレクトリを読み込む
path = path.sub(Rails.env, 'development') unless File.exist?(path)

puts "load file: #{path}"
require path

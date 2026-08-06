# bin/rails db:seed で実行される初期データ投入ファイル
# 何度実行しても同じ結果になるよう find_or_create_by! を使う（冪等性）

category_names = [
  "トレーディングカード",
  "ガチャガチャ",
  "フィギュア",
  "アクリルスタンド",
  "缶バッジ",
  "キーホルダー",
  "ぬいぐるみ",
  "シール",
  "その他"
]

category_names.each do |name|
  Category.find_or_create_by!(name: name)
end

puts "Created #{Category.count} categories"

User.find_or_create_by!(email: "test@example.com") do |user|
  user.name = "テストユーザー"
  user.profile = "開発用アカウント"
  user.encrypted_password = "dummy"
end

puts "Created #{User.count} users"

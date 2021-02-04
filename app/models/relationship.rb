class Relationship < ApplicationRecord
  # followersテーブルを参照しにいってしまいエラーにならないようクラス名（モデル名）を指定
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end

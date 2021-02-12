class Chat < ApplicationRecord
  # ユーザーが発言した内容を保存するテーブル
  belongs_to :user
  belongs_to :room
end

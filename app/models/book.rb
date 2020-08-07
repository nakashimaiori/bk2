class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}


	# favorited_by?メソッドを作成
	# このメソッドで、引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調る
    # 存在していればtrue、存在していなければfalseを返す
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
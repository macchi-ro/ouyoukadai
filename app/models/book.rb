class Book < ApplicationRecord


    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :favorites, dependent: :destroy


    validates :title, presence: true
    validates :body, presence: true, length: {maximum: 200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
    # 検索条件の分岐
    def self.looks(search, word)
      if search == "perfect_match"
        @book = Book.where("title LIKE?", "#{word}")
      elsif search == "foward_match"
        @book = Book.where("title LIKE?", "#{word}%")
      elsif search == "backward_match"
        @book = Book.where("title LIKE?", "%#{word}")
      elsif search == "partial_match"
        @book = Book.where("title LIKE?", "%#{word}%")
      else
        @book = Book.all
      end
    end

end

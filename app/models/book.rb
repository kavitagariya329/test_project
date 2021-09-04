class Book < ApplicationRecord
	has_many :book_ratings, dependent: :destroy
end

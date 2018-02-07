class Post < ApplicationRecord

	# Validating user attributes
	validates :contents, presence: true, length: { maximum: 50 }
	validates :author, presence: true

end

class Note < ApplicationRecord
  belongs_to :user
  belongs_to :purchasing_request
end

class Restaurant < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :uniq_key, uniqueness: true

  scope :duplicate,  -> (uniq_key) { where(uniq_key: uniq_key) }
end

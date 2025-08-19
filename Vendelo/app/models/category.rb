class Category < ApplicationRecord
  # asginamos que tiene varios productos 
  has_many :products, dependent: :restrict_with_exception
end

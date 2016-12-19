class Country < ActiveRecord::Base
	has_and_belongs_to_many :services
	accepts_nested_attributes_for :services
	has_many :cities

	validates_uniqueness_of :name, :message => "already exists"
	validates_uniqueness_of :world110_id, :message => "already exists"
	validates_presence_of :name, :world110_id
end

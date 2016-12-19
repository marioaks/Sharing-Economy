class Service < ActiveRecord::Base
	has_and_belongs_to_many :countries
	accepts_nested_attributes_for :countries
	belongs_to :city

	validates_uniqueness_of :name
	validates_associated :countries
	validates_presence_of :name

	scope :topic, -> (topic) {where topic: topic }
end

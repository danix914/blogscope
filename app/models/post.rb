class Post < ActiveRecord::Base
  validates :name,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 5 }

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
#  has_many :comments, :dependent => :destroy
#  has_many :tags
#
#  accepts_nested_attributes_for :tags, :allow_destroy => :true,
#    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  scope :publiced, where(:is_public => true)
  scope :secret, where(:is_public => false)
  scope :is_publiced, lambda { |show| where(:is_public => show) }
end

# == Schema Information
#
# Table name: posts
#
#  id         :integer(4)      not null, primary key
#  is_public  :boolean(1)
#  name       :string(255)
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#


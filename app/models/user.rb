class User < ActiveRecord::Base
  has_many :responses, :dependent => :destroy
end

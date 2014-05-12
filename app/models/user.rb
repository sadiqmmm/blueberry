class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :articles
  has_many :comments
	
  # Roles
  enum role: [:authenticated, :moderator, :admin]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :authenticated
  end
end

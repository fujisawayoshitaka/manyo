class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  before_validation { email.downcase! }
  #before_update :admin_user_present
  #before_destroy :admin_user_present
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy
   #def admin_user_present
    # raise ActiveRecord::Rollback if User.where(admin: true).count == 1
   #end
   before_destroy do
    throw(:abort) if User.where(admin: true).count <= 1 && self.admin?
  end

  before_update do
    throw(:abort) if User.where(admin: true).count <= 1
  end

end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :image,
		TodoTimer::Configuration.paperclip_options[:users][:image]
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ }

  after_create :create_default_list
  before_create :update_login_values

  has_many :lists

  def self.fetch_by_login_token(login_token)
  	User.where(login_token: login_token).first
  end

  def image_url
    image.try(:url)
  end

  private

    def update_login_values
      self.login_token = SecureRandom.hex(4)
      self.online = true
    end

    def create_default_list
      List.create(name: "Todo", user_id: id)
    end

end

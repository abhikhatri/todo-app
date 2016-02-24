class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :image,
		TodoTimer::Configuration.paperclip_options[:users][:image]
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ }

  after_create :create_default_list
  before_create :add_evaluators_data
  after_create :add_invitation_code
  after_create :update_invitation_accepted
  before_create :update_login_values

  has_many :lists
  has_many :evaluators, foreign_key: :reffered_by_id, class_name: "User"

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

    def add_invitation_code
      self.invitation_code = self.name.split(" ").first + SecureRandom.hex(3)
    end

    def create_default_list
      List.create(name: "Todo", user_id: id)
    end

    def add_evaluators_data
      if !self.invitation_code.nil?
        user = User.where(invitation_code: self.invitation_code).first 
        self.reffered_by_id = user.id
        self.is_evaluator = true
      end
    end

    def update_invitation_accepted
      if is_evaluator
        User.where(id: reffered_by_id).first.update_attributes(invitation_accepted: true)
      end
    end

end

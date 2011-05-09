class User < ActiveRecord::Base

  include Humanizer
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login,
    :first_referral_person_name, :first_referral_person_year,
    :second_referral_person_name, :second_referral_person_year,
    :third_referral_person_name,:third_referral_person_year,
    :additional_message, :profile_attributes, :terms_of_service
  attr_accessible :humanizer_answer, :humanizer_question_id  
  require_human_on :create
  before_save :require_references
#  validates :password, :presence => true
#  validates :password_confirmation, :presence => true

  validates :login, :presence => true,
    :length => {:within => 3..25},
    :uniqueness => true, :format=> {:with => /^\w+$/i, :message=>"can only contain letters and numbers."}
  
  validates_acceptance_of  :terms_of_service, :message => "Must be accepted"

  validates :requested_new_email, :format=> {:with => /^([^@\s]{1}+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message=>'does not look like an email address.', :if => proc {|obj| !obj.requested_new_email.blank?}}
  
  has_one :profile
  has_many :authentications
  accepts_nested_attributes_for :profile
  
  def is_admin
    return true if self.admin == true
  end

  def generate_confirmation_hash!(secret_word= "pimpim")
    self.confirmation_token = Digest::SHA1.hexdigest(secret_word + DateTime.now.to_s)
  end

  def match_confirmation?(user_hash)
    (user_hash.to_s == self.confirmation_token)
  end

  def request_email_change!(new_email)
    self.errors.add( :requested_new_email, "Cannot be Blank") and
      return false if new_email.blank?
    self.requested_new_email = new_email
    self.generate_confirmation_hash!
    self.confirmation_sent_at= DateTime.now
    self.save
  end

  def check_authentication(type)
    self.authentications.where(:provider => type)
  end

  def match_details
    StudentCheck.match_details?(self.profile, false)
  end

  def require_references
    if !profile.is_active && !match_details && [first_referral_person_name, first_referral_person_year,
        second_referral_person_name,second_referral_person_year,
        third_referral_person_name, third_referral_person_year, additional_message ].reject!(&:blank?).blank?
      errors.add_to_base("Hey! It seems our database from school is incomplete, or has a poor spelling of your name.
                  Do you mind giving us some references so we can activate you manually instead?")
      return false
    end
    return true
  end

end
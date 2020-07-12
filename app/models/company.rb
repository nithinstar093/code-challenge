class Company < ApplicationRecord
  has_rich_text :description

  after_initialize :assign_city_and_state

  validate :verify_email

  def assign_city_and_state
    details = ZipCodes.identify(zip_code)
    unless details.nil?
      self.city = details[:city]
      self.state = details[:state_code]
    end
  end

  def verify_email
    if email.split("@").last != "getmainstreet.com"
      errors.add(:email, message: 'sorry, you should use getmainstreet.com domain')
    end unless email.blank?
  end

end

class Message < ApplicationRecord

  scope :needs_sending, -> { where(date_to_send: Date.today, sent: false) }

  validates :recipient_first_name, :sender_first_name, presence: true

  validates :recipient_email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "That email address is invalid" }

  before_validation :add_date_to_send
  validate :ensure_only_one_per_day

  def dupe_exists_for_date?
    Message
      .where(recipient_email: recipient_email, date_to_send: date_to_send)
      .count > 0
  end

  def to_param
    self.class.secret.encode(id)
  end

  def self.secret
    @secret_hash ||= ::Hashids.new(ENV['HASH_SECRET'] || "", 8)
  end

  private

  def add_date_to_send
    if date_to_send.nil?
      self.date_to_send = Date.today
    end
  end

  def ensure_only_one_per_day
    if new_record? && dupe_exists_for_date?
      errors.add(:recipient_email, "That email address is already signed up to receive an email today")
    end
  end
end

class MessageMailer < ApplicationMailer
  def lottery(message)

    @message = message
    @recipient = message.recipient_first_name
    @formatted_date = message.date_to_send.strftime("%B %-d, %Y 8:00pm")

    subject = "HAMILTON #{@formatted_date}: Lottery Results - YOU WON!"

    mail(
      to: message.recipient_email,
      subject: subject
    )

    message.update(sent: true)
  end
end


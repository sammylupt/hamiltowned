namespace :send_emails do
  task lottery: :environment do
    # need to send at ~4:15 EST.
    # Heroku scheduler only allows one-day tasks at :00 and :30
    # Instead, run every 10 minutes and check the range we are in
    send_emails if inside_date_range?
  end

  task time_check: :environment do
    puts inside_date_range? ? "Inside range" : "Outside range"
  end
end

def inside_date_range?
  time_now = DateTime.now.in_time_zone('Eastern Time (US & Canada)')
  lower_bound = time_now.midnight + 16.hours + 10.minutes
  upper_bound = lower_bound + 9.minutes

  (lower_bound..upper_bound).cover?(time_now)
end

def send_emails
  puts "Inside date range, sending emails"

  Message.needs_sending.each do |message|
    begin
      MessageMailer.lottery(message).deliver
    rescue
      puts "Error sending message number #{message.id}"
    end
  end
end

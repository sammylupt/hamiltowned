namespace :send_emails do
  task :lottery do
    Message.needs_sending.each do |message|
      begin
        MessageMailer.lottery(@message).deliver
      rescue
        puts "Error sending message number #{message.id}"
      end
    end
  end
end

class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :crying_jordan, :email]

  def show
    is_today = @message.date_to_send == Date.today

    unless is_today
      raise ActionController::RoutingError.new("Not Found")
    end
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to @message
    else
      render :new
    end
  end

  def crying_jordan
  end

  def email
    @recipient = @message.recipient_first_name
    @formatted_date = @message.date_to_send.strftime("%B %-d, %Y 8:00pm")
  end

  def testing
    @message = Message.find(1)
    MessageMailer.lottery(@message).deliver
  end

  private

  def set_message
    results = Message.secret.decode(params[:id])
    id = results && results.first

    if id
      @message = Message.find(id)
    else
      raise ActionController::RoutingError.new("Not Found")
    end
  end

  def message_params
    params.require(:message).permit(:sender_first_name, :recipient_first_name, :recipient_email)
  end
end

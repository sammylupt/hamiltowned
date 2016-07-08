class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :crying_jordan]
  before_filter :ensure_auth, only: [:send_test_email]

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

  def send_test_email
    @message = Message.find(1)
    MessageMailer.lottery(@message).deliver
    render nothing: true
  end

  def ensure_auth
    authenticate_or_request_with_http_basic('Administration') do |u, p|
      u == ENV['ADMIN_NAME'] && p == ENV['ADMIN_PASS']
    end
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

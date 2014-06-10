class NotificationsController < ApplicationController
  def index
  end

  def create
  	Notifier.gmail_message.deliver
  	flash[:notice] = 'Your message has been sent.'
  	redirect_to root_path
  end
end

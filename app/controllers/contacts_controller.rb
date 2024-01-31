class ContactsController < ApplicationController
  skip_before_action :require_login

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.login_user = 'name:' + current_user.name + ',id:' + current_user.id.to_s if logged_in?
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to done_contacts_path
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def done;end

  private

  def contact_params
    params.require(:contact).permit(:name,:email,:email_confirmation,:subject,:message)
  end
end

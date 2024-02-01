# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def contact
    contact = Contact.new(name: '侍 太郎', email: 'exmample.com', subject: 0, message: '問い合わせメッセージ', login_user: 'name:taro,id:1')

    ContactMailer.send_mail(contact)
  end
end

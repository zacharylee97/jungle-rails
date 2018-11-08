class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def recepit(order, purchase)
    @order = order
    @purchase = purchase
    @total = @order.total_cents.to_f / 100
    mail(to: @order.email, subject: "Order ##{@order.id}")
  end
end

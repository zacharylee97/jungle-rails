# Jungle

A mini e-commerce application built with Rails where visitors can browse the catalogue, add items to the cart and checkout using Stripe. A receipt will also be sent to the email provided. Visitors can create an account and log in, which allows them to write reviews and rate the products. Admin features include viewing the dashboard, adding a product and creating a new category.


## Final Product

!["Screenshot of Jungle homepage"](https://github.com/zacharylee97/jungle-rails/blob/dev/docs/jungle_homepage.png?raw=true)
!["Screenshot of product information"](https://github.com/zacharylee97/jungle-rails/blob/dev/docs/product_information.png?raw=true)
!["Screenshot of product reviews"](https://github.com/zacharylee97/jungle-rails/blob/dev/docs/cart.png?raw=true)
!["Screenshot of cart"](https://github.com/zacharylee97/jungle-rails/blob/dev/docs/product_reviews.png?raw=true)
!["Screenshot of order details"](https://github.com/zacharylee97/jungle-rails/blob/dev/docs/order_details.png?raw=true)


## Setup

1. Fork & Clone
2. Run `bundle install` to install dependencies
3. Create `config/database.yml` by copying `config/database.example.yml`
4. Create `config/secrets.yml` by copying `config/secrets.example.yml`
5. Run `bin/rake db:reset` to create, load and seed db
6. Create .env file based on .env.example
7. Sign up for a Stripe account
8. Put Stripe (test) keys into appropriate .env vars
9. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe

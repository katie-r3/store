# Store
See it in action: https://intense-spire-74031.herokuapp.com/

Rails store application.

Created using:

* Rails 5.1.4

* Ruby 2.4.0

* Redis

* MySQL

* Stripe (for receiving payments) - to run a mock payment, enter '4242 4242 4242 4242' and any future expiration date and 3 digit security code you like.

* Lob (for verifying user's address upon sign up) - for it to work properly a live api key is required, which is not free. This feature doesn't currently work

Some future fixes/ideas:

* Styling needs some work

* Mailer sends email when purchase is complete, but the email doesn't show what the user bought or how much was spent

* Mailer emails when inventory is at 0.

* Users are prevented from adding more than the current quantity of an item

* Users can only leave one review per item

* Users can sort the items by category

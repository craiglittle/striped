# Striped

A clean, stripped-down implementation of Ruby bindings for the Stripe API.

[![Build Status](https://travis-ci.org/craiglittle/striped.png?branch=master)][build_status]
[![Dependency Status](https://gemnasium.com/craiglittle/striped.png)][dependencies]
[![Coverage Status](https://coveralls.io/repos/craiglittle/striped/badge.png?branch=master)][coverage_status]

[build_status]: https://travis-ci.org/craiglittle/striped
[dependencies]: https://gemnasium.com/craiglittle/striped
[coverage_status]: https://coveralls.io/r/craiglittle/striped


## Why?

* A simple codebase that leverages modern gems
* Complete test coverage
* Minimize number of HTTP requests to get stuff done


## Installation
```ruby
gem install striped
```


## Configuration

```ruby
Striped.api_key     = 'GfbUbdY08Qa8sBPXS3L8lofLiSBSkKNl'
Striped.api_version = '2013-02-13'
```


## Usage

### Charges

```ruby
# Create a charge
Striped.charge.create(
  amount:      400,
  currency:    'usd',
  card:        'tok_Di6658V24SxcHz',
  description: 'Charge for test@example.com'
)

charge = Striped.charge('ch_1bJAHzdT333Rq1')

# Fetch a charge
charge.fetch

# Refund a charge
charge.refund

# Capture a charge
charge.capture

# Fetch a collection of charges
Striped.charge.all(count: 3)
```

### Customers

```ruby
# Create a customer
Striped.customer.create(
  description: 'Customer for test@example.com',
  card:        'tok_Di6658V24SxcHz'
)

customer = Striped.customer('cus_1bJAvgSTOS4jUc')

# Fetch a customer
customer.fetch

# Update a customer
customer.update(
  description: 'Customer for test@example.com',
  card:        'tok_Di6658V24SxcHz'
)

# Delete a customer
customer.delete

# Fetch a list of customers
Striped.customer.all
```

### Subscriptions

```ruby
subscription = Striped.customer('cus_1bJAvgSTOS4jUc').subscription

# Update a customer's subscription
subscription.update(
  plan:    'basic',
  prorate: true
)

# Cancel a customer's subscription
subscription.cancel
```

### Plans

```ruby
# Create a subscription plan
Striped.plan.create(
  amount:   2000,
  interval: 'month',
  name:     'Amazing Gold Plan',
  currency: 'usd',
  id:       'gold'
)

plan = Striped.plan('gold')

# Fetch a subscription plan
plan.fetch

# Update a subscription plan
plan.update(name: 'New plan name')

# Delete a subscription plan
plan.delete

# Fetch a list of subscription plans
Striped.plan.all
```

### Coupons

```ruby
# Create a coupon
Striped.coupon.create(
 percent_off:        25,
 duration:           'repeating',
 duration_in_months: 3,
 id:                 '25OFF'
)

coupon = Striped.coupon('25OFF')

# Fetch a coupon
coupon.fetch

# Delete a coupon
coupon.delete

# Fetch a list of coupons
Striped.coupon.all
```

### Discounts

```ruby
# Delete a discount
Striped.customer('cus_1bJAvgSTOS4jUc').discount.delete
```

### Invoices

```ruby
# Create an invoice
Striped.invoice.create(customer: 'cus_1bJAvgSTOS4jUc')

invoice = Striped.invoice('in_1bJATFdV1Kq2RF')

# Fetch an invoice
invoice.fetch

# Fetch an invoice's line items
invoice.lines(count: 5, offset: 5)

# Pay an invoice
invoice.pay

# Update an invoice
invoice.update(closed: true)

# Fetch an upcoming invoice
Striped.invoice.upcoming(customer: 'cus_1bJAvgSTOS4jUc')

# Fetch a list of invoices
Striped.invoice.all(customer: 'cus_1bJAvgSTOS4jUc', count: 3)
```

### Invoice Items

```ruby
# Create an invoice item
Striped.invoice_item.create(
  customer:    'cus_1bJAvgSTOS4jUc',
  amount:      1000,
  currency:    'usd',
  description: 'One-time setup fee'
)

invoice_item = Striped.invoice_item('ii_1bJAM9yq8uyTqX')

# Fetch an invoice item
invoice_item.fetch

# Update an invoice item
invoice_item.update(
  amount:      1500,
  description: 'Customer for test@example.com'
)

# Delete an invoice item
invoice_item.delete

# Fetch a list of invoice items
Striped.invoice_item.all
```

### Disputes

```ruby
# Update a dispute
Striped.dispute(charge: 'ch_1bJAHzdT333Rq1').update(
  evidence: "Here's evidence showing this charge is legitimate."
)
```

### Account

```ruby
# Fetch your account details
Striped.account.fetch
```

### Events

```ruby
# Fetch an event
Striped.event('evt_1bJAfQlZPK0kTM').fetch

# Fetch a list of events
Striped.event.all
```

### Tokens

```ruby
# Create a card token
Striped.token.create(
  card: {
    number:    '4242424242424242',
    exp_month: 4,
    exp_year:  2014,
    cvc:       314
  }
)

# Fetch a card token
Striped.token('tok_Di6658V24SxcHz').fetch
```


## Supported Ruby interpreters

This gem officially supports and is tested against the following Ruby interpreters:

* MRI 1.9.2
* MRI 1.9.3
* MRI 2.0.0
* JRuby in 1.9 mode
* Rubinius in 1.9 mode


## Contributing
Pull requests are welcome, but consider asking for a feature or bug fix first through the issue tracker. When contributing code, please squash sloppy commits aggressively and follow [Tim Pope's guidelines][tim_pope_guidelines] for commit messages.

[tim_pope_guidelines]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html


## Copyright
Copyright (c) 2013 Craig Little. See [LICENSE][license] for details.

[license]: https://github.com/craiglittle/hello_sign/blob/master/LICENSE.md

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
Striped.charge.create(
  amount:      400,
  currency:    'usd',
  card:        'tok_Di6658V24SxcHz',
  description: 'Charge for test@example.com'
)

Striped.charge('ch_1bJAHzdT333Rq1').fetch

Striped.charge('ch_1bJAHzdT333Rq1').refund

Striped.charge('ch_1bJAHzdT333Rq1').capture

Striped.charge.all(count: 3)

```

### Customers

```ruby
Striped.customer.create(
  description: 'Customer for test@example.com',
  card:        'tok_Di6658V24SxcHz'
)

Striped.customer('cus_1bJAvgSTOS4jUc').fetch

Striped.customer('cus_1bJAvgSTOS4jUc').update(
  description: 'Customer for test@example.com',
  card:        'tok_Di6658V24SxcHz'
)

Striped.customer('cus_1bJAvgSTOS4jUc').delete

Striped.customer.all
```

### Subscriptions

```ruby
Striped.customer('cus_1bJAvgSTOS4jUc').subscription.update(
  plan:    'basic',
  prorate: true
)

Striped.customer('cus_1bJAvgSTOS4jUc').subscription.cancel

Striped.plan.create(
  amount:   2000,
  interval: 'month',
  name:     'Amazing Gold Plan',
  currency: 'usd',
  id:       'gold'
)
```

### Plans

```ruby
Striped.plan('gold').fetch

Striped.plan('gold').update(name: 'New plan name')

Striped.plan('gold').delete

Striped.plan.all
```

### Coupons

```ruby
Striped.coupon.create(
 percent_off:        25,
 duration:           'repeating',
 duration_in_months: 3,
 id:                 '25OFF'
)

Striped.coupon('25OFF').fetch

Striped.coupon('25OFF').delete

Striped.coupon.all
```

### Discounts

```ruby
Striped.customer('cus_1bJAvgSTOS4jUc').discount.delete
```

### Invoices

```ruby
Striped.invoice.create(customer: 'cus_1bJAvgSTOS4jUc')

Striped.invoice('in_1bJATFdV1Kq2RF').fetch

Striped.invoice('in_1bJATFdV1Kq2RF').lines(count: 5, offset: 5)

Striped.invoice('in_1bJATFdV1Kq2RF').pay

Striped.invoice('in_1bJATFdV1Kq2RF').update(closed: true)

Striped.invoice.upcoming(customer: 'cus_1bJAvgSTOS4jUc')

Striped.invoice.all(customer: 'cus_1bJAvgSTOS4jUc', count: 3)
```

### Invoice Items

```ruby
Striped.invoice_item.create(
  customer:    'cus_1bJAvgSTOS4jUc',
  amount:      1000,
  currency:    'usd',
  description: 'One-time setup fee'
)

Striped.invoice_item('ii_1bJAM9yq8uyTqX').fetch

Striped.invoice_item('ii_1bJAM9yq8uyTqX').update(
  amount:      1500,
  description: 'Customer for test@example.com'
)

Striped.invoice_item('ii_1bJAM9yq8uyTqX').delete

Striped.invoice_item.all
```

### Disputes

```ruby
Striped.dispute(charge: 'ch_1bJAHzdT333Rq1').update(
  evidence: "Here's evidence showing this charge is legitimate."
)
```

### Account

```ruby
Striped.account.fetch
```

### Events

```ruby
Striped.event('evt_1bJAfQlZPK0kTM').fetch

Striped.event.all
```

### Tokens

```ruby
Striped.token.create(
  card: {
    number:    '4242424242424242',
    exp_month: 4,
    exp_year:  2014,
    cvc:       314
  }
)

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

# Bot

DB Bot uses Natural Language Processing (NLP) to construct DB queries. What that means is you can interact with your database like you're talking to a human
**Here's an example**

```ruby
> bot = DbBot.message('How many users signed up this week?')
> bot.response
=> "5 users"
> bot = DbBot.message('Find the last 10 users') 
> bot.response
=> "There you go"
> bot.collection
=> #<ActiveRecord::Relation [#<User id: 1...
```
It's rather primative at the moment but I'm working on incorporating more complex database queries in the future!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'db_bot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install db_bot

## Usage

TODO: Write usage instructions here

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/bot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


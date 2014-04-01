# GLSAgent

Log into GLS webpage, create a new parcel sticker and save it to disk

## Installation

Add this line to your application's Gemfile:

    gem 'gls_agent'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gls_agent

## Usage

There is a small standalone script:

    $ gls_agent -u glsuser -p glspass --compact "John Doe,Home Street,1,1234,City,1"

Note that while not gemified, use

    $ bundle exec

and

    $ bundle console

to play around.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/gls_agent/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

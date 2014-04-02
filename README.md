# GLSAgent

Log into GLS (General Logistics Systems) webpage, create a new parcel sticker and save it to disk.

You'll need a "Easy-Start"/"Your GLS" account to do so.

## Installation

Add this line to your application's Gemfile:

    gem 'gls_agent'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gls_agent

## Usage

There is a small standalone script:

    $ gls_create_label -u glsuser -p glspass -d "John Doe,Home Street,1,1234,City,1" -o output.pdf

Note that while not gemified, use

    $ bundle exec bin/gls_create_label ...

and

    $ bundle console

to play around.

## Configuration

You can invoke gls_agent without any configuration by specifying command line parameters.
If you do not want to retype your gls credentials or do not want them to travel the wire (ssh), be present in the history (i.e. bash) or visible in the process list, you can put credentials or delivery details in ~/.gls_agent .

Its syntax follows the

    option=value

scheme, where option can be anything of: user, pass, name, street, streetno, zip, city, weight, output_file .

## Contributing

1. Fork it ( https://github.com/[my-github-username]/gls_agent/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

# GLSAgent

Log into the German GLS (General Logistics Systems) webpage, create a new parcel sticker (for Germany) and save it to disk.

You'll need a "Easy-Start"/"Your GLS" account to do so.

## Installation

Add this line to your application's Gemfile:

    gem 'gls_agent'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gls_agent

## Usage

### Usage as standalone tool

There is a small standalone script:

    $ gls_create_label -u glsuser -p glspass -l "12.12.2014,John Doe,Companyname,Home Street,1,1234,City,1" -o output.pdf

Multiple labels can be created by not passing the data via --label-data or -l flag but by shoving in a file as argument (which contains mutliple lines that conform to the same format then with the -l flag):

    $ gls_create_label -u glsuser -p glspass parcel_label_data.csv

Note that while not gemified, use

    $ bundle exec bin/gls_create_label ...

and

    $ bundle console

to play around.

### Usage as lib

To use gls_agent in your ruby project, install the gem and use something along these lines:

    options = GLSAgent::Dotfile::get_opts
    mech = GLSMech.new
    mech.user = options[:user]
    mech.pass = options[:pass]

    GLSAgent::ParcelJob.new('31.01.2014','Frank Sinatra','CloudStreet','1',1234,'HeavenCity','1')
    saved_as = mech.save_parcel_label parcel,'gls_label_frank_sinatra.pdf'

### Configuration

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

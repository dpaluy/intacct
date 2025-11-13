# Intacct Ruby Gem

[![Gem Version](https://badge.fury.io/rb/intacct.svg)](https://badge.fury.io/rb/intacct)
[![Documentation](https://img.shields.io/badge/docs-rubydoc.info-blue.svg)](https://rubydoc.info/gems/intacct)
[![CI](https://github.com/dpaluy/intacct/workflows/CI/badge.svg)](https://github.com/dpaluy/intacct/actions)

A Ruby gem for interacting with the [Sage Intacct API](https://developer.intacct.com/api/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem "intacct"
```

Then execute:

```bash
bundle install
```

Or install it yourself:

```bash
gem install intacct
```

**Requirements:** Ruby 3.2 or higher.

## Usage

### Configuration

Configure the gem with your Intacct credentials:

```ruby
Intacct.configure do |config|
  config.sender_id = ENV["INTACCT_SENDER_ID"]
  config.sender_password = ENV["INTACCT_SENDER_PASSWORD"]
end
```

**Security Note:** Never commit credentials to version control. Use environment variables or a secrets management system.

### Making Requests

#### Query Records

Query Intacct objects with filters and sorting:

```ruby
query = Intacct::Functions::Query.new(
  object: "CUSTOMER",
  select: ["CUSTOMERID", "NAME", "EMAIL", "STATUS"],
  filter: { "STATUS" => "active" },
  order: { "NAME" => "asc" }
)

request = Intacct::Request.new
request.use_credentials_authentication(
  user_id: ENV["INTACCT_USER_ID"],
  company_id: ENV["INTACCT_COMPANY_ID"],
  user_password: ENV["INTACCT_USER_PASSWORD"]
)
request.add_function(query, "query-001")

response = Intacct::Gateway.new.send_request(request)

if response.successful?
  result = response.get_function_result("query-001")
  if result.successful?
    customers = result.data
    customers.each do |customer|
      puts "#{customer['CUSTOMERID']}: #{customer['NAME']}"
    end
  else
    puts "Function error: #{result.errors.join(', ')}"
  end
else
  puts "Request failed"
end
```

#### Create Records

Create new records in Intacct:

```ruby
create = Intacct::Functions::Create.new(
  object: "CUSTOMER",
  fields: {
    "CUSTOMERID" => "C-001",
    "NAME" => "Acme Corporation",
    "EMAIL" => "contact@acme.com",
    "STATUS" => "active"
  }
)

request = Intacct::Request.new
request.use_credentials_authentication(
  user_id: ENV["INTACCT_USER_ID"],
  company_id: ENV["INTACCT_COMPANY_ID"],
  user_password: ENV["INTACCT_USER_PASSWORD"]
)
request.add_function(create, "create-001")

response = Intacct::Gateway.new.send_request(request)

if response.successful?
  result = response.get_function_result("create-001")
  puts "Customer created!" if result.successful?
end
```

#### Update Records

Update existing records:

```ruby
update = Intacct::Functions::Update.new(
  object: "CUSTOMER",
  keys: { "CUSTOMERID" => "C-001" },
  fields: {
    "EMAIL" => "newemail@acme.com",
    "STATUS" => "inactive"
  }
)

request = Intacct::Request.new
request.use_credentials_authentication(
  user_id: ENV["INTACCT_USER_ID"],
  company_id: ENV["INTACCT_COMPANY_ID"],
  user_password: ENV["INTACCT_USER_PASSWORD"]
)
request.add_function(update, "update-001")

response = Intacct::Gateway.new.send_request(request)
```

#### Read by ID

Read a specific record by ID:

```ruby
read = Intacct::Functions::Read.new(
  object: "CUSTOMER",
  keys: "C-001",
  fields: ["CUSTOMERID", "NAME", "EMAIL"]
)

request = Intacct::Request.new
request.use_credentials_authentication(
  user_id: ENV["INTACCT_USER_ID"],
  company_id: ENV["INTACCT_COMPANY_ID"],
  user_password: ENV["INTACCT_USER_PASSWORD"]
)
request.add_function(read, "read-001")

response = Intacct::Gateway.new.send_request(request)
```

#### Case-Insensitive Queries

Perform case-insensitive queries:

```ruby
query = Intacct::Functions::Query.new(
  object: "CUSTOMER",
  select: ["CUSTOMERID", "NAME"],
  filter: { "NAME" => "acme" },
  case_insensitive: true
)
```

### Error Handling

Always check response status and handle errors:

```ruby
response = Intacct::Gateway.new.send_request(request)

if response.successful?
  result = response.get_function_result("my-control-id")
  if result.successful?
    puts "Success: #{result.data}"
  else
    puts "Function error: #{result.errors.join(', ')}"
  end
else
  puts "Request failed"
end
```

### Session Authentication

Get an API session for subsequent requests:

```ruby
get_session = Intacct::Functions::GetApiSession.new(location_id: "US")

request = Intacct::Request.new
request.use_credentials_authentication(
  user_id: ENV["INTACCT_USER_ID"],
  company_id: ENV["INTACCT_COMPANY_ID"],
  user_password: ENV["INTACCT_USER_PASSWORD"]
)
request.add_function(get_session, "session-001")

response = Intacct::Gateway.new.send_request(request)

if response.successful?
  result = response.get_function_result("session-001")
  if result.successful?
    session_id = result.data["sessionid"]
    # Use session_id for subsequent requests
  end
end
```

## Available Functions

- **Query** - Execute read queries with filters and sorting
- **Create** - Create new records
- **Read** - Read specific records by ID
- **Update** - Update existing records
- **CreateArAdjustment** - Create AR adjustments
- **GetApiSession** - Get API session for authentication
- **RetrievePdf** - Retrieve PDF documents
- **ReversePayment** - Reverse payments

For detailed API documentation, see [RubyDoc](https://rubydoc.info/gems/intacct).

## Development

After checking out the repo, run:

```bash
bundle install
```

Run tests:

```bash
bundle exec rake test
```

Run linter:

```bash
bundle exec rubocop
```

Generate documentation:

```bash
bundle exec yard doc
bundle exec yard server  # View docs at http://localhost:8808
```

To install this gem onto your local machine:

```bash
bundle exec rake install
```

To release a new version:

1. Update version in `lib/intacct/version.rb`
2. Update `CHANGELOG.md`
3. Commit changes
4. Run `bundle exec rake release` (creates tag and pushes to RubyGems)

## Contributing

1. Fork it (https://github.com/dpaluy/intacct/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Please ensure:
- Tests pass (`bundle exec rake test`)
- Code follows style guide (`bundle exec rubocop`)
- New features include tests and documentation

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).

## Copyright

Copyright (c) 2022-2025 David Paluy. See LICENSE.txt for further details.

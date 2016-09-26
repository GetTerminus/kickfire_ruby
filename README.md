# Kick Fire Ruby
Ruby Gem for talking to the Kickfire api

Kickfire provides information about a company or ip address, including
address and social data.

### Setup
Put your kickfire api key in `config/initializers/kickfire.rb` as a constant,
like

```ruby
module Kickfire
 API_KEY = 'valid_api_key_here'
end
```

### Usage
```ruby
Kickfire::Company.find("#{ip_address_of_company to look up}")
#
# an instance of KickFire::Company with public methods based on results
#

```
#### Public methods
 * cid  
 * name  
 * website  
 * street  
 * city  
 * regionShort  
 * region  
 * postal  
 * countryShort  
 * country  
 * phone  
 * employees  
 * revenue  
 * category  
 * site_code  
 * category2  
 * naics_code  
 * longitude  
 * lattitude  
 * stock_symbol  
 * facebook  
 * twitter  
 * linkedin  
 * linedkin_id  
 * isp  
 * to_json  
 * twitter_url  
 * address

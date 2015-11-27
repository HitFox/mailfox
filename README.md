![alt text](http://www.hitfoxgroup.com/downloads/hitfox_logo_with_tag_two_colors_WEB.png "Logo Hitfox Group")

Mailfox
==============

[![Build Status](https://img.shields.io/travis/HitFox/cm-sms-rails.svg?style=flat-square)](https://travis-ci.org/HitFox/mailfox)
[![Gem](https://img.shields.io/gem/dt/cm-sms-rails.svg?style=flat-square)](https://rubygems.org/gems/mailfox)
[![Code Climate](https://img.shields.io/codeclimate/github/HitFox/cm-sms-rails.svg?style=flat-square)](https://codeclimate.com/github/HitFox/mailfox)
[![Coverage](https://img.shields.io/coveralls/HitFox/cm-sms-rails.svg?style=flat-square)](https://coveralls.io/github/HitFox/mailfox)

The Mailfox gem lets you quickly add Mailchimp-integrated newsletter signup forms to your application. You can render these forms straight in your application or through the HitFox fork of Comfortable Mexican Sofa.

Installation
------------

Add this to your Gemfile:

```ruby
gem "mailfox", git: "git@github.com:HitFox/mailfox.git"
```

Add a `mailfox_settings.yml` file to your +config+ folder with the default configurations:

```ruby
  mailchimp:
    api_key:
    list_id:
      customer:
```

Add a `mailfox.rb` file to your `config/initializers` folder:

```ruby
  Mailfox.setup do |config|
    config.mailservices = YAML.load_file("#{Rails.root}/config/mailfox_settings.yml")
  end
```
  
Add the following line to your `routes.rb` file:

```ruby
  mount Mailfox::Engine => "/mp"
```

Usage
-----

You can now paste this into a view if you want to render a newsletter subscribe form:

```ruby
  <%= render partial: "mailfox/newsletters/form", locals: {placeholder: 'example@email.com', list_id: 'exampleID', disable_with_message: 'exampleMessage', submit_button_message: 'exampleSubmit'} %>
```

Or, if you are using the HitFox fork of CMS, you can create a snippet for easy use on your pages:

```
  {{ cms:field:newsletter.list_id }}
  {{ cms:field:newsletter.placeholder }}
  {{ cms:field:newsletter.disable_with_message }}
  {{ cms:field:newsletter.button }}

  {{ cms:partial:mailfox/newsletters/cms/form }}
```

Customizing Your Implementation
-------------------------------

You can customize most of the end-user behavior of the Mailfox to suit your own needs. If the default view structure does not work for you, add a new `_form.html.haml` file in `app/views/mailfox/newsletters`.

Success and errors can be customized in the `create.js.erb` file in the same directory.

One note: if you want to access your host application's helper methods, add a helper file like this in `app/helpers/mailfox/newsletters_helper.rb`:

```ruby
  Module Mailfox
    Module NewslettersHelper
      include ::MyHelper
    end
  end
```
Changelog
---------

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/HitFox/mailfox. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


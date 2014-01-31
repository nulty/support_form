# SupportForm

Pluggable support form creator. It stores statistics of inquiry types and sends email
when a support issues comes in.

## Install

Add this to your Gemfile

```ruby
# Gemfile

...
gem "support_form", git: "https://github.com/nulty/support_form.git"
```

Run ``rails g support_form:migrate`` to copy over all the migrations then run ``rake db:migrate`` to install them.


## License

This project uses MIT-LICENSE.
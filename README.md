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

Run ``rails g support_form:install`` to inject the helper into your applicaiton helper and copy over all the migrations then run ``rake db:migrate`` to install them.

You will then want to declare the association in the thing you want  to have a support form

```ruby
class Competition

  has_one :support_stats, as: :supportable, class_name: "SupportForm::Stat"
  ...
end
```

Then you can add a nested attributes form in the `competition` creation form or
just create one in the console

```ruby
Competition.create_support_stats(stats: {"Some support query topic" => 0}, recipient_email: "who_gets_the_support@emails.com")
```
## License

This project uses MIT-LICENSE.
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

Run ``rails g support_form:install`` to create the initializer and copy over all the migrations then run ``rake db:migrate`` to install them.

SupportForm::Stat is a polymorphic association through `:supportable`.

```ruby
class Competition

  has_one :support_stats, as: :supportable, class_name: "SupportForm::Stat"
  ...
end
```

To create a Stat, there is a nested attributes form partial available to render through `fields_for`, a stand alone form or
just create one in the console.

```ruby
Competition.create_support_stats(categories: {"Some support query topic" => 0}, recipient_email: "who_gets_the_support@emails.com")
```

## Usage
* 1
Create a new SupportForm::Stat for a given item. Make the `current_item` referencable in the view through `application_helper` or similar in Rails.
* 2
Drop the support form into the view using either of the view helpers
`support_form` and `support_modal`
There are two helper methods in this release. Drop either

```ruby
<%= support_form %>
```

```ruby
<%= support_modal %>
```

into any view to get the support form to get the form.

The modal depends on Bootstrap. To activate the modal you'll need a link on the page:

```html
<a href="#support-form" role="button" class="btn" data-toggle="modal">Request Support</a>
```

## License

This project uses MIT-LICENSE.
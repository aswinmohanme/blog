%{
  title: "Implementing Autocomplete Select in Rails 6",
  tags: ~w(rails),
  description: "Outlines how I got Select with autocomplete working with Rails 6."
}
---

`simple-form` makes creating forms that handle associations in rails a breeze. It creates a select dropdown that works really well for use cases where the number of records are few. But once the number of options in the select box gets over a certain number you would be doing your users a favor by implementing it an autocomplete box.

I ran into the same situation. I had a `Contact` table that `has_one: Panchayat` relation. I used `simple_form` to create the association select dropdown. I wanted to add autocomplete capabilities to it. The rails autocomplete libraries were either outdated or neede `jQuery` to support. I even asked on StackOverflow https://stackoverflow.com/questions/60520237/how-to-implement-autocomplete-for-association-in-simple-form-in-rails-6?noredirect=1#comment108147660_60520237 with no avail. After some more digging I used a raw javascript library all thanks to the new webpack integration of Rails.

## Meet Choices
Choices is a native JS libary with no dependencies that are designed for handling select boxes. Read more at https://joshuajohnson.co.uk/Choices/

## Setting up 
* Install Choices with `yarn add choices.js` in the project repo. The new webpack pipeline of Rails would handle all the bundling of the js code.

* In your `application.js` file add the below code. This would replace all the occurence of the class `#dropdown-choice-select` with the choice dropdown. Create a new `css/application.css` file in the javascript folder.

```
// Import css from js for webpack to process it correctly
import '../css/application.css'

// Add Choices Dropdown
const Choices = require('choices.js')
document.addEventListener("turbolinks:load", function() {
    var dropDownSelects = new Choices('#dropdown-choice-select')
})
```
* In your `application.css` file add the below line 
```
@import "choices.js/public/assets/styles/choices.css";
```

## Using it
To use it in a form to prefill an association all you have to do is 
```
<%= f.association :assoc_name, collection: Assoc.all(), input_html: {id: 'dropdown-choice-select'} %>
```

Choice would do it's magic and convert it into an awesome autocomplete select box.

For reference https://github.com/coronasafe/coronacell/

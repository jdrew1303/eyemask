# Eyemask

Eyemask allows you to generate rich documentation from your Cucumber specs. It works by taking the output of the JSON formatter and applying a [Liquid](http://liquidmarkup.org/) template to it. The result can be as simple as a plain text or Markdown file, or as complex as an HTML file ready to be rendered into PDF.

The purpose of Eyemask is to make it easy to maintain living documentation that can be used by the whole team -- from developers to designers to client stakeholders -- no matter whether they're more verbal or visual. It is based on some of the ideas of [Rich Pictures](http://en.wikipedia.org/wiki/Rich_picture) from soft systems research.

Eyemask assumes that the description blocks for features and scenarios (the plain text before any other content) are marked up using a variant of Markdown. We support running those blocks through Liquid, to allow template authors to use a powerful set of tags. These tags include `{% uml %}`, allowing you to embed UML diagrams using [PlantUML's syntax](http://plantuml.sourceforge.net/index.html).

This tool is still in its early days, and will evolve substantially as it is used in the wild. Please help us improve it by submitting feature requests, bug reports, and pull requests.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eyemask'
```

Or, for the latest development version:

```ruby
gem 'eyemask', git: 'https://github.com/wearefriday/eyemask'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eyemask

## Usage

Eyemask is designed to be used as part of a larger toolchain. Its most basic operation takes a JSON file and outputs a Markdown file to `STDOUT`.

    $ bundle exec eyemask process cucumber.json

We also support taking the JSON from `STDIN` by using `-` as the file name:

    $ cat cucumber.json | bundle exec eyemask process -

You can specify a custom template by providing the `--template` option:

    $ bundle exec eyemask process cucumber.json --template="path/to/template.html"

There are also some more built-in templates that can be used by refering to their name. For example, the [Prince XML](http://www.princexml.com/) template can be invoked as follows:

    $ bundle exec eyemask process cucumber.json --template=princexml

It also supports customisation via *parameters*. There are four primary parameters: title, subtitle, logo, and authors. These become top-level variables available to the template:

    $ bundle exec eyemask process cucumber.json --title="My Title Here"

You can also set custom parameters by passing a `--params` option. The parameters take the form 'key':'value':

    $ bundle exec eyemask process cucumber.json --params=my_param:"My Value" my_other_param:2

This list of options is likely to grow as we expand the use-cases of the tool.

## Coming soon

Here are some of the features that are planned for the future (in no particular order):

- More and improved named default templates to make Eyemask more powerful out of the box.

- Additional explanatory materials as Markdown files to explain more about your code.

- Providing textual syntaxes for more diagram types, including charts, for when you want to reduce the cost of change.

- Tags for footnotes, pullquotes, sidebars, and sidenotes. 

- Index and flexible, configurable Table of Contents generation (probably based on a similar 'two-pass' approach as used by LaTeX).

- Default metadata, such as the date and time of preparation.

- Additional standard metadata params, such as version, client, project, and copyright.

- A new textual syntax and diagram renderer for 'scenario flow diagrams' allowing links from blocks to scenarios or individual steps.

- A construct/tag for cross-references of scenarios, features, etc.

- Implement support for backgrounds and scenario outlines (with variable highlighting) in the default templates

## UML diagrams

Eyemask supports rich UML diagrams, for those occasions when a visual is the best way to explain a feature. This uses the [PlantUML](http://plantuml.sourceforge.net/index.html) command-line tool. To use this functionality, download the PlantUML JAR and create a shell script called `plantuml`, in your `PATH`, that executes the JAR passing all parameters.

## Standard templates

Eyemask currently includes 3 different standard templates that can be used by providing their name to the `--template` option:

- `--template=markdown` -- Produces a Markdown file that can be provided to tools such as Pandoc.
- `--template=princexml` -- A traditional 'book' template designed for use with PrinceXML.
- `--template=slides` -- A clean presentation template designed for use with PrinceXML.

These templates are being tweaked and improved. Other templates will likely be added over time.

## Making PDFs

This tool produces text files. These can be converted to nice PDFs using a few different tools. If you're producing your specifications for non-commercial uses, or have a licence, [Prince XML](http://www.princexml.com/) produces a very high quality of output. You can pipe the output of Eyemask directly into PrinceXML using a command such as:

    $ bundle exec cucumber --format json | bundle exec eyemask process - --template=slides | prince -o tmp/specification.pdf -

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/wearefriday/eyemask/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

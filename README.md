# GameTracker

An app to find and add games you own on the platforms you own them on to your personal game library. GameTracker was built with Sinatra and Active Record.

## Installation

To use GameTracker, you'll need a IGDB API key. You can sign up for one [here](https://api.igdb.com/).

Clone the repo and create a file called `keys.rb` in the `app` folder.

Add your key:

`$api_key = "YOUR_KEY"`

run:

```
bundle install

rake db:migrate
```

If you'd like to create additional sample users and start off with some games, run:
`rake db:seed`

If you'd like to start with no extra users or games already added, run:
`rake import_platforms`

run `Thin start` and go to `0.0.0.0:3000` in your browser

## Contributor's Guide

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org/) code of conduct.

## License

This project is licensed under the MIT License - see the LICENSE.md for details

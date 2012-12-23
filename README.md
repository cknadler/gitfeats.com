# gitfeats.com [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/cknadler/gitfeats.com) [![Dependency Status](https://gemnasium.com/cknadler/gitfeats.com.png)](https://gemnasium.com/cknadler/gitfeats.com) [![Build Status](https://travis-ci.org/cknadler/gitfeats.com.png)](https://travis-ci.org/cknadler/gitfeats.com)


A stats site for the [git-feats](https://github.com/cknadler/git-feats) gem. 

## Development

GitFeats is actively under development. Suggestions, issues and pull requests and welcomed with open arms.

### Getting Started

You are going to need the following:

* ruby 1.9.3-p194
* postgresql
* bundler

##### ruby

I recommend using [rbenv](https://github.com/sstephenson/rbenv),
and [ruby-build](https://github.com/sstephenson/ruby-build).

```bash
rbenv install 1.9.3-p194
rbenv global 1.9.3-p194
```

##### postgres

If you are running OSX, you can either install [postgres.app]() or install postgresql with brew: 

```bash
brew install postgresql
```

On Unix, install `postgresql` with your package manager. For example, with `apt-get` it would be:

```bash
sudo apt-get install postgresql
```

##### bundler

```bash
gem install bundler && rbenv rehash
bundle install
```

##### GitFeats setup

Create the database and load it with some test data:

```bash
bundle exec rake db:create:all
bundle exec rake db:migrate
bundle exec rake db:seed
```

Then, to get your server started:

```bash
bundle exec rails s
```

Now the app should be available at `localhost:3000`.

### Tests

Tests are written in RSpec with help from Capybara. Guard is configured to autotest. Simply run:

```bash
bundle exec guard
```

Alternatively, to run the tests without guard, run:

```bash
bundle exec rake
```

### Contributing

GitFeats can always use some extra attention. If you are thinking of adding a feature, refactoring some horrendous code, fixing a bug or writing some tests, have at it.

I reccomend the following:

* Fork the project.
* Make a feature branch: `git checkout -b feature_branch`
* Make your changes.
* Add tests.
* Send a pull request.

If you are stuck on something, like adding tests, open a pull request anyways. I'm always more than happy to help.

## Copyright

Copyright (c) 2012 Chris Knadler. See LICENSE for details.

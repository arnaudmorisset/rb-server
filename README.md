# RB Server

This is a simple abstraction on top of [Thin](https://github.com/macournoyer/thin).

This HTTP server can start, stop, handle `GET` requests and came with a default endpoint for `/health`.

> **This repository is not a library** and should be interesting mostly for me and my coworkers. 🙂

## Installation

Once you've cloned the repository:

```bash
# Use ASDF to install Ruby (or be sure to have the version specified in `.tool_versions` alread installed)
asdf install

# Install dependencies (you will need bundler, ran `gem install bundler` if not done yet)
bundle install

# Run tests
bundle exec rake test
```

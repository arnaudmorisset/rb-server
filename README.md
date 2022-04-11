# RB Server

> **This repository is not a library** and should be interesting only for me and my coworkers. 🙂

This is a simple abstraction on top of [Thin](https://github.com/macournoyer/thin).

This HTTP server can only start, stop, accept `GET` requests and handle `/health` by default.

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

# RB Server

Even when working in a gRPC-based services-oriented environment, it can sometimes be helpful to start an HTTP Server.
In my context, I needed a way to handle simple GET requests for mechanisms such as callbacks or any kind of "notification"
request that shouldn't go through an API gateway.

I knew I should write this HTTP server in Ruby, the primary programming language used in my company.
However, I didn't know if I should use Puma, Unicorn, Thin, or any other servers available in the Ruby ecosystem.
That's why I choose to prototype a common HTTP Server class.

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

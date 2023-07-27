FROM ruby:3.0-alpine
RUN apk add --no-cache build-base ruby-dev

RUN gem install bundler

WORKDIR /usr/src/app

COPY . .
RUN bundle install

CMD ["./bin/oak", "go", "-h", "irc.libera.chat", "-n", "oak[bot]"]
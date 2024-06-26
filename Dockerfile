FROM ruby:3.3-alpine
RUN apk add --no-cache build-base ruby-dev

RUN gem install bundler

WORKDIR /usr/src/app

COPY . .
RUN bundle install

CMD ["./bin/oak", "go"]

FROM ruby:2.6.3-alpine

ENV BUNDLER_VERSION=2.1.4
ENV RAILS_ENV=production

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      openssl \
      pkgconfig \
      postgresql-dev \
      tzdata

RUN gem install bundler -v $BUNDLER_VERSION

WORKDIR /app

COPY . ./

COPY Gemfile Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle check || bundle install --without test development


ENTRYPOINT ["bundle", "exec", "rails", "server",  "-b", "0.0.0.0"]

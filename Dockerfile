FROM ubuntu:20.04
MAINTAINER Dan Fithian
RUN apt-get update -qq -y && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y \
  build-essential \
  less \
  libicu-dev \
  libpq-dev \
  nodejs \
  npm \
  postgresql \
  ruby-full \
  sudo \
  vim \
  wget \
  zlib1g-dev
RUN gem install bundler
ADD Gemfile /
RUN bundler install
RUN decidim decidim_application
ADD seeds.rb /decidim_application/db/seeds.rb
RUN mkdir -p /usr/local/pgsql && \
  touch /var/log/postgres.log && \
  chown postgres:postgres /usr/local/pgsql && \
  chown postgres:postgres /var/log/postgres.log && \
  sudo -u postgres /usr/lib/postgresql/12/bin/initdb -E unicode -D /usr/local/pgsql/data
ENTRYPOINT cd decidim_application && \
  sudo -u postgres /usr/lib/postgresql/12/bin/pg_ctl -D /usr/local/pgsql/data/ -l /var/log/postgres.log start && \
  DATABASE_USERNAME=postgres bin/rails db:create db:migrate db:seed && \
  DATABASE_USERNAME=postgres bin/rails server -b 0.0.0.0

FROM ruby:3.2.2

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

# Install packages needed to build gems
RUN apt-get update -qq \
  && apt-get install -y build-essential libpq-dev libssl-dev postgresql-client \
  && apt-get -y remove libaom3

RUN mkdir /oshi_app
WORKDIR /oshi_app
# Install application gems
COPY Gemfile /oshi_app/Gemfile
COPY Gemfile.lock /oshi_app/Gemfile.lock

RUN bundle install

# Copy application code
COPY . /oshi_app

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
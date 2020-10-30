FROM ruby:2.6.6
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list \
    && apt update -qq && apt install -y vim build-essential libpq-dev nodejs yarn graphviz\
    && apt clean \
    && rm -r /var/lib/apt/lists/*
ENV APP_ROOT /mountain_app
WORKDIR /${APP_ROOT}
COPY Gemfile ${APP_ROOT}/Gemfile
COPY Gemfile.lock ${APP_ROOT}/Gemfile.lock
RUN bundle install
COPY . /${APP_ROOT}

COPY entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["bundle", "exec", "unicorn", "-p", "3000", "-c", "config/unicorn.conf.rb"]
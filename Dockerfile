FROM ruby:3.1.1

ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

RUN gem install rails bundler
WORKDIR $INSTALL_PATH
COPY $PWD .
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn
RUN rm -rf node_modules vendor /opt/app/tmp/pids/server.pid
RUN bundle install
RUN yarn install

CMD bash -c "rm -ff tmp/pids/server.pid && bundle exec rails s -b '0.0.0.0'"

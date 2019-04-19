FROM cwds/ruby:12

COPY . /cals

WORKDIR /cals

RUN cd /cals \
  && bundle install \
  && yarn install --frozen-lockfile

ENV RAILS_ENV=production \
  NODE_ENV=production \
  RAILS_RELATIVE_URL_ROOT=/cals

RUN bundle exec rails assets:precompile && bundle exec bin/hack-to-copy-fonts.sh

VOLUME /cals

CMD rails server -b 0.0.0.0 -p 3000

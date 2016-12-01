FROM rails:onbuild
MAINTAINER sc.cjhackerz@yahoo.com

RUN apt-get update && apt-get install -y \ 
  build-essential \ 
  postgresql-client \
  nodejs
WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

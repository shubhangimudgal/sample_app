FROM ruby:3.1.4
RUN apt update && apt install imagemagick libvips -y
#RUN apk update && apk add ruby=3.1.4
RUN gem install rails -v 7.0.4
RUN gem install bundler -v 2.3.14
COPY . /app
WORKDIR /app
RUN bundle install
EXPOSE 3000
CMD  bundle install && rails db:migrate && rails server

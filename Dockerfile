FROM ruby:2.7.3
WORKDIR /
RUN git clone https://github.com/daniel-lee-tech/danlee-org.git
WORKDIR /danlee-org
RUN bundle install
RUN jekyll build

ENTRYPOINT [ "bash", "-c" ]

FROM ruby:3.1.2
WORKDIR /
RUN git clone https://github.com/daniel-lee-tech/danlee-org.git
WORKDIR /danlee-org
RUN bundle install
WORKDIR /

ENTRYPOINT [ "bash", "-c" ]

FROM phusion/baseimage
MAINTAINER David Verhasselt <david@crowdway.com>

# Fix apt-get error messages
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

# Install git
RUN apt-get install -y git

# Install ruby build environment
RUN apt-get install -y build-essential autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev libssl-dev

# Get ruby-build
RUN mkdir /sources
RUN git clone https://github.com/sstephenson/ruby-build.git /sources/ruby-build
RUN /sources/ruby-build/install.sh

# Set up app directory
RUN mkdir /app
WORKDIR /app

# Install ruby
ENV CONFIGURE_OPTS --disable-install-doc
ADD .ruby-version ./
RUN ruby-build $(cat .ruby-version) /sources/ruby/
ENV PATH /sources/ruby/bin:$PATH

# Install gems
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN gem install bundler
ADD Gemfile* /app/
RUN bundle install

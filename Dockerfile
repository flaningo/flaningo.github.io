FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ruby-full \
    build-essential \
    locales \
    zlib1g-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN gem install jekyll bundler && gem cleanup

WORKDIR /site

COPY Gemfile Gemfile.lock ./

RUN bundle

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

ENTRYPOINT [ "bundle", "exec", "jekyll" ]

CMD ["serve", "--host", "0.0.0.0"]

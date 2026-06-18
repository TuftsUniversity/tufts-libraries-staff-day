FROM ruby:3.1-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install bundler into the image itself, not into /usr/local/bundle,
# so it's always available even when the bundle_cache volume is mounted.
RUN gem install bundler --no-document

WORKDIR /site

EXPOSE 4000 35729

CMD ["sh", "-c", "bundle install --jobs 4 --retry 3 && bundle exec jekyll serve --host 0.0.0.0 --livereload --force_polling"]

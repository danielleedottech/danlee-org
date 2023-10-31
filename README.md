# dan-lee-org

A simple personal website written in Jekyll / Ruby

## How to run for local development

```bash
bundle install
bundle exec jekyll serve --livereload
```

## Uploading Docker

```bash
docker login
docker build -t danlee-org .
docker tag danlee-org:latest danielleetech/danlee-org
docker push danielleetech/danlee-org:latest
```
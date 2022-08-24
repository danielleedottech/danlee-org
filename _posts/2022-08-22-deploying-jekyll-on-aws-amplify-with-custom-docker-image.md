---
layout: post
tags: ["aws", "jekyll", "ruby", "docker", "aws amplify", "devops"]
draft: true
---

## Introduction

[Jekyll](https://jekyllrb.com) is a static site generator built on ruby, and this wbesite is even built with it! It's pretty easy to work with and deployment for it is pretty easy too. AWS provides a service known as [AWS Amplify](https://aws.amazon.com/amplify/) that makes deployment really easy.. However AWS Amplify support for Jekyll is has become sadly outdated. This post will describe how to use Jekyll for AWS Amplify.

## Steps

1. Code / Obtain a jekyll repo
2. Upload that repo onto Github (or your remote version control system of your choice)
3. Create a custom Dockerfile and Docker image
4. Upload that Docker image to Docker Hub
5. Deploy to AWS Amplify with a custom build configuration

## 1. Jekyll Repo

Have a jekyll repo ready, this website is open sourced so you can use this very same website: [https://github.com/daniel-lee-tech/danlee-org](https://github.com/daniel-lee-tech/danlee-org)

## 2. Upload that repo to Github

Make sure you have your Github repo setup, Github themselves have a really great tutorial on it: [https://docs.github.com/en/get-started/quickstart/create-a-repo](https://docs.github.com/en/get-started/quickstart/create-a-repo)

## 3. Create a custom Dockerfile and Docker Image

### More Context

AWS Amplify has native support for many different types of web applications. It even has native support for Jekyll. However the way they achieve this is by using a container image that holds support for various different types of web applications. However that container image does not use updated Ruby. The bright side is that the Amplify allows you to provide custom build images, and the easiest way to do this is to use Docker Hub.

### Steps

### Custom Docker Image Creation Step 1

Make sure you have a [docker hub account](https://hub.docker.com/signup).

Make sure you have Docker Desktop installed on your operating system.

Also make sure you log in to Docker Hub on your operating system through Docker Desktop. 

### Custom Docker Image Creation Step 2

To create a custom Docker image, it is standard practice and useful to build off an existing official image. In this case, we should build off an official image aligned with the Ruby version you used to build your Jekyll site. The official ruby docker image information is below:

[https://hub.docker.com/_/ruby](https://hub.docker.com/_/ruby)

Note: Those of you experienced with Docker might think, why not just use the official Ruby image itself, this would be a really good idea, but AWS Amplify does not support tag version numbers, it will always pull `latest` of your specified custom docker image.

This is the docker image I used for this site:

```Dockerfile
FROM ruby:3.1.2 # replace version number with version number you are working with
WORKDIR /
# replace below URL with your github URL
RUN git clone https://github.com/daniel-lee-tech/danlee-org.git
# replace below folder name to the name of your repo
WORKDIR /danlee-org
RUN bundle install
WORKDIR /

ENTRYPOINT [ "bash", "-c" ]
```

Make sure you save the above file in a Dockerfile and replace the ruby version, git url and folder name that correlates with your project.












```yml
version: 1
frontend:
  phases:
    preBuild:
      commands:
        - bundle install
    # IMPORTANT - Please verify your build commands
    build:
      commands: []
  artifacts:
    # IMPORTANT - Please verify your build output directory
    baseDirectory: /
    files:
      - '**/*'
  cache:
    paths: []

```





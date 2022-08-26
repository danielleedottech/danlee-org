---
layout: post
tags: ["aws", "jekyll", "ruby", "docker", "aws amplify", "devops"]
draft: false
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

## 4. Upload the Docker Image to Docker Hub

Now that you have your Dockerfile, what you can now do is build and tag the image. The command to do that is as follows:

```bash
docker build <PATH TO DOCKERFILE> -t <IMAGE NAME>:latest
```

a concrete example that I used on my project:

```bash
docker build -f . -t danleeorg:latest
```

After that builds successfully, you can push that image to your docker hub repository. The command to do that is as follows:

```bash
docker image push <DOCKER HUB ACCOUNT NAME>/<IMAGE NAME>
```

A concrete example that I used:

```bash
docker image push danielleetech/danlee-org
```

You can check if the image pushed successfully by logging into your Docker Hub account.


## 5. Deploy to AWS Amplify with a custom build configuration

Now that we have our Docker Image and Github Repo all ready to go, we can now deploy. Let's login into the AWS Amplify console. [https://us-east-1.console.aws.amazon.com/amplify/home](https://us-east-1.console.aws.amazon.com/amplify/home).

The home page should look like this:

![AWS Amplify Home page](/assets/images/aws_amplify/aws_amplify_homepage.png)

Make sure you are in the right region.

Once you are, scroll down and click the `Get Started` button for web hosting. Picture of the button you need to click is below:

![AWS Amplify Web hosting button](/assets/images/aws_amplify/aws_amplify_web_button.png)

Connect your version control system, Github in this case.

![AWS Amplify Web Github button](/assets/images/aws_amplify/aws_amplify_github_button.png)

Once you've went through the process of connecting your github account, select the Jekyll repo and git branch that you want to deploy.

It's going to ask you to configure your build settings.

Click the edit button to modify the yml file.

![AWS Amplify Edit Yml Button](/assets/images/aws_amplify/aws_amplify_edit_build_button.png)

You should modify lines 5, 6, 9 and 12 of the original yml file. Full example is below.

Note: that we erased the `bundle install` command since we are already installing our needed dependencies in your custom docker image.
```yml
version: 1
frontend:
  phases:
    preBuild:
      commands: []
    # IMPORTANT - Please verify your build commands
    build:
      commands: ["bundle exec jekyll b"]
  artifacts:
    # IMPORTANT - Please verify your build output directory
    baseDirectory: /_site
    files:
      - '**/*'
  cache:
    paths: []
```

After that expand advanced settings to specify a custom build image.

![AWS Amplify Advanced Settings Dropdown](/assets/images/aws_amplify/aws_amplify_advanced_settings_button.png)

In the above picture, you will see that I specified a custom docker image.

The syntax for specifying your custom docker image is as follows:

```
<docker hub username>/<docker image name>
```

Click `Next` and then click `Save and Deploy`.

Wait a few minutes and now your Jekyll site should be deployed!

Congrats, thanks for reading.




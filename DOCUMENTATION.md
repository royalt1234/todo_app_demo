### About the TODO App
The todo app is a simple Flask App that returns one random joke each time. It taps into the pyjokes python libary for this. The code for this app can be found on the `app.py` file. As per of our CI process, on the general overview, the app get's built using a dockerfile, that dockerfile is pushed into the dockerhub repo. On the `master` branch, I developed a CI/CD process for this where I included a terraform process whereby this image is pulled from dockerhub and used in deploying a cloud run service on GCP, outping the cloud run service URL which can be used to access the Flask App on the internet. But for the context of this case study, I am only going to expalin the  Github CI process.

## Github Actions Overview
You can configure a GitHub Actions workflow to be triggered when an event occurs in your repository, such as a pull request being opened or an issue being created. You can alsoe configure to run at anytime as cronjobs using the cron expression. Your workflow contains one or more jobs which can run in sequential order or in parallel. Each job will run inside its own virtual machine runner, or inside a container, and has one or more steps that either run a script that you define or run an action, which is a reusable extension that can simplify your workflow. 

A workflow is a configurable automated process that will run one or more jobs. Workflows are defined by a YAML file checked in to your repository and will run when triggered by an event in your repository, or they can be triggered manually, or at a defined schedule.

Workflows are defined in the .github/workflows directory in a repository, and a repository can have multiple workflows, each of which can perform a different set of tasks. 

## How does this CI work?
I will Highlight some key points in the github workflow which shows how our CI procees works.

This is the trigger for the CI process, which sets it to run everytime there is a push on this particular branch.
```
on:
  push:
    branches: [ "feature/ci_cd_pipeline" ]
  pull_request:
```


Here is the Job that runs. As this is the CI process only, we just build app and push it to dockerhub. Where there is a CI/CD flow, a second job exist which deploys that image built from this docker job. 
```
jobs:
  docker:
    name: 'Docker'
    runs-on: ubuntu-latest
```

For the below steps, I left a line of comment above each to give an understanding of what they do. But in general, the following steps do the following in the exact order;

1. Checkouts our code into the Github Actions Runner.
2. Installs Docker on the Runner
3. Login to the dockerhub repository
4. Builds the dockerfile which builds our apps, that iamges is tagged after building.
5. The newly built imaged is then pushed to the DockerHub Repository.
```
    steps: 
    # Checkout the repository to the GitHub Actions runner
    - name: Checkout
      uses: actions/checkout@v3

    #Docker install docker on the runner
    - name: Docker install
      uses: docker-practice/actions-setup-docker@master

    #Login to dockerhub
    - name: Docker login
      run: docker login -u=${{ vars.DOCKER_USERNAME }} -p=${{ secrets.DOCKER_PASSWORD }}

    #Build the dockerfile
    - name: Docker build
      run: docker build . -t ${{ vars.DOCKER_USERNAME }}/maxdrive:todo

    #Push the dockerfile to dockerhub
    - name: Docker push
      run: docker push ${{ vars.DOCKER_USERNAME }}/maxdrive:todo
```
**NOTE;** The **DOCKER_USERNAME** was added as a Github Actions variable, while the **DOCKER_PASSWORD** was added as a Github Actions secrets. No sensitive information(consider login information as super sensitive) should be commited to version control systems.

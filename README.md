
## Welcome

This is a simple flask application created to understand the basics of a CICD pipeline.
To keep this simple I am only using a minimal webapp built on flask, Docker to containerize the webapp, Terraform to provision resources in AWS and Jenkins to build the Continous Integration and Continous Deployment.


### Component of the projects.

1. **flask-project** is the directory where the webapp code and Dockerfile to build the image of the code is placed. If you want to run the code on your local system you can either run it with or without docker but I'll be giving the way to run it with the docker.
Run the command inside the flask-project directory to create an image of your webapp from the Dockerfile (make sure you have the Docker installed and running to make the below command work).

    docker build -t flask-app \.

After the above command successfully completed you should see your image(flask-app) listed under the below output of:-

    docker images

If you can see your image listed you are good to go with the container creation using the below command.

    docker run -d -p 3000:5000 --name my-flask-app flask-app

 
 
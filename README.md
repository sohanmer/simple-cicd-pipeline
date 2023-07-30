
## Simple CI/CD pipeline 

This is a simple flask application created to understand the basics of a CICD pipeline.
To keep this simple I am only using a minimal webapp built on flask, Docker to containerize the webapp, Terraform to provision resources in AWS and Jenkins to build the Continous Integration and Continous Deployment.


### Component of the projects.

1. **flask-project** is the directory where the webapp code and Dockerfile to build the image of the code is placed. If you want to run the code on your local system you can either run it with or without docker but I'll be giving the way to run it with the docker.
Run the command inside the flask-project directory to create an image of your webapp from the Dockerfile (make sure you have the Docker installed and running to make the below command work).
    
        docker build -t flask-app .

    After the above command successfully completed you should see your image(flask-app) listed under the output of:-

        docker images

    If you can see your image listed you are good to go with the container creation using the below command.

        docker run -d -p 3000:5000 --name my-flask-app flask-app
    
    The above command will create a container named my-flask-app using and expose it to host 3000 on your localhost and you can open any browser and access the webapp at `localhost:3000`


2. **terraform-project** is the directory where all the configuration file written in Hashicorp Configuration Language (HCL) to provision the resources in the AWS is placed.

    Before provisioning the resources in the AWS you first have to create an aws account and create a access id and secret key for your user. After you have the key and the secret you can move ahead with the below steps.

    Make sure the terraform is installed in your system. [Download Terraform](https://developer.hashicorp.com/terraform/downloads)

    After installing terraform make sure you provide your access id and the secret key to terraform either my mentioning them under the provider block in providers.tf file or by exporting them to your current linux environment.

    To provide using your access id and secret key using provider.tf file replace the below code block with the provider block in the provider.tf file. However, this method is not recommended as this would expose your access key and secret key in a plain text file.

        provider "aws" {
            access_key = "my-access-key" // my-access-key will be your user's access key
            secret_key = "my-secret-key" // my-secret-key will be your user's secret key
            region = "us-west-2"
        }

    The recommended way is to use the session variable of your current shell by running the below command:-

        export AWS_ACCESS_KEY_ID="my-access-key" // my-access-key will be your user's access key
        export AWS_SECRET_ACCESS_KEY="my-secret-key" // my-secret-key will be your user's secret key
    
    Once the above processes are done you're good to go with your resource creation. Run the below command inside your terraform-project.

    To initialize the terraform use:-

        terraform init
    
    To show the terraform plan for the resource creation use:-
        
        terraform plan

    To create the terraform resources use:-

        terraform apply
    
    It'll take few seconds to 1 mins approx. to complete and after the resources are created successfully two public IP's will be printed(for Jenkins Master and the Slave server).


Once the resources are created, access the Jenkins master at jenkins_public_ip:8080 and configure the Jenkins with default settings. Add the slave node with the label slave01 using the manage jenkins option. Once slave node is added you're good to create a pipeline.

Create a pipeline in the Jenkins and use the Groovy code provided in the Jenkinsfile. Configure your pipeline to start the build using a github trigger. If everything ran as expected you can now access your webapp at slave_public_ip:3000.

Now everytime you push the code to your main branch in the github a webhook will trigger the jenkins pipeline and the code will be packaged and deployed in the slave server.
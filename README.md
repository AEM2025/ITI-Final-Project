# ITI-Final-Project
Creating infrastructure and deployment process using Terraform (IaC) to implement and configue secure Elastic Kubernetes Service (EKS) on Amazon Web Service (AWS) to host Jenkins on the cluster.

<p align="center">
  <img src="https://github.com/AEM2025/ITI-Final-Project/blob/master/1686790689984.jpg" alt="Intro Photo">
</p>


### Installation
1 - Install infrastructure with terraform
```
cd Terraform
terraform init                     #initializes a working directory and installs plugins for AWS provider
terraform plan                     #to check the changes
terraform apply -auto-approve      #creating the resources on AWS
```

2 - SSH into the Jump server to install `kubectl`:
```
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.27.1/2023-04-19/bin/linux/amd64/kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.27.1/2023-04-19/bin/linux/amd64/kubectl.sha256
```
Check the SHA-256 checksum for your downloaded binary with the following command: `sha256sum -c kubectl.sha256`
When using this command, make sure that you see the following output: `kubectl: OK`
- Then, Apply execute permissions to the binary: `chmod +x ./kubectl`
- Copy the binary to a folder in your PATH. If you have already installed a version of kubectl, then we recommend creating a $HOME/bin/kubectl and ensuring that $HOME/bin comes first in your $PATH: 
  ```
  mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
  ```

-  Add the $HOME/bin path to your shell initialization file so that it is configured when you open a shell: 
   ```
   echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
   ```
- After you install kubectl, you can verify its version: `kubectl version --short --client`

3 - SSH into the Jump server again to install `AWS cli`:
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install
```

4 - Configure using your private cluster:
  - `aws configure` and add your `AWS Access Key ID` and `AWS Secret Access Key`
  - Create a kubeconfig file for your cluster. Replace region-code with the AWS Region that your cluster is in and replace my-cluster with the name of your cluster.
  ```
  aws eks update-kubeconfig --region us-east-1 --name my-eks
  ```

5 - Build and Push Jenkins image:
```
docker build . -t ahmedemad2025/jenkins-kubectl-docker:v3
docker login docker.io     #Enter username and password
docker push ahmedemad2025/jenkins-kubectl-docker:v3
```

6 - SSH to private workernode and install docker: `sudo yum install docker --disablerepo=docker-ce-stable`

7 - Configuration:
```
sudo systemctl status docker
sudo systemctl start docker
rm -rf /var/run/docker.sock
sudo dockerd
```

8 - Add a webhook to the rpo, so the pipeline will start immediately whenever you push anything to the repo.

9 - [Demo](https://youtu.be/gRxjC6Bg_6g):



# KPMG Technical Assessment
## <p style="text-align: justify;"> This repository contains my solutions to the KPMG Technical Assessment. The assessment consists of three questions, and the goal is to showcase my approach, style, and reproducibility.</p>

### Question 1: 3-tier Environment Setup
<p style="text-align: justify;"> 
In this question, the task was to create a 3-tier environment using a cloud provider of my choice (Azure/AWS/GCP). I chose to create the environment on AWS. The resources used in this setup include:

Computing: 2 EC2 instances.<br>
Storage: EBS, S3.<br>
Database: RDS, DynamoDB.<br>
Monitoring: VPC Flow Logs.<br>
Alerts: CloudWatch for EC2.

<p style="text-align: justify;">
**NOTE :-** Future updates for this setup may include implementing a *CI/CD pipeline, integrating AWS Shield for enhanced security, and configuring AWS Config for resource tracking and compliance monitoring*.
</p>

### Question 2: Querying Instance Metadata
<p style="text-align: justify;">The second question required writing code to query the metadata of an instance within AWS, Azure, or GCP and provide the output in JSON format. I have provided a Python script that utilizes the requests module to retrieve the instance metadata and formats it as JSON. Please ensure you have the requests module installed to run the script successfully.
</p>

### Question 3: Retrieving Value from Nested Object
<p style="text-align: justify;">For the third question, I have implemented a function that takes a nested object and a key as input and returns the corresponding value. This function allows you to access nested values within an object by providing the desired key. I have also included test cases to verify the correctness of the implementation.

### Repository Structure
**Question 1:** Contains the Terraform scripts for setting up the 3-tier environment on AWS.<br>
**Question 2:** Contains the Python script for querying instance metadata.<br>
**Question 3:** Contains the Python script for retrieving values from a nested object.<br>
</p>

### How to Use
**For Question 1:**
<p style="text-align: justify;">As terraform statefile are configured on the s3 bucket so you first need to create the
terraform s3 resource and remeber to remove the backend "s3" from main.tf.
Once the s3 bucket is configured, just make main.tf as it is and start running other stuffs
by first running **terraform init -migrate-state** as this will migrate your state
to s3 and then you can run the plan and apply commands.
</p>

**For Question 2:**
<p style="text-align: justify;">You have to first create an EC2 instance on AWS and connect to it. Once connected
first you have to generate the token for authentication and authorization. Run below command to do the needful.<br>
<b>Command:</b> export TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
&& curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/dynamic/instance-identity/document 
Now once the token is generated you can get metadata by running <b>python filename.py</b>.
</p>

**For Question 2:**
<p style="text-align: justify;">No extra thing required. You can simply run it on the machine in which python is installed.
</p>
## Feel free to explore the code and provide any feedback or suggestions. Thank you for considering my solutions!

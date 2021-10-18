# Python AWS Lambda Terraform Example

Playing with how to set up a Python AWS Lambda using Terraform that can talk to S3

## Pre Requisites

Each of these need to be installed and available on your path:

* [Terraform CLI](https://www.terraform.io/downloads.html)
* [Python 3.8+](https://www.python.org/downloads/)
* [AWS CLI](https://aws.amazon.com/cli/)

The Python packages you'll need are:

* [boto3](https://pypi.org/project/boto3/)

On cloning the repository, you'll need to get the Terraform dependencies by running:

```
terraform init
```

You'll also need to set up you local AWS credentials to be able to deploy and test the Lambda.  Use this to start the wizard to set up your default local credentials:

```
aws configure
```

## Deployment

Can be deployed using this command (deploys to `eu-west-1` by default):

```
terraform apply
```

## Testing the Lambda

Run the following command to send test data to the Lambda to check it is functioning

```bash
aws lambda invoke --function-name bucket_writer --region eu-west-1 --payload '{\"key1\":\"value1\", \"key2\":\"value2\", \"key3\":\"value3\"}' --cli-binary-format raw-in-base64-out test_response.txt
```

This will call the function, then create a `test_response.txt` file containing any data returned from the Lambda.


## Tearing Down the Lambda

To delete all the deployed resources you can run:

```
terraform destroy
```

Note; if the S3 bucket isn't empty, you will need to delete the files contained within it first.

## Sources

* [Minimal AWS Lambda + Python + Terraform Example](https://www.davidbegin.com/the-most-minimal-aws-lambda-function-with-python-terraform/)
* [Creating a zip archive in Python](https://stackoverflow.com/questions/1855095/how-to-create-a-zip-archive-of-a-directory-in-python)
* [Terraform AWS Lambda Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function)
* [Terraform AWS S3 Bucket Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
* [Setting up Access Policies in Terraform](https://stackoverflow.com/questions/57145353/how-to-grant-lambda-permission-to-upload-file-to-s3-bucket-in-terraform/57146709)
* Writing a JSON file to an S3 bucket](https://stackoverflow.com/questions/46844263/writing-json-to-file-in-s3-bucket)

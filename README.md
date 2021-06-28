# Python AWS Lambda Terraform Example

Playing with how to set up a Python AWS Lambda using Terraform that can talk to S3

## Pre Requisites

Each of these need to be installed and available on your path:

* [Terraform CLI](https://www.terraform.io/downloads.html)
* [Python 3.9.5+](https://www.python.org/downloads/)
* [AWS CLI](https://aws.amazon.com/cli/)

## Deployment

Firstly we need to create the archive that will be used for deployment by running:

```
python build_and_package.py
```

This will create a file called `package.zip` at the route of the repository.

Then we need to deploy it using (deploys to `eu-west-1` by default):

```
terraform apply
```

## Testing the Lambda

- [ ] TO DO

## Tearing Down the Lambda

- [ ] TO DO

## Sources

* [Minimal AWS Lambda + Python + Terraform Example](https://www.davidbegin.com/the-most-minimal-aws-lambda-function-with-python-terraform/)
* [Creating a zip archive in Python](https://stackoverflow.com/questions/1855095/how-to-create-a-zip-archive-of-a-directory-in-python)
* [Terraform AWS Lambda Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function)
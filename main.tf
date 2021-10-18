terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region = "eu-west-1"
}

# Create a bucket for us to write Lambda events into
resource "aws_s3_bucket" "bucket" {
    bucket = "bucket-writer-sample"
    acl = "private"
}

# Create a zip file of the code to be used by the Lambda
data "archive_file" "zip_file" {
  type = "zip"
  source_dir = "src"
  output_path = "package.zip"
}

# Create a function to receive Lambda events and write them to the bucket
resource "aws_lambda_function" "lambda_function" {
  role             = "${aws_iam_role.lambda_exec_role.arn}"
  handler          = "lambda.handler"
  runtime          = "python3.8"
  filename         = data.archive_file.zip_file.output_path
  function_name    = "bucket_writer"
  # Necessary as Terraform uses the hash to see if a new version of the source code needs uplodating
  source_code_hash = "${base64sha256(filebase64(data.archive_file.zip_file.output_path))}"

  depends_on       = [ data.archive_file.zip_file ]
}

# The IAM Role the Lambda will use, this grants it permissions
resource "aws_iam_role" "lambda_exec_role" {
  name        = "lambda_exec"
  path        = "/"
  description = "Allows Lambda Function to call AWS services on your behalf."

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

# A policy allowing full access to S3 buckets in our account
resource "aws_iam_policy" "policy" {
  name = "bucket-writer-sample-access-policy"
  description = "A policy allowing full access to all S3 buckets"


      policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "s3:*"
        ],
        "Resource": "arn:aws:s3:::*"
    }
]
} 
EOF
}

# Attaching the policy to our Lambda's IAM role
resource "aws_iam_role_policy_attachment" "attach" {
  role       = "${aws_iam_role.lambda_exec_role.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}
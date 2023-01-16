# Usage

## Initialize Project's Backend

create `backend.conf` with this configuration

```conf
bucket     = "${S3_BUCKET}"
encrypt    = "${S3_BUCKET_ENCRYPTION_FOR_OBJECT}"
region     = "${S3_REGION}"
key        = "${TERRAFORN_STATE_KEY}"
access_key = "${AWS_ACCESS_KEY}"
secret_key = "${AWS_SECRET_KEY}"
```

execute this command
```
terraform init -backend-config backend.conf
```

## Deploy the project

create enviromental configuration for deployment, example `test.tfvars`

```tfvars
aws_access_id     = "${AWS_ACCESS_KEY}"
aws_secret_key_id = "${AWS_SECRET_KEY}"
db_identifier     = "testdemodb"
db_password       = "${DB_PASSWORD}"
db_username       = "test_username"
environment       = "Test"
subnet_ids        = "${AWS_VPC_SUBNETS}"
aws_region        = "${AWS_REGION}"
vpc_id            = "${AWS_VPC_ID}"
```

execute this command

```
terraform apply -var-file {enviromental_configuration}.tfvars 
```


## Destroy this project
```
terraform destroy -var-file {enviromental_configuration}.tfvars 
```
# Quick Reference Commands

## Switch Environment

Specify profile name
```sh
aws configure --profile fanchiikawa_dev_3333
```

Add default configuration
```sh
vi ~/.zshrc
```

Add to the file:
```sh
export AWS_PROFILE=fanchiikawa_dev_3333
```

Apply configuration
```sh
source ~/.zshrc
```

Check environment
```sh
aws s3 ls
```

Delete terraform state
```sh
rm -d -r -f .terraform
```

## Development Environment

Initialize
```sh
terraform init -backend-config=backend-configs/dev.hcl -reconfigure
```

View plan
```sh
terraform plan -var-file=environments/dev.tfvars
```

Apply deployment
```sh
terraform apply -var-file=environments/dev.tfvars -auto-approve
```

Migrate state
```sh
terraform init -backend-config=backend-configs/dev.hcl -migrate-state
```



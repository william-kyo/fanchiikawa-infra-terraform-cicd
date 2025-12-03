# Important Notes for Running fanchiikawa-infra-terraform-cicd Projects

**You must strictly follow these steps for creation and operation:**

* **Configure Environment**
```sh
# Specify profile name
aws configure --profile fanchiikawa_dev_3333
# Add default AWS credentials configuration
vi ~/.zshrc
# Add the following line to the file: export AWS_PROFILE=fanchiikawa_dev_3333
source ~/.zshrc

# Open a new terminal and verify AWS environment consistency
aws s3 ls
```

* **Creation**

  * 1. terraform init  # Before executing this step, ensure the remote-state-s3.tf file contains the following:

       ``` json
       terraform_backend_config_file_path = var.remote_state_terraform_backend_config_file_path
       force_destroy                      = false
       ```

  * 2. terraform apply -var-file=environments/dev.tfvars -auto-approve

    This step will generate a terraform.tf file, which defines how terraform state is stored in AWS S3

    >  Note: At this point, the terraform state file is still stored locally

  * 3. terraform init -var-file=environments/dev.tfvars -migrate-state

    Running this command will upload the terraform state file to the remote S3 bucket and use a DynamoDB table to store state locks, preventing accidental operations by multiple users.

    After executing *terraform init -migrate-state*, a backup file terraform.tfstate.backup will be created from the local terraform.tfstate file, indicating that the terraform state file has been uploaded from local storage to the S3 backend.

    **Note**: `-migrate-state` replaces the deprecated `-force-copy` option.

  * 4. After step 3 is complete, if you modify the terraform configuration, you can directly execute terraform apply

* **Synchronize state from S3 when switching branches or checking out code**
* If you switch branches or check out new code during use, you need to synchronize the state file from S3 to local, otherwise you will encounter errors about missing resources.

  * Execute the following command:

    ```
    terraform init -backend-config=backend-configs/dev.hcl -reconfigure
    ```

    This step reconfigures the backend and synchronizes the remote state file to local.

    **Note**: `-reconfigure` is used to switch backend configuration without migrating state. To migrate state, use `-migrate-state`

* **Destruction**

  This is also the most challenging step. The following steps must be strictly followed in order. Do not manually delete any files, as this can easily cause terraform state file inconsistencies and lead to destruction failures. ***Even if destruction fails, don't worry too much - you can manually delete resources in the AWS console, though it's tedious***

  * Modify the remote-state-s3.tf file to the following content:

    ``` json
    terraform_backend_config_file_path = ""
    force_destroy                      = true
    ```

  * Execute the following command:

    ```
    terraform apply -target module.terraform_state_backend -auto-approve
    ```

    This step deletes the terraform.tf file (**Remember, do not manually delete the terraform.tf file as it will cause state inconsistencies**)

  * terraform init -var-file=environments/dev.tfvars -reconfigure

     This step reconfigures the backend and switches back to local state file. After successful execution, you will find that the local terraform.tfstate file is no longer empty

     **Note**: `-reconfigure` is used to switch backend configuration without migrating state. To migrate state, use `-migrate-state`

  * terraform destroy -var-file=environments/dev.tfvars --auto-approve

    This will safely delete the environment. Regardless of whether apply was successful, all previously created resources will be successfully deleted

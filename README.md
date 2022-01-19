# Terraform
Steps:
Initialize the project, which downloads a plugin that allows Terraform to interact
```
terraform init
```
Format and validate the configuration
```
terraform fmt
```
```
terraform validate
```
A dry run to see what Terraform will do
```
terraform plan
```
Applies the Terraform code and builds stuff
```
terraform apply
```
Destroys what has been built by Terraform
```
terraform destroy
```
```
terraform destroy --target resourcename or module name
```
A dry run to see what Terraform will do with specified tfvars
```
terraform plan -var-file="stage.tfvars"
```
Refreshes the state file
```
terraform refresh 
```
views Terraform outputs
```
terraform output 
```
Creates a DOT-formatted graph
```
terraform graph 
```
To create workspace
```
terraform workspace new workspacename 
```
To view workspace
```
terraform workspace list 
```
To select work space
```
terraform workspace select workspacename  
```

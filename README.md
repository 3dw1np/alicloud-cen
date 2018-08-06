# Alibaba Cloud Entreprise Network (CEN)

At Alibaba Cloud, we use Terraform to provide fast demos to our customers.
I truly believe that the infrasture-as-code is the quick way to leverage a public cloud provider services. Instead of clicking on the Web Console UI, the logic of the infrasture-as-code allows us to define more accuratly each used services, automate the entire infrastructure and version it with a versionning control (git).

## High-level design


## Export environment variables
We provide the Alicloud credentials with envrionments variables. In this tutorial, we are going to use the Singapore Region (ap-southeast-1).
 
```
root@alicloud:~$ export ALICLOUD_ACCESS_KEY="anaccesskey"
root@alicloud:~$ export ALICLOUD_SECRET_KEY="asecretkey"
root@alicloud:~$ export ALICLOUD_REGION="eu-central-1"
```

If you don't have an access key for your Alicloud account yet, just follow this [tutorial](https://www.alibabacloud.com/help/doc-detail/28955.htm).

## Install Terraform
To install Terraform, download the appropriate package for your OS. The download contains an executable file that you can add in your global PATH.

Verify your PATH configuration by typing the terraform

```
root@alicloud:~$ terraform
Usage: terraform [--version] [--help] <command> [args]
```

## Setup Alicloud terraform provider (> v1.9.4)
The official repository for Alicloud terraform provider is [https://github.com/alibaba/terraform-provider]() 

* Download a compiled binary from https://github.com/alibaba/terraform-provider/releases.
* Create a custom plugin directory named **terraform.d/plugins/darwin_amd64**.
* Move the binary inside this custom plugin directory.
* Create **test.tf** file for the plan and provide inside:

```
# Configure the Alicloud Provider
provider "alicloud" {}
```

* Initialize the working directory but Terraform will not download the alicloud provider plugin from internet, because we provide a newest version locally.

```
terraform init
```

## Deployment steps

### Base vpc in region eu-central-1
```bash
export ALICLOUD_REGION="eu-central-1"
terraform init solutions/base_vpc
terraform plan|apply|destroy \
  -var-file=parameters/eu-central-1/base_vpc.tfvars \
  -state=states/eu-central-1/base_vpc.tfstate \
  solutions/base_vpc
```

### Base vpc in region eu-central-1
```bash
export ALICLOUD_REGION="eu-central-1"
terraform init solutions/base_vpc
terraform plan|apply|destroy \
  -var-file=parameters/eu-central-1/base_vpc.tfvars \
  -state=states/eu-central-1/base_vpc.tfstate \
  solutions/base_vpc
```

### Base vpc in region cn-shanghai
```bash
export ALICLOUD_REGION="cn-shanghai"
terraform init solutions/base_vpc
terraform plan|apply|destroy \
  -var-file=parameters/cn-shanghai/base_vpc.tfvars \
  -state=states/cn-shanghai/base_vpc.tfstate \
  solutions/base_vpc
```

### Base vpc in region ap-southeast-1
```bash
export ALICLOUD_REGION="ap-southeast-1"
terraform init solutions/base_vpc
terraform plan|apply|destroy \
  -var-file=parameters/ap-southeast-1/base_vpc.tfvars \
  -state=states/ap-southeast-1/base_vpc.tfstate \
  solutions/base_vpc
```
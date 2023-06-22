# iac-demo

Demo of Infrastructure as Code (IaC) on Azure with Terraform and Bicep.

## Prerequisites

Basic knowledge of Azure is required. In addition, you must have the following installed and/or configured:

* [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/)
* [Azure account](https://azure.microsoft.com/en-us/free/) and [subscription](https://learn.microsoft.com/en-us/dynamics-nav/how-to--sign-up-for-a-microsoft-azure-subscription)
* A [service principal](https://learn.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli) in Azure (see below).
## How to use

* Clone or fork this project.
* Open a terminal and type:
  * ``az login``
* Follow the instructions and login into your active Azure account.
* In the terminal type:
  * ``az account set --subscription <YOUR_SUBSCRIPTION_ID>``
* Create a service principal (if you don't already have one). In the terminal type:
  * ``az ad sp create-for-rbac -n "<YOUR_SPN>" --role="Contributor" --scopes="/subscriptions/<YOUR_SUBSCRIPTION_ID>"
``

### Terraform

Terraform needs a way to communicate with your Azure account/subscription.

For this, we utilize the service principal and account/subscription from the previous steps to set the following environment variables:
```
ARM_CLIENT_ID = "<SPN_APPID_VALUE>"
ARM_CLIENT_SECRET = "<SPN_CLIENT_SECRET_VALUE>"
ARM_SUBSCRIPTION_ID = "<YOUR_SUBSCRIPTION_ID>"
ARM_TENANT_ID = "<YOUR_TENANT_ID>"
```
You can find your __<SPN_APPID_VALUE>__ in the Azure portal, under _Azure Active Directory_ > _App registrations_.

The __<SPN_CLIENT_SECRET_VALUE>__ can be found under the same path in the Azure portal, by selecting the service principal and opening its _Certificates & secrets_ tab.

The terraform script will create a resource group in the Azure subscription you have specified. To run it:

* Open a terminal in the ``terraform`` folder of this prject.
* In the terminal type:
  * ``terraform apply``
* Validate the result by chacking your Azure subscription: You have a new reource group in your subscription.
* When done, in the terminal type:
  * ``terraform destroy``
* Validate the result again: The previously created resource group is deleted.

### Bicep

[TODO]

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

__Finally, log out of Azure (``az logout``) to avoid any mishaps using your own login credentials.__ We will use the service principal from now on.

Heads up! Make sure the service principal has privileges to create resources in your Azure subscription (e.g. ``--role="Contributor"``).

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

Read more on [Authenticate Terraform to Azure](https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash).

The __main.tf__ terraform script will create a resource group in the Azure subscription you have specified. To run it:

* Open a terminal in the ``terraform`` folder of this prject.
* In the terminal type:
  * ``terraform init``
* When done, in the terminal type:
  * ``terraform apply``
* Follow the instructions and choose to apply the proposed changes (if you wish!).
* Validate the result by checking your Azure subscription: You have a new reource group in your subscription.
* When done, in the terminal type:
  * ``terraform destroy``
* Validate the result again: The previously created resource group is deleted.

### Bicep

Authenticate using the service principal created earlier and set the correct tenant and subscription:
* ``az login --service-principal -u <SPN_APPID_VALUE> -p <SPN_CLIENT_SECRET_VALUE> --tenant <YOUR_TENANT_ID>``
* ``az account set --subscription <YOUR_SUBSCRIPTION_ID>``

Head up! You can (should) use the environment variables set in the previous step, e.g. (PowerShell):
* ``az login --service-principal -u ${env:ARM_CLIENT_ID} -p ${env:ARM_CLIENT_SECRET} --tenant ${env:ARM_TENANT_ID}``
* ``az account set --subscription ${env:ARM_SUBSCRIPTION_ID}``

Lastly, create the following environment variable containing the name of the resource group to create and subsequently create resources in:
```
RG_NAME = "<ANY_VALID_RG_NAME>"
```
The __main.bicep__ script will create a resource group in the Azure subscription you have specified. To run it:

* Open a terminal in the ``bicep`` folder of this prject.
* In the terminal type:
  * ``az deployment sub create -l <LOCATION> --template-file main.bicep --parameters rgName=${env:RG_NAME}``
* Validate the result by checking your Azure subscription: You have a new reource group in your subscription.
* Create a storage account in the newly created resource grouo. In the terminal type:
  * ``az deployment group create -g ${env:RG_NAME} --template-file storage.bicep``
* Validate the result by checking your Azure subscription: You have a new storage account in your previously created resource group.

To check potential changes, use the ``what-if`` flag, e.g.:
* ``az deployment sub what-if -l <LOCATION> --template-file main.bicep --parameters rgName=${env:RG_NAME}``
* ``az deployment group what-if -g ${env:RG_NAME}-xxx --template-file storage.bicep`` (you will need the actual RG name that was created)

Heads up! Remember to delete the created resources in the Azure portal or by running
* ``az group delete --name ${env:RG_NAME}-xxx``

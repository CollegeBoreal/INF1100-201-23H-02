# Terraform avec AKS

## :a: Créer le compte de service `principal`

Le compte de service sera utilisé pour accéder à la grappe, en fournissant l'utilisateur et le mot de passe pour créer la grappe. 

- [ ] [AKS Service Principal](https://docs.microsoft.com/en-us/azure/aks/kubernetes-service-principal?tabs=azure-cli)

* Remplacer `300000000` avec son :id:

```
AZURE_CLI_SP=azure-cli-300000000
```

```
az ad sp create-for-rbac --name ${AZURE_CLI_SP} > ${HOME}/.ssh/terraform.tfvars.json
```
> Return
```
WARNING: The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
```

```
cat ${HOME}/.ssh/terraform.tfvars.json
```
> Return
```
{
  "appId": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
  "displayName": "azure-cli-300000000",
  "password": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
  "tenant": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
}
```

## :b: Créer la grappe (Cluster) `Kubernetes`

- [ ] Installer les `plugins` Terraform

```
terraform init
```

- [ ] Tester l'infrastructure Terraform

```
terraform plan -var-file=${HOME}/.ssh/terraform.tfvars.json
```

- [ ] Créer l'infrastructure Terraform

```
terraform apply -var-file=${HOME}/.ssh/terraform.tfvars.json
```
> Return
```
...
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

kubernetes_cluster_name = "AKS-CB-AZ-300000000-aks"
resource_group_name = "AKS-CB-AZ-300000000-rg"
```

:bulb: La création de la grappe peux prendre jusqu'à 5 minutes, soit patient.

## :ab: Utiliser la grappe (Cluster) `Kubernetes`

- [ ] Mettre le contexte de la grappe dans le fichier `~/.kube/config` 

```
az aks get-credentials \
   --resource-group $(terraform output -raw resource_group_name) \
   --name $(terraform output -raw kubernetes_cluster_name)
```
> Return
```
Merged "AKS-CB-AZ-30000000-aks" as current context in /Users/myuser/.kube/config
```

- [ ] Vérifier le contexte

```
kubectl config get-contexts
```
> Return
```
CURRENT   NAME                      CLUSTER                   AUTHINFO                                                    NAMESPACE
*         AKS-CB-AZ-300000000-aks   AKS-CB-AZ-300000000-aks   clusterUser_AKS-CB-AZ-300000000-rg_AKS-C-AZ-300000000-aks
```

## :anchor: Utiliser la grappe (Cluster) `Kubernetes`

- [ ] Lister les référentiels présents pour installer les applications

```
helm repo list
```
> Return
```
NAME    URL
bitnami https://charts.bitnami.com/bitnami
```

- [ ] Ajouter un autre référentiel `Helm` par exemple `azure-marketplace`

```
helm repo add azure-marketplace https://marketplace.azurecr.io/helm/v1/repo
```

- [ ] [mediawiki](https://bitnami.com/stack/mediawiki)

```
helm install my-release azure-marketplace/mediawiki
```

## :x: Destroy

- [ ] Détruire la grappe

```
 terraform destroy -var-file=${HOME}/.ssh/terraform.tfvars.json
```

- [ ] Enlever le compte de service 

```
az ad sp delete \
  --id $(az ad sp list --display-name ${AZURE_CLI_SP} | jq '.[].appId' --raw-output)
```

# References

- [ ] [Provision an AKS Cluster (Azure)](https://learn.hashicorp.com/tutorials/terraform/aks)
- [ ] [Bitnami Application Catalog](https://bitnami.com/stacks)

### Learn Terraform - Provision AKS Cluster

This repo is a companion repo to the [Provision an AKS Cluster learn guide](https://learn.hashicorp.com/terraform/kubernetes/provision-aks-cluster), containing Terraform configuration files to provision an AKS cluster on Azure.

```
for id in $(az ad sp list --display-name ${AZURE_CLI_SP} | jq '.[].appId' --raw-output); do az ad sp delete --id ${id}; done
```

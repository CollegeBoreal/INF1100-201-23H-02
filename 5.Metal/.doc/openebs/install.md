# OpenEBS :package:



## :o2: Installation avec helm :package:

- [ ] Installer le référentiel

```
helm repo add openebs https://openebs.github.io/charts
```
> "openebs" has been added to your repositories

- [ ] Mettre à jour les référentiels

```
helm repo update
```
> Retourne :
```yaml
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "openebs" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈
```

- [ ] Installer `openebs` dans l'espace de noms `openebs` en activant `CSTOR`

```
helm install openebs --namespace openebs openebs/openebs --set cstor.enabled=true --create-namespace
```
> Retourne :
```yaml
NAME: openebs
LAST DEPLOYED: Mon Apr 10 21:46:59 2023
NAMESPACE: openebs
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Successfully installed OpenEBS.

Check the status by running: kubectl get pods -n openebs

The default values will install NDM and enable OpenEBS hostpath and device
storage engines along with their default StorageClasses. Use `kubectl get sc`
to see the list of installed OpenEBS StorageClasses.

**Note**: If you are upgrading from the older helm chart that was using cStor
and Jiva (non-csi) volumes, you will have to run the following command to include
the older provisioners:

helm upgrade openebs openebs/openebs \
	--namespace openebs \
	--set legacy.enabled=true \
	--reuse-values

For other engines, you will need to perform a few more additional steps to
enable the engine, configure the engines (e.g. creating pools) and create 
StorageClasses. 

For example, cStor can be enabled using commands like:

helm upgrade openebs openebs/openebs \
	--namespace openebs \
	--set cstor.enabled=true \
	--reuse-values

For more information, 
- view the online documentation at https://openebs.io/docs or
- connect with an active community on Kubernetes slack #openebs channel.
```

## :o: Vérifier l'installation

```
helm ls --namespace openebs
```
> Retourne :
<pre> 
NAME   	NAMESPACE	REVISION	UPDATED                             	STATUS  	CHART        	APP VERSION
openebs	openebs  	1       	2021-04-04 11:25:42.579325 -0400 EDT	deployed	openebs-2.7.0	2.7.0   
</pre>

[:back:](../#floppy_disk-le-stockage)

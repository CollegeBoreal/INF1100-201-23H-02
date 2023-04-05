# OpenEBS :package:



## :o2: Installation avec helm :package:

- [ ] Installer le référentiel

```
helm repo add openebs https://openebs.github.io/charts
```

- [ ] Mettre à jour les référentiels

```
helm repo update
```

- [ ] Installer `openebs` dans l'espace de noms `openebs` en activant `CSTOR`

```
helm install openebs --namespace openebs openebs/openebs --set cstor.enabled=true --create-namespace
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


  --version 13.0.1 \


```
helm install moodle bitnami/moodle \
  --set moodleUsername=admin,moodlePassword=Ch4ng3zM01V1t3 \
  --set mariadb.auth.rootPassword=M0tD3P4ss3D3R4c1n3- \
  --set mariadb.auth.password=T0urn3s0l123 \
  --set allowEmptyPassword=false \
  --set service.type=ClusterIP
```

# SSL using LetsEncrypt

```
terraform init
```

```
terraform apply -var-file=.metadata.tfvars.json
```

```
bash config-export-tls.sh 
```

## :bulb Consulting

```
END=".backup"
cat terraform.tfstate${END} | jq -r '.resources[].instances[0].attributes.registration_url' ;\
cat terraform.tfstate${END} | jq -r '.resources[].instances[0].attributes.certificate_pem' ; \
cat terraform.tfstate${END} | jq -r '.resources[].instances[0].attributes.issuer_pem' ; \
cat terraform.tfstate${END} | jq -r '.resources[].instances[0].attributes.private_key_pem'

```



# References

https://itnext.io/lets-encrypt-certs-with-terraform-f870def3ce6d

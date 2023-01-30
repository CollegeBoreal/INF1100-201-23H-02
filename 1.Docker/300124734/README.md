## LES ÉTAPES DE CONCEPTION DE L'IMAGE

**INTRODUCTION**


-Un Dockerfile définit une image Docker qui est constituée de couches empilées les unes sur les autres. 
Les couches sont en lecture seule, 
de sorte que le même état est toujours garanti lorsqu'un conteneur est lancé.

### 🚙: Dockerfile

```
- Ce Dorkerfile utilise l'image ubuntu 18.04

# ----- Debut -------------
FROM ubuntu:18.04
# ------ Fin ----------



# ------ Debut ------------
RUN apt-get update && \
 apt-get -y install apache2
# ---------- Fin -----------



# --------- Debut --------------------------------
RUN echo 'Calm Down Superzaf is Here ! ;)' > /var/www/html/index.html
# ---------- fin -----------------------------------



# -------------- Debut --------------------------------------
RUN echo '. /etc/apache2/envvars' > /root/run_apache.sh && \
 echo 'mkdir -p /var/run/apache2' >> /root/run_apache.sh && \
 echo 'mkdir -p /var/lock/apache2' >> /root/run_apache.sh && \ 
 echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/run_apache.sh && \ 
 chmod 755 /root/run_apache.sh
# ----------------- Fin --------------------------------

# OUVERTUR DU PORT INTERNET
EXPOSE 80

# DEMARRRAGE DU WEB SERVEUR
CMD /root/run_apache.sh
```
### 🚙: CONSTRUCTION DE L'IMAGE
```
docker image build --tag luxuryking:1.2 .
```
> luxuryking est le nom de l'image

### 🚙: L'EXECUTION DE l'IMAGE
```
docker container run --tty --name luxuryking --detach --publish 8080:80 luxuryking:1.2
```
### :cake: RESULTAT FINAL

<img width="1710" alt="Screenshot 2023-01-26 at 10 35 51 PM" src="https://user-images.githubusercontent.com/94937145/215010236-22bf2a62-207e-4df2-8dad-3eb72f8ccda9.png">



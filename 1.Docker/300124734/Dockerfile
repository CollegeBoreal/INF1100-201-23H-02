
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

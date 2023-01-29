### :whale: WORDPRESS AVEC DOCKER COMPOSE !

## 🥇 Créer le fichier DOCKER-COMPOSE.YML
```
touch docker-compose.yml
```
## 🥈 Ouvrez maintenant le fichier nouvellement créé et ajoutez le code suivant 
```
version: "3.9"
    
services:
```
▶️ La "version" en haut du fichier spécifie la version du format de fichier Compose. Des éléments tels que la structure du fichier, les clés de configuration autorisées et le comportement de composition dépendent de la version spécifiée dans le fichier "docker-compose".

En ce qui concerne les "services", nous utiliserons deux services :

- MySQL
- Wordpress

## ⏬ Ajoutez le code restant dans le fichier docker-compose.yml 
```
version: "3.9"
    
services:
  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: dbpassword
      MYSQL_DATABASE: wordpress_local
      MYSQL_USER: wordpress_db_user
      MYSQL_PASSWORD: wordpress_db_password
    
  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    volumes:
      - wordpress_data:/var/www/html
    ports:
      - "8000:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wordpress_db_user
      WORDPRESS_DB_PASSWORD: wordpress_db_password
      WORDPRESS_DB_NAME: wordpress_local
volumes:
  db_data: {}
  wordpress_data: {}
  
  ```
  ## 🥉 Enregistrez le fichier et vous êtes prêt à exécuter WordPress localement ! Pour cela, exécutez la commande suivante dans votre terminal :
  ```
  docker-compose up -d
  ```
  ▶️ Une fois la commande terminée, WordPress devrait être disponible sur localhost:8000.
  
  <img width="1710" alt="Screenshot 2023-01-29 at 2 31 30 AM" src="https://user-images.githubusercontent.com/94937145/215315301-d9c6390f-6d29-4dd6-b9b7-db6b22aa6918.png">
  
  # Vous pouvez continuer et installer WordPress. Une fois installé, vous pouvez l'utiliser pour des choses telles que le développement WordPress local.
  
  <img width="1710" alt="Screenshot 2023-01-29 at 2 42 53 AM" src="https://user-images.githubusercontent.com/94937145/215315490-4514ddf6-9127-4666-a111-1653ae30001f.png">

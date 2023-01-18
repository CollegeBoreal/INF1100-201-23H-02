#!/bin/sh

# --------------------------------------
#
#
#
# --------------------------------------

source ../.scripts/students.sh --source-only
   
echo "# Participation au `date +"%d-%m-%Y %H:%M"`"
echo ""


echo "| Table des matières            | Description                                             |"
echo "|-------------------------------|---------------------------------------------------------|"
echo "| :a: [Présence](#a-présence)   | L'étudiant.e a fait son travail    :heavy_check_mark:   |"
echo "| :b: [Précision](#b-précision) | L'étudiant.e a réussi son travail  :tada:               |"

echo ""
echo "## Légende"
echo ""

echo "| Signe              | Signification                 |"
echo "|--------------------|-------------------------------|"
echo "| :heavy_check_mark: | Prêt à être corrigé           |"
echo "| :x:                | Projet inexistant             |"


echo ""
echo "## :a: Présence"
echo ""
echo "|:hash:| Boréal :id:                | Interne            | Docker Engine |"
echo "|------|----------------------------|--------------------|----------------|"

i=0

for id in "${ETUDIANTS[@]}"
do
   docker context create ${id} \
                  --docker "host=ssh://${SERVERS[${i}]}" > /dev/null 2>&1
   docker context use ${id} > /dev/null 2>&1
   DOCKER_STATUS=`docker container ls --quiet --all 2> /dev/null`
   OK="| ${i} | ${id} - <image src='https://avatars.githubusercontent.com/u/${AVATARS[$i]}?s=460&v=4' width=20 height=20></image> | \`ssh ${SERVERS[$i]}\` | :heavy_check_mark: | "
   KO="| ${i} | ${id} - <image src='https://avatars.githubusercontent.com/u/${AVATARS[$i]}?s=460&v=4' width=20 height=20></image> | \`ssh ${SERVERS[$i]}\` | :x: | "
   if [ -z "$DOCKER_STATUS" ]; then
       echo ${KO}
   else
       echo ${OK}
   fi
   let "i++"
done

# Cleaning up

docker context use default > /dev/null 2>&1
for id in "${ETUDIANTS[@]}"
do
   docker context rm ${id} > /dev/null 2>&1
done

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
echo "|:hash:| Boréal :id:                | Interne            | ssh | Version | Proliant GL |"
echo "|------|----------------------------|--------------------|-----|---------|-------------|"

i=0

for id in "${ETUDIANTS[@]}"
do
   VERSION=`ssh -i ~/.ssh/b300098957@ramena.pk \
        -o StrictHostKeyChecking=no \
        -o PasswordAuthentication=no \
        -o ConnectTimeout=5 ${SERVERS[${i}]} lsb_release -a 2>/dev/null`
   CHASSIS=`ssh -i ~/.ssh/b300098957@ramena.pk \
        -o StrictHostKeyChecking=no \
        -o PasswordAuthentication=no \
        -o ConnectTimeout=5 ${SERVERS[${i}]} ip link | grep enp | wc -l 2>/dev/null`
    # echo "ssh -i ~/.ssh/b300098957@ramena.pk \
    #    -o StrictHostKeyChecking=no \
    #    -o PasswordAuthentication=no \
    #    -o ConnectTimeout=5 ${SERVERS[${i}]} lsb_release -a 2>/dev/null"
    # echo $VERSION
   OK_G7="| ${i} | ${id} - <image src='https://avatars.githubusercontent.com/u/${AVATARS[$i]}?s=460&v=4' width=20 height=20></image> | \`ssh ${SERVERS[$i]}\` | :heavy_check_mark: | ${VERSION} | G:seven: |"
   OK_G6="| ${i} | ${id} - <image src='https://avatars.githubusercontent.com/u/${AVATARS[$i]}?s=460&v=4' width=20 height=20></image> | \`ssh ${SERVERS[$i]}\` | :heavy_check_mark: | ${VERSION} | G:six: |"
   KO="| ${i} | ${id} - <image src='https://avatars.githubusercontent.com/u/${AVATARS[$i]}?s=460&v=4' width=20 height=20></image> | \`ssh ${SERVERS[$i]}\` | :x: | :x: | :x: |"
   if [[ $VERSION == *"Ubuntu"* ]]; then
      if [[ $CHASSIS == *"4"* ]]; then
          echo ${OK_G7}
      else
          echo ${OK_G6}
      fi
   else
       echo ${KO}
   fi
   let "i++"
done
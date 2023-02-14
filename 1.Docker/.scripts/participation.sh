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
echo "|:hash:| Boréal :id:                | DOckerfile    | Action |"
echo "|------|----------------------------|---------------|--------|"

i=0

for id in "${ETUDIANTS[@]}"
do
   FILE=${id}/Dockerfile
   ACTION_YML=${id}/action.yml
   ACTION_YAML=${id}/action.yaml
   OK_ACTION="| ${i} | [${id}](../${FILE}) - <image src='https://avatars0.githubusercontent.com/u/${AVATARS[$i]}?s=460&v=4' width=20 height=20></image> | :heavy_check_mark: | :heavy_check_mark: |"
   OK="| ${i} | [${id}](../${FILE}) - <image src='https://avatars0.githubusercontent.com/u/${AVATARS[$i]}?s=460&v=4' width=20 height=20></image> | :heavy_check_mark: | :x: |"
   KO="| ${i} | [${id}](../${FILE}) - <image src='https://avatars0.githubusercontent.com/u/${AVATARS[$i]}?s=460&v=4' width=20 height=20></image> | :x: | :x: |"
   if [ -f "$FILE" ]; then
      if [ -f "$ACTION_YML" || -f "$ACTION_YAML" ]; then
          echo ${OK_ACTION}
      else
          echo ${OK}
      fi
   else
       echo ${KO}
   fi
   let "i++"
done

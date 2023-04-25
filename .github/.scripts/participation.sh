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
echo "|Boréal :id:                | CI/CD |"
echo "|---------------------------|-------|"

url="https://github.com/CollegeBoreal/INF1100-201-23H-02/actions"
i=0

for id in "${ETUDIANTS[@]}"
do
    ACTION_YML=workflows/${id}.yml
    ACTION_YAML=workflows/${id}.yaml
    OK_YAML_ACTION="| [${id}](${URL}/workflows/${id}.yaml)  - <image src='https://avatars0.githubusercontent.com/u/${AVATARS[$i]}?s=460&v=4' width=20 height=20></image> | :heavy_check_mark: |"
    OK_YML_ACTION="| [${id}](${URL}/workflows/${id}.yml)  - <image src='https://avatars0.githubusercontent.com/u/${AVATARS[$i]}?s=460&v=4' width=20 height=20></image> | :heavy_check_mark: |"
    KO="| [${id}](${URL})  - <image src='https://avatars0.githubusercontent.com/u/${AVATARS[$i]}?s=460&v=4' width=20 height=20></image> | :x: |"
    if [[ -f "$ACTION_YML" || -f "$ACTION_YAML" ]]; then
        if [ -f "$ACTION_YAML"  ]; then
            echo ${OK_YAML_ACTION}
        else
            echo ${OK_YML_ACTION}
        fi
    else
        echo ${KO}
    fi
    let "i++"
done

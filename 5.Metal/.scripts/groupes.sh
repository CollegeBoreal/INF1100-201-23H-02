#!/bin/bash

# --------------------------------------
# Fonctions 
#
#
# --------------------------------------
CHIFFRES=(
":zero:"
":one:"
":two:"
":three:"
":four:"
":five:"
)

GROUPE="boreal"

# --------------------------------------
#
#
#
# --------------------------------------

source .scripts/grappes.sh --source-only
   
echo "# Participation du groupe au `date +"%d-%m-%Y %H:%M"`"
echo ""


echo "| Table des matières            | Description                                             |"
echo "|-------------------------------|---------------------------------------------------------|"
echo "| :a: [Présence](#a-présence)   | Le groupe a fait le travail        :white_check_mark:   |"
echo "| :b: [Précision](#b-précision) | Le groupe a réussi son travail     :tada:               |"

echo ""
echo "## Légende"
echo ""

echo "| Signe              | Signification                 |"
echo "|--------------------|-------------------------------|"
echo "| :white_check_mark: | Prêt à être corrigé           |"
echo "| :x:                | Étape inexistante             |"

echo ""
echo "## :a: Présence"
echo ""
echo "|:hash:| Grappe :wheel_of_dharma: | :gear: Config | :abacus: Plan de données | :three: BlockDevices :roll_of_paper: | :potable_water: Reservoir | :floppy_disk: Stockage | :rocket: Service |"
echo "|-|-|-|-|-|-|-|-|"

i=0
y=0
OK=":white_check_mark:"
KO=":x:"

for grappe in "${GRAPPES[@]}"
do

   FOLDER=${DIR[${i}]}.${grappe}

   VALUE="| ${CHIFFRES[${y}]} | [${FOLDER}](../${FOLDER}) |"

   # --- config ---
   CONFIG=${FOLDER}/.kube/config
   # echo $CONFIG
   if [ -f "$CONFIG" ]; then
      VALUE="${VALUE} [${OK}](../${FOLDER}/.kube/config) |"
   else
      VALUE="${VALUE} ${KO} |"
   fi

   # --- combien de noeuds en tout ---   
   NODE_COUNT=`kubectl get nodes --kubeconfig ${FOLDER}/.kube/config --no-headers 2> /dev/null | grep -v master | wc -l`
   # echo $NODE_COUNT
   VALUE="${VALUE} ${CHIFFRES[${NODE_COUNT}]} |"

   # --- combien de peripheriques en tout ---   
   DEVICE_COUNT=`ls ${FOLDER}/blockdevice-*.md 2> /dev/null | wc -l`
   VALUE="${VALUE} ${CHIFFRES[${DEVICE_COUNT}]} |"

   # --- reservoir de peripheriques ---
   POOL=${FOLDER}/cspc-single.yaml
   # echo $POOL
   if [ -f "$POOL" ]; then
      VALUE="${VALUE} [${OK}](../${FOLDER}/cspc-single.yaml) |"
   else
      VALUE="${VALUE} ${KO} |"
   fi

   # --- classe de peripheriques ---
   CLASS=${FOLDER}/csi-cstor-sc.yaml
   # echo $CLASS
   if [ -f "$CLASS" ]; then
      VALUE="${VALUE} [${OK}](../${FOLDER}/csi-cstor-sc.yaml) |"
   else
      VALUE="${VALUE} ${KO} |"
   fi

   # --- service ---
   PORTER=${FOLDER}/openelb.yaml
   # echo $PORTER
   if [ -f "$PORTER" ]; then
      VALUE="${VALUE} [${OK}](../${FOLDER}/openelb.yaml) |"
   else
      VALUE="${VALUE} ${KO} |"
   fi

   echo ${VALUE}
   let "i++"
   let "y++"


done

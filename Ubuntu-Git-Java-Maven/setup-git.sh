#!/bin/bash

# Netoyage du terminal
clear

# Accès au dossier
mkdir -p ~/Projets/
cd ~/Projets/

# Démarrer un agent SSH
eval "$(ssh-agent -s)" > /dev/null &&
# Ajouter clé privé à l'agent SSH
ssh-add ~/.ssh/id_key > /dev/null &&

# Test de la connection
echo "--- TEST CONNECTION GIT ---"
yes yes| ssh -T git@github.com

# Git clone
rm -rf ~/Projets/Global-Site/
echo ""
echo "--- GIT CLONE Global-Site ---"
yes yes | git clone git@github.com:SolaireFR/Global-Site.git > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo REUSSITE
    
    echo ""
    echo 'Utiliser les commandes :'
    echo '  cd ~/Projets/Global-Site/'
    echo '  mvn spring-boot:run'
else
    echo ECHEC
    echo Arret des operations.
fi

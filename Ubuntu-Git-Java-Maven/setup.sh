#!/bin/bash

# Mise à jour
echo "--- UPDATE ---"

apt update > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo REUSSITE

    # Installation paquet utils
    echo ""
    echo "--- INSTALLATION APT-UTILS ---"
    apt-get install apt-utils -y > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo REUSSITE
    else
        echo ECHEC
    fi

    # Ajout configuration timezone
    echo ""
    echo "--- CONFIG TIMEZONE ---"
    echo "Europe/Paris" > /etc/timezone 2>&1
    if [ $? -eq 0 ]; then
        echo REUSSITE
    else
        echo ECHEC
    fi

    # Installation Java
    echo ""
    echo "--- INSTALLATION DE JAVA 22 ---"
    apt-get install wget -y > /dev/null 2>&1 &&
    wget https://download.oracle.com/java/22/latest/jdk-22_linux-x64_bin.deb > /dev/null 2>&1 &&
    dpkg -i jdk-22_linux-x64_bin.deb > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo REUSSITE
    else
        echo ECHEC
    fi

    # Installation Git et Maven
    echo ""
    echo "--- INSTALLATION DE GIT ET MAVEN ---"
    echo ' ' >> ~/.bashrc
    echo 'echo git : $(git --version)' >> ~/.bashrc
    echo 'echo java : $(java --version)' >> ~/.bashrc
    echo 'echo mvn : $(mvn --version)' >> ~/.bashrc
    apt-get install git maven -y > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo REUSSITE
    else
        echo ECHEC
    fi

    # Génération clés SSH
    echo ""
    echo "--- GENERATION CLES SSH ---"
    key_file=~/.ssh/id_key
    if [ ! -f "$key_file" ]; then
        ssh-keygen -f "$key_file" -P "" -t rsa > /dev/null
        echo REUSSITE
    else
        echo LE FICHIER EXISTE DEJA
    fi

    # GIT GlobalSite
    echo ""
    echo "Copier la clé SSH suivante pour l'ajouter à Github/Gitlab :"
    cat "$key_file.pub"
    echo ""
    echo "Puis faite : /setup-git.sh"
else
    echo 'ECHEC (probleme de connection ?)'
    echo Arret des operations.
fi
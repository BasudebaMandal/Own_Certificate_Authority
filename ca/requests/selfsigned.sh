#!/bin/bash
nemoid=$1
#echo "#######################################################################"
echo "############  Country = IN  "
echo "############  State = Maharastra "
echo "############  Location = Pune "
echo "############  Organization = OrgName "
echo "############  Organization Unit = OrgUnitName "
echo "############  CN Name: Give UR CN Name "
echo "############  email = Give UR email name "
#echo "############  ##########################################################"

cd /root/ca/requests
openssl req -out $nemoid.csr -new -newkey rsa:2048 -nodes -keyout $nemoid.pem
sleep 5
openssl rsa -in /root/ca/requests/$nemoid.pem -out /root/ca/keys/$nemoid.pem
openssl ca -in $nemoid.csr -out $nemoid.crt

cd /wls_domains/wlsapp01/bin
. ./setDomainEnv.sh
java utils.ImportPrivateKey -keystore /root/ca/shmVODshm/jks/$nemoid.jks -storetype JKS -storepass keypass -keypass keypass -alias shm -certfile /root/ca/requests/$nemoid.crt -keyfile /root/ca/keys/$nemoid.pem -keyfilepass keypass
keytool -importkeystore -srckeystore /root/ca/shmVODshm/jks/$nemoid.jks -srcstoretype JKS -deststoretype PKCS12 -destkeystore /root/ca/shmVODshm/p12/$nemoid.p12

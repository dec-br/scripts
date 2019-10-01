#! /bin/bash
################SCRIPT PARA EMISSAO DE CERTIFICADOS ACME ATRAVES DO CERTBOT##########
#AUTHOR: Douglas Oliveira(myemail)
#Versao: 1.5.1
##########################################################################
##########################################################################
tput clear;
echo "INSIRA O DOMINIO PRINCIPAL(SEM O WWW) ACRESCIDO DO DOMINIO RAIZ(*.COM.BR)"
	read dominio_principal
echo "INSIRA O SUBDOMINIO PARTICIPANTE(OPCIONAL)"
	read subdominio
echo "INDISPONIBILIZANDO O WEBSITE DURANTE A EMISSAO DO CERTIFICADO"
sleep 2
	mv /etc/nginx/sites-enabled/$dominio_principal /etc/nginx/sites-enabled/$dominio_principal.cert_pendente
	service nginx restart
if [ -z $subdominio ];then

	echo "EMITINDO CERTIFICADO SOMENTE PARA O DOMINIO $dominio_principal"
	/opt/letsencrypt/./letsencrypt-auto certonly --webroot -w /var/www/html/ -d $dominio_principal
	echo "DEVOLVENDO O SERVICO..."
	mv /etc/nginx/sites-enabled/$dominio_principal.cert_pendente /etc/nginx/sites-enabled/$dominio_principal
	service nginx restart
########################################################################
RESERVADO PARA USO FUTURO
########################################################################
	#echo "ADICIONANDO O HTTPS(LISTEN) NO VHOST..."
	#cp /etc/nginx/sites-enabled/$dominio_principal /tmp/$dominio_principal
	#cp /usr/share/
	#sed -i 's,example.se.gov.br,$dominio_principal,g' /tmp
	#echo "listen 443;" >> /etc/nginx/sites-enabled/$dominio_principal
	#echo "ssl on;" >> /etc/nginx/sites-enabled/$dominio_principal
	#echo "ssl_certificate_key /etc/letsencrypt/live/$dominio_principal/privkey.pem;" >> /etc/nginx/sites-enabled/$dominio_principal
	#echo "ssl_certificate /etc/letsencrypt/live/$dominio_principal/fullchain.pem;" >> /etc/nginx/sites-enabled/$dominio_principal
########################################################################
else
	echo "EMITINDO CERTIFICADO PARA OS DOMINIOS $dominio_principal E $subdominio"
	/opt/letsencrypt/./letsencrypt-auto certonly --webroot -w /var/www/html/ -d $dominio_principal -d $subdominio
	echo "DEVOLVENDO O SERVICO..."
        mv /etc/nginx/sites-enabled/$dominio_principal.cert_pendente /etc/nginx/sites-enabled/$dominio_principal
	service nginx restart
#########################################################################
RESERVADO PARA USO FUTURO
#########################################################################
	#echo "listen 443;" >> /etc/nginx/sites-enabled/$dominio_principal
	#echo "ssl on;" >> /etc/nginx/sites-enabled/$dominio_principal
	#echo "ssl_certificate_key /etc/letsencrypt/live/$dominio_principal/privkey.pem;" >> /etc/nginx/sites-enabled/$dominio_principal
	#echo "ssl_certificate /etc/letsencrypt/live/$dominio_principal/fullchain.pem;" >> /etc/nginx/sites-enabled/$dominio_principal
########################################################################

fi
########################################################################

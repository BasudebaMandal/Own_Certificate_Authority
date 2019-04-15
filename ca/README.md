# Own_Certificate_Authority

To request a certificate from a CA like Verisign, you send them a Certificate Signing Request (CSR), and they give you a certificate in return 

that they signed using their root certificate and private key. All browsers have a copy (or access a copy from the operating system) of Verisign’s 

root certificate, so the browser can verify that your certificate was signed by a trusted CA.

That’s why when you generate a self-signed certificate the browser doesn’t trust it. It’s self-signed. It hasn’t been signed by a CA.

Below are the stpes to do the same.

St1) mkdir /root/ca

St2) cd /root/ca

St3) mkdir newcerts certs crl private requests

St4) touch index.txt

St5) echo '1234' > serial

St6) openssl genrsa -aes256 -out private/cakey.pem 4096

You will be prompted for a pass phrase, which I recommend not skipping and keeping safe. The pass phrase will prevent anyone who gets your private 

key from generating a root certificate of their own. Output should look like this:

Then we generate a root certificate:

St7) openssl req -new -x509 -key /root/ca/private/cakey.pem -out cacert.pem

You will prompted for the pass phrase of your private key (that you just choose) and a bunch of questions. The answers to those questions aren’t 

that important. They show up when looking at the certificate, which you will almost never do. I suggest making the Common Name something that 

you’ll recognize as your root certificate in a list of other certificates. That’s really the only thing that matters.

St8) chmod -R 600 /root/ca

St9) vi /usr/lib/ssl/openssl.cnf

Change below fields

f1) dir = /root/ca
f2) default_days   = 365
f3) Policy match section
    Countryname,stateprovince name,organization name = keep all in optional 

St10) cd requests

St11) openssl genrsa -aes256 -out webserver.pem 2048

St12) openssl req -new -key webserver.pem -out webserver.csr

Enter the details of your CSR

St13) openssl ca -in webserver.csr -out.webserver.crt

St14) yes

St15) yes

St16) cat webserver.crt

get the root certificate installed on browser to trust.

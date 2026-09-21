#!/bin/bash
# Este archivo lo procesa Terraform con templatefile(): ${ip_datos} lo
# sustituye la IP interna real de la máquina de datos antes de que la
# instancia arranque. Esa referencia es la que crea la dependencia entre
# las dos máquinas.

# Reintenta durante un rato: la máquina de datos puede tardar en terminar
# de instalar su propio nginx aunque Terraform ya la haya creado primero.
DATO=""
for i in $(seq 1 30); do
  DATO=$(curl -s -m 3 http://${ip_datos}/dato.txt || true)
  if [ -n "$DATO" ]; then
    break
  fi
  sleep 5
done

if [ -z "$DATO" ]; then
  # Sin respuesta de la máquina de datos no se instala nada: la página
  # de la aplicación no debe poder servirse si la dependencia no llegó.
  exit 0
fi

apt-get update -y
apt-get install -y nginx
INTERNA=$(curl -s -H "Metadata-Flavor: Google" \
  http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip)
cat > /var/www/html/index.html <<HTML
<h1>1152315-1152490</h1>
<p>Servidor de aplicación. IP interna: $INTERNA</p>
<p>Dato recibido de la máquina de datos (10.11.x.x, sin IP pública): $DATO</p>
HTML
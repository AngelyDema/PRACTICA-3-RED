# PRACTICA3-RED
## 1. Identificación del equipo: Angely Sofia Pino 1152315, Jhan Ávila Torres 1152490
### 1.1. ID del proyecto: nube-practica-1-507220
## 2. Diagrama
## 3. Evidencias

### Evidencia 0: 
**Comando escrito: terraform version /**
**Salida:**

```
Terraform v1.5.7
on linux_amd64

Your version of Terraform is out of date! The latest version
is 1.16.3. You can update by downloading from https://www.terraform.io/downloads.html
```
*La versión dice que está desactualizada pero la dejamos así porque para la practica la versión de Terraform no es relevante (o por lo menos no hay una parte que exija cierta versión)*

**Comando escrito: gcloud config list /**
**Salida:**
```
angelysofiapg@cloudshell:~/PRACTICA-3-RED (nube-practica-1-507220)$  gcloud config list
[accessibility]
screen_reader = True
[component_manager]
disable_update_check = True
[compute]
gce_metadata_read_timeout_sec = 30
[core]
account = angelysofiapg@ufps.edu.co
disable_usage_reporting = False
project = nube-practica-1-507220
universe_domain = googleapis.com
[metrics]
environment = devshell
```
### Evidencia 1: 

**Comando escrito: terraform apply /**
**Salida:**
```
angelysofiapg@cloudshell:~/PRACTICA-3-RED (nube-practica-1-507220)$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_compute_network.vpc will be created
  + resource "google_compute_network" "vpc" {
      + auto_create_subnetworks                   = false
      + bgp_always_compare_med                    = (known after apply)
      + bgp_best_path_selection_mode              = (known after apply)
      + bgp_inter_region_cost                     = (known after apply)
      + delete_bgp_always_compare_med             = false
      + delete_default_routes_on_create           = false
      + deletion_policy                           = "DELETE"
      + gateway_ipv4                              = (known after apply)
      + id                                        = (known after apply)
      + internal_ipv6_range                       = (known after apply)
      + mtu                                       = (known after apply)
      + name                                      = "pinoavila-vpc"
      + network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
      + network_id                                = (known after apply)
      + numeric_id                                = (known after apply)
      + project                                   = "nube-practica-1-507220"
      + routing_mode                              = (known after apply)
      + self_link                                 = (known after apply)
    }

  # google_compute_subnetwork.publica will be created
  + resource "google_compute_subnetwork" "publica" {
      + allow_subnet_cidr_routes_overlap = (known after apply)
      + creation_timestamp               = (known after apply)
      + deletion_policy                  = "DELETE"
      + external_ipv6_prefix             = (known after apply)
      + fingerprint                      = (known after apply)
      + gateway_address                  = (known after apply)
      + id                               = (known after apply)
      + internal_ipv6_prefix             = (known after apply)
      + ip_cidr_range                    = "10.10.1.0/24"
      + ipv6_cidr_range                  = (known after apply)
      + ipv6_gce_endpoint                = (known after apply)
      + name                             = "pinoavila-sub-publica"
      + network                          = (known after apply)
      + private_ip_google_access         = (known after apply)
      + private_ipv6_google_access       = (known after apply)
      + project                          = "nube-practica-1-507220"
      + purpose                          = (known after apply)
      + region                           = "us-central1"
      + self_link                        = (known after apply)
      + stack_type                       = (known after apply)
      + state                            = (known after apply)
      + subnetwork_id                    = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
```
En este último bloque, nos indica que se creó la red vpc "pinoavila-vpc" y la sub red "pinoavila-sub-publica" 

*la imagen de evidencia se encuentra en la carpeta "evidencias" como "evidencia 1"*
```
google_compute_network.vpc: Creating...
google_compute_network.vpc: Still creating... [10s elapsed]
google_compute_network.vpc: Creation complete after 12s [id=projects/nube-practica-1-507220/global/networks/pinoavila-vpc]
google_compute_subnetwork.publica: Creating...
google_compute_subnetwork.publica: Still creating... [10s elapsed]
google_compute_subnetwork.publica: Creation complete after 11s [id=projects/nube-practica-1-507220/regions/us-central1/subnetworks/pinoavila-sub-publica]
```
## Evidencia 2: 
**Comando escrito: terraform plan**

```
angelysofiapg@cloudshell:~/PRACTICA-3-RED (nube-practica-1-507220)$  terraform plan
google_compute_network.vpc: Refreshing state... [id=projects/nube-practica-1-507220/global/networks/pinoavila-vpc]
google_compute_subnetwork.publica: Refreshing state... [id=projects/nube-practica-1-507220/regions/us-central1/subnetworks/pinoavila-sub-publica]

No changes. Your infrastructure matches the configuration.


Terraform has compared your real infrastructure against your configuration and
found no differences, so no changes are needed.
angelysofiapg@cloudshell:~/PRACTICA-3-RED (nube-practica-1-507220)$ 
```
**Comando escrito: terraform output**
```
red = "pinoavila-vpc"ell:~/PRACTICA-3-RED (nube-practica-1-507220)$ terraform output
subred_publica = "https://www.googleapis.com/compute/v1/projects/nube-practica-1-507220/regions/us-central1/subnetworks/pinoavila-sub-publica"
angelysofiapg@cloudshell:~/PRACTICA-3-RED (nube-practica-1-507220)$ 
```


## 4. Decisiones libres justificadas

### 4.1 Sobre la máquina: 
Aunque el uso en esta práctica es pequeño, y más o menos teníamos entendido el tipo de máquina que teníamos que escoger quisimos hacer la trazabilidad de comparar las diferentes  máquinas y poder decir cuál era adecuada para nuestro trabajo. Google cloud tiene docs que informas tanto para la zona como para máquinas: https://docs.cloud.google.com/compute/docs/machine-resource?hl=es-419
. En ese sitio leimos las diferentes máquinas que tienen, y terminamos escogiendo de la serie E2 la e2-micro. 

*Citando del sitio: "Las series E2 y N1 contienen tipos de máquina con núcleo compartido. Estos tipos de máquinas comparten un núcleo físico, que puede ser un método rentable para ejecutar apps pequeñas que no necesitan muchos recursos"*

Otra razón para escoger e2-micro es que estamos trabajando con créditos gratuitos, haciendo mini poryectos que no van a tener mucho tráfico y probablemente para este proceso de la practica no se usará tanta ram. Aunque es cierto que f1-micro tiene menos ram google cloud ya tiene en su capa gratuita a e2-micro. No hay razón de dinero de por medio para elegir f1-micro sobre e2-micro. 

### 4.2. Sobre la zona

Por el lado de la zona, nosotros decidimos trabajar primero basado en la región en la que estamos, ya que una región diferente a la zona podría generar fallos en al apply, ya que la teoría dice que una zona es una "área aislada" dentro de una región. Entonces, basado en eso pusimos el comando: 

```
gcloud compute zones list --filter="region:us-central1"
```
Este basicamente nos dice las zonas filtradas por la región que trabajamos, en este caso, "us-central1". En donde nos dió las siguientes zonas: 

```
NAME: us-central1-c
REGION: us-central1
STATUS: UP
NEXT_MAINTENANCE: 
TURNDOWN_DATE: 

NAME: us-central1-a
REGION: us-central1
STATUS: UP
NEXT_MAINTENANCE: 
TURNDOWN_DATE: 

NAME: us-central1-f
REGION: us-central1
STATUS: UP
NEXT_MAINTENANCE: 
TURNDOWN_DATE: 

NAME: us-central1-b
REGION: us-central1
STATUS: UP
NEXT_MAINTENANCE: 
TURNDOWN_DATE: 
```
Como ya sabíamos el tipo de máquina filtramos en esas zonas si alguna tenía la máquina que requeríamos:

```
angelysofiapg@cloudshell:~/PRACTICA-3-RED (nube-practica-1-507220)$ gcloud compute machine-types list --zones=us-central1-a --filter="name=e2-micro"
NAME: e2-micro
ZONE: us-central1-a
CPUS: 2
MEMORY_GB: 1.00
DEPRECATED: 
```
Aquí mostrams con us-central1-a pero tanto b,c y f daban el mismo resultado. Utilizamos entonces la zona **us-central1-a**. No encontramos información comparativa sobre la disponibilidad de estas zonas, o otros criterios para elegir una sobre otra. 

### 4.3 Sobre la cdri privada
Esta era la parte más difícil (porque no recordabamos), para esto nos tocó repasar teoría. En donde después propusimos la red privada: 10.11.1.0/24

**¿Por qué ese valor?**

El /24 fija los primeros 24 bits, es decir, los tres primeros octetos: 10.10.1. El último octeto es la parte libre y puede valer de 0 a 255. Por eso el rango completo va de 10.10.1.0 a 10.10.1.255. Cualquier red sugerida dentro de ese rango va a solapar.

*y para confirmar, utilizamos un pequeño truco:*
```
python3 -c "import ipaddress; print(ipaddress.ip_network('10.10.1.0/24').overlaps(ipaddress.ip_network('10.11.1.0/24')))"
False
```
Esto si nos da true nos permite determinar si una ip sobrepone otra.

## 5. Preguntas respondidas 



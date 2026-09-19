# PRACTICA3-RED
## 1. Identificación del equipo: Angely Sofia Pino 1152315, Jhan Ávila Torres 1152490
### 1.1. ID del proyecto: nube-practica-1-507220
## 2. Diagrama
## 3. Evidencias

### Evidencia 0: 
**Comando escrito: terraform version**
**Salida:**

```
Terraform v1.5.7
on linux_amd64

Your version of Terraform is out of date! The latest version
is 1.16.3. You can update by downloading from https://www.terraform.io/downloads.html
```
*La versión dice que está desactualizada pero la dejamos así porque para la practica la versión de Terraform no es relevante (o por lo menos no hay una parte que exija cierta versión)*

**Comando escrito: gcloud config list**
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

**Comando escrito: terraform apply**
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

*la imagen de evidencias se encuentra en la carpeta evidencia*
```
google_compute_network.vpc: Creating...
google_compute_network.vpc: Still creating... [10s elapsed]
google_compute_network.vpc: Creation complete after 12s [id=projects/nube-practica-1-507220/global/networks/pinoavila-vpc]
google_compute_subnetwork.publica: Creating...
google_compute_subnetwork.publica: Still creating... [10s elapsed]
google_compute_subnetwork.publica: Creation complete after 11s [id=projects/nube-practica-1-507220/regions/us-central1/subnetworks/pinoavila-sub-publica]
```


## 4. Decisiones libres justificadas
## 5. Preguntas respondidas 



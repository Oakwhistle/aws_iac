# EKS Cluster Terraform Module

## Descripción del Proyecto

Este módulo de Terraform construye y configura un clúster de Amazon EKS completamente privado, preparado para lanzar un POD de prueba y con soporte para varios addons, como el ALB Ingress Controller de AWS. Todas las configuraciones y parametrizaciones están centralizadas en el archivo `eks-develop.tfvars`, facilitando la personalización y gestión del entorno.

## Funcionalidades

-   **Clúster EKS 100% privado**: El clúster no tiene endpoints públicos, garantizando la máxima seguridad en la comunicación.
-   **Preparado para lanzar un POD de prueba**: El clúster se configura con los recursos mínimos necesarios para la validación de un POD de prueba.
-   **Controlador ALB Ingress**: Implementación del controlador de Ingress ALB de AWS para la gestión eficiente del tráfico de red.
-   **Acceso mediante AWS SSM**: Las instancias de los nodos están configuradas con perfiles de instancia que permiten el acceso a través de AWS SSM, eliminando la necesidad de claves SSH directas.
-   **Gestión de addons parametrizados**: Cada addon tiene su propio archivo `values.yaml`, y todas las configuraciones de estos addons son centralizadas y gestionadas desde `eks-develop.tfvars`.

## Uso

### Requisitos previos

-   Terraform
-   Cuenta de AWS con permisos suficientes para crear recursos EKS, ALB, y SSM.
-   Configuración de credenciales de AWS en tu máquina local.
- 
### Instalación

1.  Clona este repositorio:
```bash
git clone https://github.com/tu-repositorio/eks-cluster-module.git
cd eks-cluster-module
```
2. Configura las variables en el archivo `eks-develop.tfvars`: Todas las configuraciones clave, incluidos los parámetros del clúster EKS y los addons, deben ser especificadas en este archivo. Ejemplo:
```bash
cluster_name      = "my-private-cluster"
node_instance_type = "t3.medium"
desired_capacity  = 3

addons = {
  coredns = {
    enabled = true
    values_yaml = file("addons/coredns/values.yaml")
  }
  alb_ingress = {
    enabled = true
    values_yaml = file("addons/alb-ingress-controller/values.yaml")
  }
}
```
3. Inicializa y aplica el módulo de Terraform:
```bash
terraform init
terraform plan -var-file="eks-develop.tfvars"
terraform apply -var-file="eks-develop.tfvars"
```
4. Una vez finalizado el despliegue, puedes verificar que el POD de prueba está funcionando y que el controlador de Ingress está configurado correctamente.

### Añadir Nuevos Parámetros

Este módulo está diseñado para que todas las configuraciones se centralicen en el archivo `eks-develop.tfvars`, lo que garantiza que cualquier nuevo parámetro que se agregue al clúster o a los addons sea gestionado de forma coherente y clara. Sigue estos pasos para añadir nuevos parámetros:

#### 1. Modificación de `variables.tf`

Si necesitas agregar un nuevo parámetro, primero defínelo en `variables.tf` para que pueda ser utilizado por Terraform. Por ejemplo, si quieres añadir una opción para habilitar o deshabilitar un nuevo addon, puedes hacerlo de la siguiente manera:
```bash
variable "new_addon_enabled" {
  description = "Determina si el nuevo addon está habilitado"
  type        = bool
  default     = false
}
```
#### 2. Configuración en `eks-develop.tfvars`

Asegúrate de incluir la nueva configuración en el archivo `eks-develop.tfvars`, ya que este archivo actúa como la fuente principal de verdad para las configuraciones:
```bash
new_addon_enabled = true
```
#### 3. Integración en `main.tf` y `values.yaml`

Los addons son configurados utilizando archivos `values.yaml`, cuyos valores se parametrizan desde `eks-develop.tfvars`. Para un nuevo addon, sigue estos pasos:

-   Crea un directorio en `addons/` para el nuevo addon, donde se incluirá su archivo `values.yaml`.
-   Configura el nuevo addon en `main.tf`, utilizando la variable que acabas de añadir.
```bash
resource "helm_release" "new_addon" {
  name       = "new-addon"
  repository = "https://charts.example.com"
  chart      = "new-addon"
  namespace  = "kube-system"

  values = [
    file("${path.module}/addons/new-addon/values.yaml")
  ]

  depends_on = [aws_eks_cluster.this]
}
```
Memory updated

### EKS Cluster Terraform Module

## Descripción del Proyecto

Este módulo de Terraform construye y configura un clúster de Amazon EKS completamente privado, preparado para lanzar un POD de prueba y con soporte para varios addons, como el ALB Ingress Controller de AWS. Todas las configuraciones y parametrizaciones están centralizadas en el archivo `eks-develop.tfvars`, facilitando la personalización y gestión del entorno.

## Funcionalidades

-   **Clúster EKS 100% privado**: El clúster no tiene endpoints públicos, garantizando la máxima seguridad en la comunicación.
-   **Preparado para lanzar un POD de prueba**: El clúster se configura con los recursos mínimos necesarios para la validación de un POD de prueba.
-   **Controlador ALB Ingress**: Implementación del controlador de Ingress ALB de AWS para la gestión eficiente del tráfico de red.
-   **Acceso mediante AWS SSM**: Las instancias de los nodos están configuradas con perfiles de instancia que permiten el acceso a través de AWS SSM, eliminando la necesidad de claves SSH directas.
-   **Gestión de addons parametrizados**: Cada addon tiene su propio archivo `values.yaml`, y todas las configuraciones de estos addons son centralizadas y gestionadas desde `eks-develop.tfvars`.

## Uso

### Requisitos previos

-   Terraform
-   Cuenta de AWS con permisos suficientes para crear recursos EKS, ALB, y SSM.
-   Configuración de credenciales de AWS en tu máquina local.

### Instalación

1.  Clona este repositorio:
    
    bash
    
    Copy code
    
    `git clone https://github.com/tu-repositorio/eks-cluster-module.git
    cd eks-cluster-module` 
    
2.  Configura las variables en el archivo `eks-develop.tfvars`: Todas las configuraciones clave, incluidos los parámetros del clúster EKS y los addons, deben ser especificadas en este archivo. Ejemplo:
    
    hcl
    
    Copy code
    
    `cluster_name      = "my-private-cluster"
    node_instance_type = "t3.medium"
    desired_capacity  = 3
    
    addons = {
      coredns = {
        enabled = true
        values_yaml = file("addons/coredns/values.yaml")
      }
      alb_ingress = {
        enabled = true
        values_yaml = file("addons/alb-ingress-controller/values.yaml")
      }
    }` 
    
3.  Inicializa y aplica el módulo de Terraform:
    
    bash
    
    Copy code
    
    `terraform init
    terraform apply -var-file="eks-develop.tfvars"` 
    
4.  Una vez finalizado el despliegue, puedes verificar que el POD de prueba está funcionando y que el controlador de Ingress está configurado correctamente.
    

### Añadir Nuevos Parámetros

Este módulo está diseñado para que todas las configuraciones se centralicen en el archivo `eks-develop.tfvars`, lo que garantiza que cualquier nuevo parámetro que se agregue al clúster o a los addons sea gestionado de forma coherente y clara. Sigue estos pasos para añadir nuevos parámetros:

#### 1. Modificación de `variables.tf`

Si necesitas agregar un nuevo parámetro, primero defínelo en `variables.tf` para que pueda ser utilizado por Terraform. Por ejemplo, si quieres añadir una opción para habilitar o deshabilitar un nuevo addon, puedes hacerlo de la siguiente manera:

hcl

Copy code

`variable "new_addon_enabled" {
  description = "Determina si el nuevo addon está habilitado"
  type        = bool
  default     = false
}` 

#### 2. Configuración en `eks-develop.tfvars`

Asegúrate de incluir la nueva configuración en el archivo `eks-develop.tfvars`, ya que este archivo actúa como la fuente principal de verdad para las configuraciones:

hcl

Copy code

`new_addon_enabled = true` 

#### 3. Integración en `main.tf` y `values.yaml`

Los addons son configurados utilizando archivos `values.yaml`, cuyos valores se parametrizan desde `eks-develop.tfvars`. Para un nuevo addon, sigue estos pasos:

-   Crea un directorio en `addons/` para el nuevo addon, donde se incluirá su archivo `values.yaml`.
-   Configura el nuevo addon en `main.tf`, utilizando la variable que acabas de añadir.

hcl

Copy code

`resource "helm_release" "new_addon" {
  name       = "new-addon"
  repository = "https://charts.example.com"
  chart      = "new-addon"
  namespace  = "kube-system"

  values = [
    file("${path.module}/addons/new-addon/values.yaml")
  ]

  depends_on = [aws_eks_cluster.this]
}` 

#### 4. Revisión y Aplicación

Después de hacer los cambios en `variables.tf`, `eks-develop.tfvars`, y los archivos de addon, ejecuta `terraform plan` para revisar los cambios y `terraform apply` para aplicarlos.

### Gestión de Addons

Cada addon en este módulo utiliza un archivo `values.yaml` para la configuración granular. El archivo `eks-develop.tfvars` centraliza los valores que modifican dichos archivos. Al añadir o modificar addons, asegúrate de seguir los siguientes pasos:

1.  **Agregar el addon en `main.tf`:** Incluye el recurso del addon en el archivo principal.
2.  **Modificar `eks-develop.tfvars`:** Añade el bloque de configuración del addon dentro de la sección de addons.
3.  **Actualizar `values.yaml`:** Si se necesitan valores específicos para el addon, asegúrate de que estos sean parametrizados en `eks-develop.tfvars` y vinculados correctamente en el archivo `values.yaml`.

#### Ejemplo:

Si deseas agregar un nuevo addon como Velero, debes asegurarte de incluir su definición en `eks-develop.tfvars` y luego referenciar su `values.yaml` correspondiente.
```bash
addons = {
  velero = {
    enabled = true
    values_yaml = file("addons/velero/values.yaml")
  }
}
```
## Buenas Prácticas

-   **Centralización de configuraciones:** Usa el archivo `eks-develop.tfvars` como la única fuente de verdad para todas las configuraciones.
-   **Modularidad:** Mantén los addons y otros componentes separados en sus propios módulos o archivos para facilitar su gestión y mantenimiento.
-   **Uso de archivos `values.yaml`:** Parametriza todas las configuraciones específicas del addon mediante archivos YAML, asegurando que los valores se pueden ajustar fácilmente desde Terraform.

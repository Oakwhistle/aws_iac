variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "deploy" {
  description = "Deployment identifier"
  type        = string
}

variable "accountable" {
  description = "Accountable team"
  type        = string
}

variable "business" {
  description = "Business unit"
  type        = string
}

variable "service" {
  description = "Service name"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "eks_config" {
  type = object({
    vpc = object({
      vpc_name     = string
      subnet_names = list(string)
    })
    node_group = object({
      node_group_name = string
      instance_type   = string
      node_count      = number
      strategy        = string
      max_capacity    = number
      min_capacity    = number
    })
    alb_listener_http = object({
      port     = number
      protocol = string
    })
    alb_target_group = object({
      port     = number
      protocol = string
      vpc_id   = string
    })
    visibility   = string
    cluster_mode = string
    addons = map(object({
      enabled   = bool
      namespace = string
      values = object({
        replicaCount = number
        image = object({
          repository = string
          tag        = string
        })
        resources = object({
          memory_request = string
          cpu_request    = string
          memory_limit   = string
          cpu_limit      = string
        })
        tolerations = list(map(string))
        affinity    = map(any)
        scaling = optional(object({
          enabled     = bool
          minReplicas = number
          maxReplicas = number
        }))
        metrics = optional(object({
          enabled = bool
          port    = number
        }))
        # Atributos específicos de Karpenter
        karpenter_name_addons       = optional(string)
        karpenter_repository_addons = optional(string)
        karpenter_chart_addons      = optional(string)
        karpenter_version_addons    = optional(string)
        karpenter_create_bucket     = optional(bool)
        # Atributos específicos de CoreDNS
        coredns_name_addons       = optional(string)
        coredns_repository_addons = optional(string)
        coredns_chart_addons      = optional(string)
        coredns_version_addons    = optional(string)
        # Grafana specific
        grafana_name_addons       = optional(string)
        grafana_repository_addons = optional(string)
        grafana_chart_addons      = optional(string)
        grafana_version_addons    = optional(string)
        grafana_create_bucket     = optional(bool)
        adminUser                 = optional(string)
        adminPassword             = optional(string)
        service_type              = optional(string)
        persistence = optional(object({
          storageClassName = string
          accessModes      = list(string)
          size             = string
        }))
        securityContext = optional(object({
          runAsUser = optional(number)
          fsGroup   = optional(number)
        }))
        # Loki specific
        loki_name_addons       = optional(string)
        loki_repository_addons = optional(string)
        loki_chart_addons      = optional(string)
        loki_version_addons    = optional(string)
        retention = optional(object({
          enabled = bool
          days    = number
        }))
        ingress = optional(object({
          enabled    = bool
          host       = string
          secretName = string
        }))
        prometheus_name_addons       = optional(string)
        prometheus_repository_addons = optional(string)
        prometheus_chart_addons      = optional(string)
        prometheus_version_addons    = optional(string)

        alertmanager = optional(object({
          enabled      = bool
          replicaCount = number
          image = object({
            repository = string
            tag        = string
          })
        }))

        prometheus_server = optional(object({
          replicaCount = number
          image = object({
            repository = string
            tag        = string
          })
          resources = object({
            memory_request = string
            cpu_request    = string
            memory_limit   = string
            cpu_limit      = string
          })
          persistentVolume = optional(object({
            enabled      = bool
            size         = string
            storageClass = string
            accessModes  = list(string)
            mountPath    = string
          }))
        }))

        additionalScrapeConfigs = optional(list(object({
          job_name = string
          static_configs = list(object({
            targets = list(string)
          }))
        })))

        alerting = optional(object({
          alertmanagers = list(object({
            static_configs = list(object({
              targets = list(string)
            }))
          }))
        }))
        vpc_cni_name_addons       = optional(string)
        vpc_cni_repository_addons = optional(string)
        vpc_cni_chart_addons      = optional(string)
        vpc_cni_version_addons    = optional(string)
        cni_loglevel              = optional(string)
        custom_network_cfg        = optional(bool)
        eni_config_label          = optional(string)
        eni_mtu                   = optional(string)
        external_snat             = optional(bool)
        veth_prefix               = optional(string)
        plugin_log_file           = optional(string)
        initContainer_image = optional(object({
          repository = optional(string)
          tag        = optional(string)
          resources = optional(object({
            memory_request = optional(string)
            cpu_request    = optional(string)
            memory_limit   = optional(string)
            cpu_limit      = optional(string)
          }))
        }))
        warm_ip_target   = optional(number)
        warm_enis_target = optional(number)

        # Variables del env
        env = optional(list(object({
          name  = string
          value = string
        })))

        alb_name_addons       = optional(string)
        alb_repository_addons = optional(string)
        alb_chart_addons      = optional(string)
        alb_version_addons    = optional(string)

        kube_proxy_name_addons       = optional(string)
        kube_proxy_repository_addons = optional(string)
        kube_proxy_chart_addons      = optional(string)
        kube_proxy_version_addons    = optional(string)
        iptablesSyncPeriod           = optional(string)
        conntrack = optional(object({
          maxPerCore            = optional(number)
          min                   = optional(number)
          tcpTimeoutEstablished = optional(string)
          tcpTimeoutCloseWait   = optional(string)
        }))

        pod_identity_agent_name_addons       = optional(string)
        pod_identity_agent_repository_addons = optional(string)
        pod_identity_agent_chart_addons      = optional(string)
        pod_identity_agent_version_addons    = optional(string)
        identityConfig = optional(object({
          assumeRole = string
          awsRegion  = string
        }))
        webhook = optional(object({
          enabled     = bool
          serviceName = string
          namespace   = string
          port        = number
        }))
        velero_name_addons       = optional(string)
        velero_repository_addons = optional(string)
        velero_chart_addons      = optional(string)
        velero_version_addons    = optional(string)
        velero_create_bucket     = optional(bool)

        velero_server = optional(object({
          replicaCount = number
          image = object({
            repository = string
            tag        = string
          })
          resources = object({
            memory_request = string
            cpu_request    = string
            memory_limit   = string
            cpu_limit      = string
          })
          persistentVolume = object({
            enabled      = bool
            size         = string
            storageClass = string
            accessModes  = list(string)
            mountPath    = string
          })
        }))

        configuration = optional(object({
          provider = string
          backupStorageLocation = object({
            name   = string
            bucket = string
            config = object({
              region = string
            })
          })
        }))
      })
    }))
  })
}

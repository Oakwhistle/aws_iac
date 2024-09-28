account_id  = "090876143603"
business    = "OCLOUD"
environment = "devel"
region      = "eu-central-1"
accountable = "oakroot"
project     = "Automation"
service     = "eks-cluster"
deploy      = "terraform"


# EKS Cluster Configuration
eks_config = {
  visibility   = "public_private"
  cluster_mode = "BOTH"

  node_group = {
    node_group_name = "example"
    instance_type   = "t3.medium"
    node_count      = 2
    strategy        = "spot"
    max_capacity    = 3
    min_capacity    = 1
  }

  alb_listener_http = {
    port     = 80
    protocol = "HTTP"
  }

  alb_target_group = {
    port     = 80
    protocol = "HTTP"
    vpc_id   = "AWDPY3P-PRO-DEPLOYMENT-VPC"
  }

  vpc = {
    vpc_name     = "AWDPY3P-PRO-DEPLOYMENT-VPC"
    subnet_names = ["AWDPY3P-BCK-A", "AWDPY3P-BCK-B", "AWDPY3P-BCK-C"]
  }

  addons = {
    karpenter = {
      enabled   = true
      namespace = "karpenter"
      values = {
        karpenter_name_addons       = "karpenter"
        karpenter_repository_addons = "karpenter/controller"
        karpenter_chart_addons      = "v0.5.0"
        karpenter_version_addons    = "v0.5.0"
        karpenter_create_bucket     = true

        # Atributos obligatorios
        replicaCount = 2
        image = {
          repository = "karpenter/controller"
          tag        = "v0.5.0"
        }
        resources = {
          memory_request = "512Mi"
          cpu_request    = "250m"
          memory_limit   = "1Gi"
          cpu_limit      = "500m"
        }
        tolerations = []
        affinity    = {}

        scaling = {
          enabled     = true
          minReplicas = 1
          maxReplicas = 5
        }
        metrics = {
          enabled = true
          port    = 8080
        }
      }
    },
    coredns = {
      enabled   = true
      namespace = "kube-system"
      values = {
        coredns_name_addons       = "coredns"
        coredns_repository_addons = "coredns/coredns"
        coredns_chart_addons      = "1.8.0"
        coredns_version_addons    = "v1.8.0"
        replicaCount              = 2
        image = {
          repository = "coredns/coredns"
          tag        = "v1.8.0"
        }
        resources = {
          memory_request = "128Mi"
          cpu_request    = "100m"
          memory_limit   = "256Mi"
          cpu_limit      = "200m"
        }
        tolerations = []
        affinity    = {}
      }
    },
    grafana = {
      enabled   = true
      namespace = "monitoring"
      values = {
        grafana_name_addons       = "grafana"
        grafana_repository_addons = "grafana/grafana"
        grafana_chart_addons      = "6.1.4"
        grafana_version_addons    = "v6.1.4"
        grafana_create_bucket     = true

        # Atributos obligatorios
        replicaCount = 2
        image = {
          repository = "grafana/grafana"
          tag        = "v6.1.4"
        }
        resources = {
          memory_request = "256Mi"
          cpu_request    = "100m"
          memory_limit   = "512Mi"
          cpu_limit      = "200m"
        }
        tolerations = []
        affinity    = {}

        # Agregamos securityContext
        securityContext = {
          runAsUser = 1001
          fsGroup   = 2000
        }
        adminUser     = "admin"
        adminPassword = "admin_password" # Reemplaza con el valor real
        service_type  = "LoadBalancer"

        # Agregamos persistence
        persistence = {
          storageClassName = "gp2"
          accessModes      = ["ReadWriteOnce"]
          size             = "10Gi"
        }
      }
    },
    loki = {
      enabled   = true
      namespace = "logging"
      values = {
        loki_name_addons       = "loki"
        loki_repository_addons = "grafana/loki"
        loki_chart_addons      = "v2.2.1"
        loki_version_addons    = "v2.2.1"

        # Atributos obligatorios
        replicaCount = 2
        image = {
          repository = "grafana/loki"
          tag        = "v2.2.1"
        }
        resources = {
          memory_request = "256Mi"
          cpu_request    = "100m"
          memory_limit   = "512Mi"
          cpu_limit      = "200m"
        }
        tolerations = []
        affinity    = {}

        retention = {
          enabled = true
          days    = 7
        }
        ingress = {
          enabled    = true
          host       = "loki.example.com"
          secretName = "loki-tls"
        }
      }
    },

    prometheus = {
      enabled   = true
      namespace = "monitoring"
      values = {
        prometheus_name_addons       = "prometheus"
        prometheus_repository_addons = "prom/prometheus"
        prometheus_chart_addons      = "v2.26.0"
        prometheus_version_addons    = "v2.26.0"

        # Atributos obligatorios
        replicaCount = 2
        image = {
          repository = "prom/prometheus"
          tag        = "v2.26.0"
        }
        resources = {
          memory_request = "400Mi"
          cpu_request    = "200m"
          memory_limit   = "800Mi"
          cpu_limit      = "400m"
        }
        tolerations = []
        affinity    = {}

        alertmanager = {
          enabled      = true
          replicaCount = 1
          image = {
            repository = "prom/alertmanager"
            tag        = "v0.21.0"
          }
        }

        prometheus_server = {
          replicaCount = 2
          image = {
            repository = "prom/prometheus"
            tag        = "v2.26.0"
          }
          resources = {
            memory_request = "400Mi"
            cpu_request    = "200m"
            memory_limit   = "800Mi"
            cpu_limit      = "400m"
          }
          persistentVolume = {
            enabled      = true
            size         = "10Gi"
            storageClass = "gp2"
            accessModes  = ["ReadWriteOnce"]
            mountPath    = "/prometheus"
          }
        }

        additionalScrapeConfigs = [{
          job_name = "prometheus-job"
          static_configs = [{
            targets = ["localhost:9090"]
          }]
        }]

        alerting = {
          alertmanagers = [{
            static_configs = [{
              targets = ["localhost:9093"]
            }]
          }]
        }
      }
    },
    vpc_cni = {
      enabled   = true
      namespace = "kube-system"
      values = {
        vpc_cni_name_addons       = "vpc-cni"
        vpc_cni_repository_addons = "amazon-k8s-cni-init"
        vpc_cni_chart_addons      = "v1.7.5"
        vpc_cni_version_addons    = "v1.7.5"

        replicaCount = 1
        image = {
          repository = "amazon-k8s-cni-init"
          tag        = "v1.7.5"
        }
        resources = {
          memory_request = "100Mi"
          cpu_request    = "50m"
          memory_limit   = "200Mi"
          cpu_limit      = "100m"
        }
        tolerations = []
        affinity    = {}

        cni_loglevel       = "DEBUG"
        custom_network_cfg = true
        eni_config_label   = "failure-domain.beta.kubernetes.io/zone"
        eni_mtu            = 9001
        external_snat      = false
        veth_prefix        = "eni"
        plugin_log_file    = "/var/log/aws-routed-eni/plugin.log"
        env = [
          {
            name  = "AWS_VPC_K8S_CNI_LOGLEVEL"
            value = "DEBUG"
          },
          {
            name  = "AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG"
            value = true
          },
          {
            name  = "ENI_CONFIG_LABEL_DEF"
            value = "failure-domain.beta.kubernetes.io/zone"
          },
          {
            name  = "AWS_VPC_ENI_MTU"
            value = "9001"
          },
          {
            name  = "AWS_VPC_K8S_CNI_EXTERNALSNAT"
            value = false
          },
          {
            name  = "AWS_VPC_K8S_CNI_VETHPREFIX"
            value = "eni"
          },
          {
            name  = "AWS_VPC_K8S_PLUGIN_LOG_FILE"
            value = "/var/log/aws-routed-eni/plugin.log"
          }
        ]

        initContainer_image = {
          repository = "amazon-k8s-cni-init"
          tag        = "v1.7.5"
        }
        warm_ip_target   = 2
        warm_enis_target = 1
      }
    },
    alb_ingress_controller = {
      enabled   = true
      namespace = "kube-system"
      values = {
        alb_name_addons       = "alb-ingress"
        alb_repository_addons = "https://kubernetes-sigs.github.io/aws-load-balancer-controller"
        alb_chart_addons      = "aws-load-balancer-controller"
        alb_version_addons    = "v2.2.0"

        # Atributos obligatorios
        replicaCount = 2
        image = {
          repository = "602401143452.dkr.ecr.us-west-2.amazonaws.com/amazon/aws-load-balancer-controller"
          tag        = "v2.2.0"
        }
        resources = {
          memory_request = "100Mi"
          cpu_request    = "50m"
          memory_limit   = "200Mi"
          cpu_limit      = "100m"
        }
        tolerations = []
        affinity    = {}
      }
    },
    kube_proxy = {
      enabled   = true
      namespace = "kube-system"
      values = {
        kube_proxy_name_addons       = "kube-proxy"
        kube_proxy_repository_addons = "k8s.gcr.io/kube-proxy"
        kube_proxy_chart_addons      = "v1.21.1"
        kube_proxy_version_addons    = "v1.21.1"

        # Atributos obligatorios
        replicaCount = 1
        image = {
          repository = "k8s.gcr.io/kube-proxy"
          tag        = "v1.21.1"
        }
        resources = {
          memory_request = "100Mi"
          cpu_request    = "50m"
          memory_limit   = "200Mi"
          cpu_limit      = "100m"
        }
        tolerations = []
        affinity    = {}

        # Configuración específica de kube-proxy
        iptablesSyncPeriod = "30s"
        conntrack = {
          maxPerCore            = 32768
          min                   = 131072
          tcpTimeoutEstablished = "86400s"
          tcpTimeoutCloseWait   = "3600s"
        }
      }
    },
    pod_identity_agent = {
      enabled   = true
      namespace = "default"
      values = {
        pod_identity_agent_name_addons       = "pod-identity-agent"
        pod_identity_agent_repository_addons = "mcr.microsoft.com/azure-pod-identity/nmi"
        pod_identity_agent_chart_addons      = "v1.6.3"
        pod_identity_agent_version_addons    = "v1.6.3"

        # Atributos obligatorios
        replicaCount = 2
        image = {
          repository = "mcr.microsoft.com/azure-pod-identity/nmi"
          tag        = "v1.6.3"
        }
        webhook = {
          enabled     = true
          serviceName = "pod-identity-webhook"
          namespace   = "default"
          port        = 443
        }
        identityConfig = {
          assumeRole = "arn:aws:iam::992382412713:role/AWDPY3P-PRO-DEPLOYMENT-EKS-eks-worker-role"
          awsRegion  = "eu-central-1"
        }

        resources = {
          memory_request = "128Mi"
          cpu_request    = "100m"
          memory_limit   = "256Mi"
          cpu_limit      = "200m"
        }
        tolerations = []
        affinity    = {}

      }
    },

    velero = {
      enabled   = true
      namespace = "velero"
      values = {
        velero_name_addons       = "velero"
        velero_repository_addons = "velero/velero"
        velero_chart_addons      = "v2.15.0"
        velero_version_addons    = "v2.15.0"
        velero_create_bucket     = true

        replicaCount = 1
        image = {
          repository = "velero/velero"
          tag        = "v1.7.1"
        }
        resources = {
          memory_request = "128Mi"
          cpu_request    = "100m"
          memory_limit   = "256Mi"
          cpu_limit      = "200m"
        }
        tolerations = []
        affinity    = {}

        velero_server = {
          replicaCount = 1
          image = {
            repository = "velero/velero"
            tag        = "v1.7.1"
          }
          resources = {
            memory_request = "128Mi"
            cpu_request    = "100m"
            memory_limit   = "256Mi"
            cpu_limit      = "200m"
          }
          persistentVolume = {
            enabled      = true
            size         = "50Gi"
            storageClass = "gp2"
            accessModes  = ["ReadWriteOnce"]
            mountPath    = "/var/velero-backups"
          }
        }

        configuration = {
          provider = "aws"
          backupStorageLocation = {
            name   = "default"
            bucket = "velero-backups-bucket"
            config = {
              region = "eu-central-1"
            }
          }
        }
      }
    }






  }
}
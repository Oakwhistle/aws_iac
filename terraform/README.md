
# Module Usage Documentation

## Overview
This module is designed to manage EKS clusters with customizable add-ons and security settings.

## Parametrization of Add-ons
Add-ons can be customized for each cluster by using the `.tfvars` files. Each add-on has its own `values.yaml` file that can be overridden by providing specific configurations in the corresponding tfvars.

### Example
For customizing the Nginx ingress controller to use the AWS ALB Ingress Controller, you can do the following in your tfvars:

```
nginx_ingress_controller_enabled = false
alb_ingress_controller_enabled = true
```

## SSM Access Configuration
The SSH key configuration has been removed, and all instances are now configured for access via AWS SSM. Ensure that your instance profiles are set up accordingly:

```
instance_profile = {
  name = "SSMInstanceProfile"
  roles = ["SSMRole"]
}
```

# State management:

## `devel.sh` Script

This script is designed to set up and manage Terraform modules with proper backend configurations for different AWS environments. It checks the necessary environment variables, verifies the existence of required files and directories, and runs the necessary Terraform commands.

## Usage

```bash
# Command to run `devel.sh`
./devel.sh <terraform_path> <tfvars_name_file>

# Example
./devel.sh services devDeployment
```

### Explanation:
- `<terraform_path>`: The path to the folder containing your Terraform code (IAC folder).
- `<tfvars_name_file>`: The name of the .tfvars file (without the .tfvars extension) containing environment-specific variables.


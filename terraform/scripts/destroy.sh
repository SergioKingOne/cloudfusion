#!/bin/bash

set -e

# Destroy Terraform-managed infrastructure
terraform destroy -auto-approve

#!/bin/bash
resources=(
  "aws_instance.test"
)

for resource in "${resources[@]}"; do
  targets+=" -target=$resource"
done

terraform apply $targets

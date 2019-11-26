#!/bin/bash
canonical=
latestUbuntu=$( aws ec2 describe-images \
    --region us-east-1 \
    --filter Name=owner-id,Values=099720109477 \
    --query 'Images[? starts_with(ImageLocation, 

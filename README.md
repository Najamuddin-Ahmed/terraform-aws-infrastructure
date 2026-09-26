# Terraform AWS VPC

This project creates a basic AWS VPC infrastructure using Terraform.

## What I Built

- AWS VPC
- Public subnet
- Private subnet
- Public route table
- Private route table
- Internet Gateway
- Route table associations
- Internet route for the public subnet

## Architecture

```text
                    AWS VPC
                       |
          +------------+------------+
          |                         |
    Public Subnet              Private Subnet
          |                         |
    Public Route Table       Private Route Table
          |
    0.0.0.0/0
          |
    Internet Gateway
          |
       Internet

                    AWS
                     │
                     ▼
              ┌─────────────┐
              │     VPC     │
              └──────┬──────┘
                     │
          ┌──────────┴──────────┐
          ▼                     ▼
   Public Subnets         Private Subnets
          │                     │
          │                     ▼
          │              ┌─────────────┐
          │              │     EKS     │
          │              └──────┬──────┘
          │                     │
          │              ┌──────┴──────┐
          │              ▼             ▼
          │          Worker 1      Worker 2
          │
          ▼
    Load Balancers

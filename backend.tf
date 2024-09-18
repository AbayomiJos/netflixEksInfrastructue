terraform {
 backend "s3" {
   bucket         = "netflix-eks-remote-state"
   key            = "netflix-eks/terraform/state.tfstate"
   region         = "us-west-1"
   encrypt        = true

    # Optional: Configure DynamoDB table for state locking
    dynamodb_table = "netflix-eks-remote-lock"
 }
}

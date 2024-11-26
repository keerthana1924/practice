

module "dev" {
  source = "../day-1"   # Path to the module's code
  ami    = "ami-055e3d4f0bbeb5878"
  key    = "keerthi"                  # SSH key name
  type   = "t2.micro"                # EC2 instance type
}

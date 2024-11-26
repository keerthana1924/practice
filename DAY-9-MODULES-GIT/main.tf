module "prod" {
    source = "github.com/keerthana1924/practice/day-1"
    ami    = "ami-055e3d4f0bbeb5878"
    key    = "keerthi"                  # SSH key name
    type   = "t2.micro"
 
}
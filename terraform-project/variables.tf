variable "ingressports" {
  type    = list(number)
  default = [8080, 22, 3000] //8080 is for jenkins, 22 is for ssh and 3000 is for flask application
}
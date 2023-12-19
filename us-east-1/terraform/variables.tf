variable "region" {
  description = "The region where AWS operations will take place. Examples are us-east-1, us-west-2, etc."
  type        = string
  default     = "us-east-1" // default value, can be overridden when calling the module
}

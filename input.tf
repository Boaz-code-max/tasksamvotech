variable "netork_Cidr" {
  type        = string
  default     = "10.10.0.0/16"
  description = "for vps only"
}



variable "subnets_count" {
  type        = number
  default     = 7
  description = "for the count of cidr ranges"

}
variable "subnets_names" {
  type        = list(string)
  default     = ["god", "bless", "you", "all", "the", "time", "boaz"]
  description = "for the name of subnets"
}
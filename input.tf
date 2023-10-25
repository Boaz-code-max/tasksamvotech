variable "netork_Cidr" {
  type        = string
  default     = "10.10.0.0/16"
  description = "for vps only"
}
variable "amvsubnets_ranges" {
  type        = list(string)
  default     = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.4.0/24", "10.10.5.0/24", "10.10.6.0/24"]
  description = "for subnets"

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
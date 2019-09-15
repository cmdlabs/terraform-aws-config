variable "delivery_frequency" {
  type        = string
  description = "The frequency with which AWS Config recurringly delivers configuration snapshots. May be one of One_Hour, Three_Hours, Six_Hours, Twelve_Hours, or TwentyFour_Hours"
  default     = "TwentyFour_Hours"
}

variable "enable_recorder" {
  type        = bool
  description = "Whether the configuration recorder should be enabled or disabled"
  default     = true
}

variable "expiration" {
  type        = number
  description = "The number of days to wait before expiring an object"
  default     = 2555
}

variable "transition_to_glacier" {
  type        = number
  description = "The number of days to wait before transitioning an object to Glacier"
  default     = 30
}

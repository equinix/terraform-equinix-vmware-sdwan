variable "metro_code" {
  description = "Device location metro code"
  type        = string
  validation {
    condition     = can(regex("^[A-Z]{2}$", var.metro_code))
    error_message = "Valid metro code consits of two capital leters, i.e. SV, DC."
  }
}

variable "account_number" {
  description = "Billing account number for a device"
  type        = string
  default     = 0
}

variable "platform" {
  description = "Device platform flavor that determines number of CPU cores and memory"
  type        = string
  validation {
    condition     = can(regex("^(small|medium|large)$", var.platform))
    error_message = "One of following platform flavors are supported: small, medium, large."
  }
}

variable "software_package" {
  description = "Device software package"
  type        = string
  validation {
    condition     = can(regex("^(VeloCloud-2|VeloCloud-4|VeloCloud-8)$", var.software_package))
    error_message = "One of following software packages are supported: VeloCloud-2, VeloCloud-4, VeloCloud-8."
  }
}

variable "name" {
  description = "Device name"
  type        = string
  validation {
    condition     = length(var.name) >= 2 && length(var.name) <= 50
    error_message = "Device name should consist of 2 to 50 characters."
  }
}

variable "term_length" {
  description = "Term length in months"
  type        = number
  validation {
    condition     = can(regex("^(1|12|24|36)$", var.term_length))
    error_message = "One of following term lengths are available: 1, 12, 24, 36 months."
  }
}

variable "notifications" {
  description = "List of email addresses that will receive device status notifications"
  type        = list(string)
  validation {
    condition     = length(var.notifications) > 0
    error_message = "Notification list cannot be empty."
  }
}

variable "acl_template_id" {
  description = "Identifier of an ACL template that will be applied on a device"
  type        = string
  validation {
    condition     = length(var.acl_template_id) > 0
    error_message = "ACL template identifier has to be an non empty string."
  }
}

variable "additional_bandwidth" {
  description = "Additional internet bandwidth for a device"
  type        = number
  default     = 0
  validation {
    condition     = var.additional_bandwidth == 0 || (var.additional_bandwidth >= 25 && var.additional_bandwidth <= 2001)
    error_message = "Additional internet bandwidth should be between 25 and 2001 Mbps."
  }
}

variable "activation_key" {
  description = "Activation Key"
  type        = string
  validation {
    condition     = length(var.activation_key) > 0
    error_message = "Activation Key has to be an non empty string."
  }
}

variable "controller_fqdn" {
  description = "SD-WAN controller FQDN"
  type        = string
  validation {
    condition     = length(var.controller_fqdn) > 0
    error_message = "SD-WAN controller FQDN has to be an non empty string."
  }
}

variable "root_password" {
  description = "Device root password"
  type        = string
  default     = ""
  validation {
    condition     = length(var.root_password) == 0 || (length(var.root_password) >= 8 && length(var.root_password) <= 128)
    error_message = "Device root password has to be from 8 to 128 characters long."
  }
}

variable "secondary" {
  description = "Secondary device attributes"
  type        = map(any)
  default     = { enabled = false }
  validation {
    condition     = can(var.secondary.enabled)
    error_message = "Key 'enabled' has to be defined for secondary device."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || can(regex("^[A-Z]{2}$", var.secondary.metro_code))
    error_message = "Key 'metro_code' has to be defined for secondary device. Valid metro code consits of two capital leters, i.e. SV, DC."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.acl_template_id) > 0, false)
    error_message = "Key 'acl_template_id' has to be defined for secondary device. Valid ACL template identifier has to be an non empty string."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(var.secondary.additional_bandwidth >= 25 && var.secondary.additional_bandwidth <= 2001, true)
    error_message = "Key 'additional_bandwidth' has to be between 25 and 2001 Mbps."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.activation_key) > 0, false)
    error_message = "Key 'activation_key' has to be defined for secondary device. Valid activation key has to be an non empty string."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.controller_fqdn) > 0, false)
    error_message = "Key 'controller_fqdn' has to be defined for secondary device. Valid SD-WAN controller FQDN has to be an non empty string."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.root_password) >= 8 && length(var.secondary.root_password) <= 128, true)
    error_message = "Valid root password has to be from 8 to 128 characters long."
  }
}

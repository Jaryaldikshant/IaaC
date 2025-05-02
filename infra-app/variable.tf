variable "env" {
  description = "This is the environment for my infrastructure"
  type        = string
}

variable "blob_name" {
  description = "This is the Blob Storage name for my infrastructure"
  type        = string
}

variable "vm_count" {
  description = "This is number of vm you want .."
  type        = number
}

variable "vm_size" {
  description = "This is the Vm size for my infrastructure"
  type        = string

}

variable "vm_name" {
  description = "This is the name of the vm for my infrastructure"
  type        = string

}

variable "vm_publisher" {
  description = "The image reference to use for the virtual machine"
  type        = string
  # default = "Canonical"
  
}

variable "vm_offer" {
  description = "The offer of the virtual machine image"
  type        = string
  # default     = "0001-com-ubuntu-server-focal"
}



variable "vm_sku" {
  description = "The SKU of the virtual machine image"
  type        = string
  # default     = "20_04-lts"
}


variable "vm_version" {
  description = "The version of the virtual machine image"
  type        = string
  # default     = "latest"
}

variable "username" {
  description = "This is the name of the user in vm for my infrastructure"
  type        = string
}

variable "location" {
  description = "This is the location for my infrastructure"
  type        = string
}





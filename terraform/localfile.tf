resource "local_file" "ansible_inventory" {
  filename        = "../ansible/inventory.ini"
  file_permission = 0644
  content = templatefile("./inventory.tftpl",
    {
      lb_nat_ip_address_list = yandex_compute_instance.lb[*].network_interface[0].nat_ip_address
      lb_ip_address_list     = yandex_compute_instance.lb[*].network_interface[0].ip_address
      lb_vm_names            = yandex_compute_instance.lb[*].name
      db_ip_address_list     = yandex_compute_instance.db[*].network_interface[0].ip_address
      db_vm_names            = yandex_compute_instance.db[*].name
      app_ip_address_list    = yandex_compute_instance.app[*].network_interface[0].ip_address
      app_vm_names           = yandex_compute_instance.app[*].name
      os_ip_address_list    = yandex_compute_instance.os[*].network_interface[0].ip_address
      os_vm_names           = yandex_compute_instance.os[*].name      
    }
  )
}

resource "local_file" "ansible_config" {
  filename        = "../ansible/ansible.cfg"
  file_permission = 0644
  content = templatefile("./ansible.cfg.tftpl",
    {
      lb_nat_ip_address = yandex_compute_instance.lb[0].network_interface[0].nat_ip_address
    }
  )
}

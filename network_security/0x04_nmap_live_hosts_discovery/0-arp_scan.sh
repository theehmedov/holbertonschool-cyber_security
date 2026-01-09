#!/bin/bash

# Arqumentin (alt şəbəkənin) daxil edildiyini yoxlayır
if [ -z "$1" ]; then
  echo "İstifadə qaydası: $0 <alt_şəbəkə>"
  exit 1
fi

# nmap-i sudo (root) hüquqları ilə işə salır
# -sn : Port skanını söndürür (yalnız Host Discovery). 
#       Qeyd: Yerli şəbəkədə root hüquqları ilə işlədikdə, bu avtomatik olaraq ARP skanı edir.
sudo nmap -sn $1

---

# Пример системного состояния для RPM-дистрибутивов.
# Обновляет ядро Linux и корректирует конфигурацию загрузчика.

kernel_updated:
  pkg.uptodate:
    - pkgs:
        - kernel
    - refresh: true

grub_config_updated:
  file.comment:
    - name: '/etc/default/grub'
    - regex: '^GRUB_DEFAULT|^GRUB_DISABLE_SUBMENU'
  cmd.run:
    - name: 'grub2-mkconfig -o /boot/grub2/grub.cfg'
    - onchanges:
      - file: '/etc/default/grub'

system.reboot:
  module.run:
    - onchanges:
        - kernel_updated
        - grub_config_updated

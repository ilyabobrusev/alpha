---

# Пример системного состояния для RPM-дистрибутивов.
# Обновляет ядро Linux и корректирует конфигурацию загрузчика.

kernel updated:
  pkg.uptodate:
    - pkgs:
        - kernel
    - refresh: true
  file.comment:
    - name: '/etc/default/grub'
    - regex: '^GRUB_DEFAULT|^GRUB_DISABLE_SUBMENU'
  cmd.run:
    - name: 'grub2-mkconfig -o /boot/grub2/grub.cfg'
  module.run:
    - name: system.reboot

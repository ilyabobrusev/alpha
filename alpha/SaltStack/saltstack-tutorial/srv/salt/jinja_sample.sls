---

# Пример использования шаблонов в формуле

power_management_timeouts:
  cmd.run:
    - names:
      {% for setting in ['standby', 'hibernate', 'monitor', 'disk'] %}
      {% for power_mode in ['ac', 'dc'] %}
      - powercfg /change /{{ setting }}-timeout-{{ power_mode }} 0
      {% endfor %}
      {% endfor %}
